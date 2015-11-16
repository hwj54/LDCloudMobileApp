//
//  JobShopViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "JobShopViewController.h"
#import "CreateClassRoomView.h"
#import "ClassRoomTableView.h"
@interface JobShopViewController (){
    NSString *target;
    NSString *usertxt;
    NSString *pswtex;
    NSMutableArray *userStatus;
    NSString *response ;
    BOOL recordResults;
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    }

@end

@implementation JobShopViewController
@synthesize userAccount;
- (void)viewDidLoad {
    [super viewDidLoad];
    userAccount = [[UserAccount alloc]init];
    target = @"";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)createRoomBtn:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"账户登录" message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"登录"];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    
    UITextField *account = [alert textFieldAtIndex:0];
    [account setTextAlignment:NSTextAlignmentLeft];
    
    UITextField *password = [alert textFieldAtIndex:1];
    [password setTextAlignment:NSTextAlignmentLeft];
    [alert show];
    //[dateInput becomeFirstResponder];
}

-(IBAction)choiceRoomBtn:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"账户验证" message:@"请输入账户" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"验证"];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    UITextField *account = [alert textFieldAtIndex:0];
    [account setTextAlignment:NSTextAlignmentCenter];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        //NSLog(alertView.title);
    }
    if (buttonIndex == 1){
        //NSLog(alertView.title);
        if([alertView.title isEqualToString:@"账户登录"]){
            UITextField *account = [alertView textFieldAtIndex:0];
            usertxt = account.text;
            UITextField *password = [alertView textFieldAtIndex:1];
            pswtex = password.text;
            [self accountLogin];
        }else{
            UITextField *account = [alertView textFieldAtIndex:0];
            usertxt = account.text;
            target = @"choiceRoom";
            [self performSegueWithIdentifier:@"choiceRoom" sender:self];
            target = @"";
        }
    }
    
}

-(void)accountLogin{
    //NSLog(usertxt);
    //NSLog(pswtex);
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
                             "<ns2:login xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             
                             //"<ns2:certification xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<account>"];
    soapMessage = [soapMessage stringByAppendingString:usertxt];
    soapMessage = [soapMessage stringByAppendingString:@"</account>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<password>"];
    soapMessage = [soapMessage stringByAppendingString:pswtex];
    soapMessage = [soapMessage stringByAppendingString:@"</password>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:login>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/JobShop?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/login"
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

-(void)accountVerify{
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
                             "<ns2:login xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             
                             //"<ns2:certification xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<account>"];
    soapMessage = [soapMessage stringByAppendingString:usertxt];
    soapMessage = [soapMessage stringByAppendingString:@"</account>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<password>"];
    soapMessage = [soapMessage stringByAppendingString:pswtex];
    soapMessage = [soapMessage stringByAppendingString:@"</password>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:login>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/JobShop?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/login"
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

-(void)verify:(NSString *)account {
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([target isEqualToString:@"createRoom"]){
        CreateClassRoomView *targetScene = segue.destinationViewController;
        [targetScene setValue:userAccount forKey:@"userAccount"];
    }else{
        ClassRoomTableView *targetScene = segue.destinationViewController;
        [targetScene setValue:usertxt forKey:@"account"];
    }
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength: 0];
    //NSLog(@"connection: didReceiveResponse:1");
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
    //NSLog(@"connection: didReceiveData:%lu", (unsigned long)[webData length]);
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
        //NSLog(@"%lu",(unsigned long)userStatus.count);
        userAccount.accountStatus = [userStatus objectAtIndex:0];
        userAccount.account = [userStatus objectAtIndex:1];
        userAccount.accountDes = [userStatus objectAtIndex:2];
        // @"用户登录成功！";
        target = @"createRoom";
        [self performSegueWithIdentifier:@"createRoom" sender:self];
        
        target = @"";
        
    }else{
        //_loginStatus.text = @"用户登录失败！";
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
    response = [response stringByAppendingString:string];
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
    
    if( [elementName isEqualToString:@"ns2:loginResponse"])
    {
        recordResults = FALSE;
        
        //greeting.text = [[[NSString init]stringWithFormat:@"第%@时区的时间是: ",nameInput.text]
        //stringByAppendingString:soapResults];
        //[soapResults release];
        
        NSLog(@"结束！");
        soapResults = nil;
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
