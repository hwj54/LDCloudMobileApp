//
//  ChoiceRoleViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "ChoiceRoleViewController.h"
#import "ViewController.h"
#import "WorkerTableViewController.h"

@interface ChoiceRoleViewController (){
    NSString *target;
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    NSString *response ;
    NSString *synchClock ;
    BOOL recordResults;
    NSMutableArray *_receivedData;
    NSString *clickType;
    NSString *ScheduleID;
    NSInteger *selectIndex;
    NSString *operationMode;
    NSString *targetRole;
    NSString *wsOption;
    NSString *newClock;

}

@end

@implementation ChoiceRoleViewController
@synthesize userAccount;
@synthesize myTable;
//@synthesize boss;
//@synthesize workerA;
//@synthesize workerB;
//@synthesize workerC;
//@synthesize workerD;
//@synthesize userAccount;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self clockSynchWebService];
    //self.navigationItem.rightBarButtonItems[0].title = myTable.clock;
}

-(void)clockSynchWebService{
    recordResults = NO;
    wsOption = @"时钟同步";
    //int clock = [myTable.clock intValue];
    //clock += 1;
    //NSString *newClock = [NSString stringWithFormat:@"%i",clock];
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:SynchTableClock xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<account>"];
    soapMessage = [soapMessage stringByAppendingString:userAccount.account];
    soapMessage = [soapMessage stringByAppendingString:@"</account>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<room>"];
    soapMessage = [soapMessage stringByAppendingString:userAccount.room];
    soapMessage = [soapMessage stringByAppendingString:@"</room>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<table>"];
    soapMessage = [soapMessage stringByAppendingString:userAccount.table];
    soapMessage = [soapMessage stringByAppendingString:@"</table>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:SynchTableClock>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/JobShop?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/SynchTableClock"
      forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        webData = [[NSMutableData data]init];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
    NSLog(@"connection: didReceiveResponse:1");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    NSLog(@"connection: didReceiveData:%lu", (unsigned long)[webData length]);
    //NSLog(@"Response:%@",webData);
}

//如果电脑没有连接网络，则出现此信息（不是网络服务器不通）
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    //[connection release];
    //[webData release];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //重新加載xmlParser
    if( xmlParser )
    {
        //[xmlParser release];
    }
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    
    if([wsOption isEqualToString:@"时钟同步"]){
        //myTable.clock = synchClock;
       self.navigationItem.rightBarButtonItems[0].title = myTable.clock;
    }
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    //NSLog(@"4 parser didStarElemen: namespaceURI: attributes:");
    
    if( [elementName isEqualToString:@"soap:Fault"])
    {
        if(!soapResults)
        {
            soapResults = [[NSMutableString alloc] init];
        }
        recordResults = YES;
    }
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //NSLog(@"5 parser: foundCharacters:");
    if([wsOption isEqualToString:@"时钟同步"]){
        myTable.clock = string;
    }
    if( recordResults )
    {
        [soapResults appendString: string];
    }
}



-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"6 parser: didEndElement:");
    
    if( [elementName isEqualToString:@"ns:return"])
    {
        NSLog(@"***************");
    }
    
    if( [elementName isEqualToString:@"ns2:addRecordResponse"] ||
       [elementName isEqualToString:@"ns2:updateTableSynchClockResponse"] ||
       [elementName isEqualToString:@"ns2:GetTableRecordResponse"] ||
       [elementName isEqualToString:@"ns2:SynchTableClockResponse"])//
    {
        recordResults = FALSE;
        
        //greeting.text = [[[NSString init]stringWithFormat:@"第%@时区的时间是: ",nameInput.text]
        //stringByAppendingString:soapResults];
        //[soapResults release];
        
        NSLog(@"结束！");
        soapResults = nil;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)boss:(id)sender{
    target = @"boss";
    [self performSegueWithIdentifier:@"gotoBoss" sender:self];
}

-(IBAction)workerA:(id)sender{
    target = @"A";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(IBAction)workerB:(id)sender{
    target = @"B";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(IBAction)workerC:(id)sender{
    target = @"C";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(IBAction)workerD:(id)sender{
    target = @"D";
    [self performSegueWithIdentifier:@"gotoWorker" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    userAccount.role = target;
    if([target isEqualToString:@"boss"]){
        ViewController *targetScene = segue.destinationViewController;
        [targetScene setValue:userAccount forKey:@"userAccount"];
        [targetScene setValue:myTable forKey:@"myTable"];
    }else{
        WorkerTableViewController *targetScene = segue.destinationViewController;
        [targetScene setValue:userAccount forKey:@"userAccount"];
        [targetScene setValue:myTable forKey:@"myTable"];
        [targetScene setValue:userAccount.role forKey:@"role"];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
