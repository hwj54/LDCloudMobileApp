//
//  WorkOrderViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/16.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "WorkOrderViewController.h"
#import "MyReport.h"

@interface WorkOrderViewController (){
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    NSString *response ;
    BOOL recordResults;
    NSMutableArray *_reportList;
    NSMutableArray *_receivedData;
    MyReport *report;
    NSString *wsOption;
}

@end

@implementation WorkOrderViewController
@synthesize product;
@synthesize startTime;
@synthesize endTime;
@synthesize lt;
@synthesize process1;
@synthesize process1Time;
@synthesize process2;
@synthesize process2Time;
@synthesize process3;
@synthesize process3Time;
@synthesize process4;
@synthesize process4Time;
@synthesize myRecord;
@synthesize myTable;
- (void)viewDidLoad {
    [super viewDidLoad];
    if([myRecord.recordType isEqualToString:@"#1"]){
        self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:79/255.0 blue:148/255.0 alpha:1];
    }
    if([myRecord.recordType isEqualToString:@"#2"]){
        self.view.backgroundColor = [UIColor colorWithRed:152/255.0 green:230/255.0 blue:144/255.0 alpha:1];
    }
    if([myRecord.recordType isEqualToString:@"#3"]){
        self.view.backgroundColor = [UIColor colorWithRed:252/255.0 green:240/255.0 blue:109/255.0 alpha:1];
    }
    if([myRecord.recordType isEqualToString:@"#4"]){
        self.view.backgroundColor = [UIColor colorWithRed:97/255.0 green:177/255.0 blue:252/255.0 alpha:1];
    }
    self.product.text = myRecord.recordType;
    self.startTime.text = myRecord.startTime;
    self.endTime.text = myRecord.endTime;
    [self callWebService];
    // Do any additional setup after loading the view.
}

-(void)callWebService{
    wsOption = @"加载";
    _reportList = [[NSMutableArray alloc]init];
    _receivedData = [[NSMutableArray alloc]init];
    recordResults = NO;
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:GetRecordReport xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<id>"];
    soapMessage = [soapMessage stringByAppendingString:myRecord.recordID];
    soapMessage = [soapMessage stringByAppendingString:@"</id>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:GetRecordReport>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/JobShop?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/GetRecordReport"
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
    
    if([wsOption isEqualToString:@"加载"]){
        myRecord._reportList = _reportList;
        //NSLog([NSString stringWithFormat:@"%i",_reportList.count]);
        
        MyReport *reportItem = _reportList[0];
        self.process1.text = reportItem.process;
        self.process1Time.text = reportItem.processTime;
        
        reportItem = _reportList[1];
        self.process2.text = reportItem.process;
        self.process2Time.text = reportItem.processTime;
        
        reportItem = _reportList[2];
        self.process3.text = reportItem.process;
        self.process3Time.text = reportItem.processTime;
        
        reportItem = _reportList[3];
        self.process4.text = reportItem.process;
        self.process4Time.text = reportItem.processTime;
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
    //NSLog(@"recordResults:%@",string);
    if([wsOption isEqualToString:@"加载"]){
        BOOL isSeparator = [@"|" isEqualToString:string];
        if(isSeparator){
            report = [[MyReport alloc]init];
            report.recordID = [_receivedData objectAtIndex:0];
            report.reportID = [_receivedData objectAtIndex:1];
            report.process = [_receivedData objectAtIndex:2];
            report.processTime = [_receivedData objectAtIndex:3];
            [_reportList addObject:report];
            _receivedData = [[NSMutableArray alloc]init];
        }else{
            [_receivedData addObject:string];
        }
    }
    else if([wsOption isEqualToString:@"报工"] || [wsOption isEqualToString:@"传递"]){
            response = string;
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
    
    if( [elementName isEqualToString:@"ns2:GetRecordReportResponse"] ||
       [elementName isEqualToString:@"ns2:updateTaskStateResponse"] )//
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
