//
//  ViewController.m
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/15.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewController_1.h"
#import "User.h"
@interface ViewController (){
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    NSString *response ;
    BOOL recordResults;
    NSMutableArray *userStatus;
    User *userObject;
    NSString *usertxt;
    NSString *pswtex;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    userObject = [[User alloc]init];
    [_password setSecureTextEntry:YES];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MyTableViewController_1 *target = segue.destinationViewController;
    //if([target respondsToSelector:@selector(setObject:forKey:)]){
        [target setValue:userObject forKey:@"user"];
    //}
}


- (IBAction)loginBtn:(id)sender {
    //usertxt = @"tester1";
    //pswtex = @"123456";
    usertxt = _user.text;
    pswtex = self.password.text;
    userStatus = [[NSMutableArray alloc]init];
    response = [[NSString alloc]init];
    response = @" ";
    //webservice parm(user,password)
    recordResults = NO;
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             //"<ns2:sayHello xmlns:ns2=\"http://service.enterpriseApp.ld.org/\"/>\n"
                             
                             "<ns2:certification xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<user>"];
    soapMessage = [soapMessage stringByAppendingString:usertxt];
    soapMessage = [soapMessage stringByAppendingString:@"</user>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<password>"];
    soapMessage = [soapMessage stringByAppendingString:pswtex];
    soapMessage = [soapMessage stringByAppendingString:@"</password>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:certification>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/loginCertification?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/certification"
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
    //NSLog(@"3 DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    //NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    //NSLog(@"***********************************");
    //NSLog(@"XML:%@",theXML);
    //NSLog(@"***********************************");
    //[theXML release];
    
    //重新加載xmlParser
    if( xmlParser )
    {
        //[xmlParser release];
    }
    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
    if(userStatus.count>0){
        NSLog(@"%lu",(unsigned long)userStatus.count);
        userObject.userStatus = [userStatus objectAtIndex:0];
        userObject.userCode = [userStatus objectAtIndex:1];
        userObject.userName = [userStatus objectAtIndex:2];
        userObject.email = [userStatus objectAtIndex:3];
        userObject.phone = [userStatus objectAtIndex:4];
        userObject.custCode = [userStatus objectAtIndex:5];
        userObject.custName = [userStatus objectAtIndex:6];
        _loginStatus.text = @"用户登录成功！";
        [self performSegueWithIdentifier:@"goto1" sender:self];
    }else{
        _loginStatus.text = @"用户登录失败！";
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
    [userStatus addObject:string];
    //response = [response stringByAppendingString:string];
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
    
    if( [elementName isEqualToString:@"ns2:certificationResponse"])
    {
        recordResults = FALSE;
        
        //greeting.text = [[[NSString init]stringWithFormat:@"第%@时区的时间是: ",nameInput.text]
        //stringByAppendingString:soapResults];
        //[soapResults release];
        
        NSLog(@"结束！");
        soapResults = nil;
    }
    
}


@end
