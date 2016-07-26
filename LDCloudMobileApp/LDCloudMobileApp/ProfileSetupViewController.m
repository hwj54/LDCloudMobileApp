//
//  ProfileSetupViewController.m
//  LDCloudMobileApp
//
//  Created by 何文戟 on 16/7/26.
//  Copyright © 2016年 Landing. All rights reserved.
//

#import "ProfileSetupViewController.h"

@interface ProfileSetupViewController (){
NSMutableData *webData;
NSMutableString *soapResults;
NSMutableString *currentElementValue;  //用于存储元素标签的值
NSMutableArray *_receivedData;
NSXMLParser *xmlParser;
NSString *response ;
BOOL recordResults;
}
@end

@implementation ProfileSetupViewController
@synthesize user;
- (void)viewDidLoad {
    [super viewDidLoad];
    [_inputNewPass setSecureTextEntry:YES];
    [_confirmNewPass setSecureTextEntry:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)callWebService{
    //_receivedData = [[NSMutableArray alloc]init];
    recordResults = NO;
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:ModifyPassword xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<user>"];
    soapMessage = [soapMessage stringByAppendingString:user.userCode];
    soapMessage = [soapMessage stringByAppendingString:@"</user>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<newPassword>"];
    soapMessage = [soapMessage stringByAppendingString:_inputNewPass.text];
    soapMessage = [soapMessage stringByAppendingString:@"</newPassword>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:ModifyPassword>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/CCPMUserAccount?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/CCPMUserAccount"
      forHTTPHeaderField:@"SOAPAction"];
    [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    //请求
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    //如果连接已经建好，则初始化data
    if( theConnection )
    {
        response = [[NSString alloc]init];
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
    //NSLog(@"connection: didReceiveResponse:1");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //response = [response stringByAppendingString:data];
    response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", response);//得到想要的XML字符串然后解析
    [webData appendData:data];
    //NSLog(@"connection: didReceiveData:%lu", (unsigned long)[webData length]);
    //NSLog(@"Response:%@",webData);
    //xmlParser = [[NSXMLParser alloc] initWithData: webData];
    
    //    xmlParser = [[NSXMLParser alloc] initWithData:[response dataUsingEncoding:NSUTF8StringEncoding]];
    //    [xmlParser setDelegate: self];
    //    [xmlParser setShouldResolveExternalEntities: YES];
    //    [xmlParser parse];
    
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
    //xmlParser = [[NSXMLParser alloc] initWithData:[response dataUsingEncoding:NSUTF8StringEncoding]];
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict
{
    //NSLog(@"4 parser didStarElemen: namespaceURI: attributes:");
    if( [elementName isEqualToString:@"return"])
    {
        //NSLog(@"<return>");
    }
    if( [elementName isEqualToString:@"soap:Fault"])
    {
        if(!soapResults)
        {
            soapResults = [[NSMutableString alloc] init];
        }
        recordResults = YES;
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //NSLog(@"6 parser: didEndElement:");
    
    if( [elementName isEqualToString:@"return"])
    {
        //NSLog(@"%@", currentElementValue);
        
        //BOOL isSeparator = [@"|" isEqualToString:currentElementValue];
        if([@"密码修改成功!" isEqualToString:currentElementValue]){
            _checkNewPass.text = currentElementValue;
            //[_receivedData addObject:currentElementValue];
            
        }else{
            //_receivedData = [[NSMutableArray alloc]init];
            
        }
        currentElementValue = [[NSMutableString alloc]init];
        //NSLog(@"</return>");
    }
    
    if( [elementName isEqualToString:@"ns2:ModifyPasswordResponse"] )//
    {
        recordResults = FALSE;
        //NSLog(@"结束！");
        soapResults = nil;
        
    }
    
}


-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    else
        [currentElementValue appendString:string];
    
    }

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock{
    //NSLog(@"cData:%@",[NSString stringWithUTF8String:[CDATABlock bytes]]);
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)commit:(id)sender {
    if([_inputNewPass.text isEqualToString:_confirmNewPass.text]){
        //_checkNewPass.text = @"新密码验证通过!";
        [self callWebService];
    }else{
        _checkNewPass.text = @"两次输入的密码不一致,请重新输入!";
    }
}
@end
