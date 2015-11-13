//
//  ViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/12.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    NSString *response ;
    BOOL recordResults;
    //NSMutableArray *_recordList;
    NSMutableArray *_receivedData;
    NSString *clickType;
    NSString *ScheduleID;
    NSInteger *selectIndex;
    NSString *operationMode;
    NSString *targetRole;
}

@end

@implementation ViewController
@synthesize Product_1;
@synthesize Product_2;
@synthesize Product_3;
@synthesize Product_4;
@synthesize Worker_A;
@synthesize Worker_B;
@synthesize Worker_C;
@synthesize Worker_D;
@synthesize dragImage;
@synthesize dragObject;
@synthesize touchOffset;
@synthesize homePosition;
@synthesize userAccount;

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([touches count] == 1) {
        
        // one finger
        CGPoint touchPoint = [[touches anyObject]locationInView:self.view];
        if (touchPoint.x > Product_1.frame.origin.x &&
            touchPoint.x < Product_1.frame.origin.x +
            Product_1.frame.size.width &&
            touchPoint.y > Product_1.frame.origin.y &&
            touchPoint.y < Product_1.frame.origin.y +
            Product_1.frame.size.height)
        {
            self.dragImage = Product_1;
            self.dragObject = @"#1";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_1.frame.origin.x,
                                           touchPoint.y - Product_1.frame.origin.y);
            self.homePosition = CGPointMake(Product_1.frame.origin.x,
                                            Product_1.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        
        if (touchPoint.x > Product_2.frame.origin.x &&
            touchPoint.x < Product_2.frame.origin.x +
            Product_2.frame.size.width &&
            touchPoint.y > Product_2.frame.origin.y &&
            touchPoint.y < Product_2.frame.origin.y +
            Product_2.frame.size.height)
        {
            self.dragImage = Product_2;
            self.dragObject = @"#2";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_2.frame.origin.x,
                                           touchPoint.y - Product_2.frame.origin.y);
            self.homePosition = CGPointMake(Product_2.frame.origin.x,
                                            Product_2.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        
        if (touchPoint.x > Product_3.frame.origin.x &&
            touchPoint.x < Product_3.frame.origin.x +
            Product_3.frame.size.width &&
            touchPoint.y > Product_3.frame.origin.y &&
            touchPoint.y < Product_3.frame.origin.y +
            Product_3.frame.size.height)
        {
            self.dragImage = Product_3;
            self.dragObject = @"#3";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_3.frame.origin.x,
                                           touchPoint.y - Product_3.frame.origin.y);
            self.homePosition = CGPointMake(Product_3.frame.origin.x,
                                            Product_3.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        
        if (touchPoint.x > Product_4.frame.origin.x &&
            touchPoint.x < Product_4.frame.origin.x +
            Product_4.frame.size.width &&
            touchPoint.y > Product_4.frame.origin.y &&
            touchPoint.y < Product_4.frame.origin.y +
            Product_4.frame.size.height)
        {
            self.dragImage = Product_4;
            self.dragObject = @"#4";
            self.touchOffset = CGPointMake(touchPoint.x -
                                           Product_4.frame.origin.x,
                                           touchPoint.y - Product_4.frame.origin.y);
            self.homePosition = CGPointMake(Product_4.frame.origin.x,
                                            Product_4.frame.origin.y);
            [self.view bringSubviewToFront:self.dragImage];
        }
        //NSLog(self.dragObject);
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    CGPoint touchPoint = [[touches anyObject]
                          locationInView:self.view];
    CGRect newDragObjectFrame = CGRectMake(touchPoint.x -
                                           touchOffset.x,
                                           touchPoint.y - touchOffset.y,
                                           self.dragImage.frame.size.width,
                                           self.dragImage.frame.size.height);
    self.dragImage.frame = newDragObjectFrame;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject]
                          locationInView:self.view];
    if (touchPoint.x > self.Worker_A.frame.origin.x &&
        touchPoint.x < self.Worker_A.frame.origin.x +
        self.Worker_A.frame.size.width &&
        touchPoint.y > self.Worker_A.frame.origin.y &&
        touchPoint.y < self.Worker_A.frame.origin.y +
        self.Worker_A.frame.size.height )
    {
        targetRole = @"A";
        if([self.dragObject isEqualToString:@"#1"]){
            int count1 = [self.Worker_A.l1.text intValue];
            count1 += 1;
            self.Worker_A.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"#2"]){
            int count2 = [self.Worker_A.l2.text intValue];
            count2 += 1;
            self.Worker_A.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"#3"]){
            int count3 = [self.Worker_A.l3.text intValue];
            count3 += 1;
            self.Worker_A.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"#4"]){
            int count4 = [self.Worker_A.l4.text intValue];
            count4 += 1;
            self.Worker_A.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }
    
    if (touchPoint.x > self.Worker_B.frame.origin.x &&
        touchPoint.x < self.Worker_B.frame.origin.x +
        self.Worker_B.frame.size.width &&
        touchPoint.y > self.Worker_B.frame.origin.y &&
        touchPoint.y < self.Worker_B.frame.origin.y +
        self.Worker_B.frame.size.height )
    {
        targetRole = @"B";
        if([self.dragObject isEqualToString:@"#1"]){
            int count1 = [self.Worker_B.l1.text intValue];
            count1 += 1;
            self.Worker_B.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"#2"]){
            int count2 = [self.Worker_B.l2.text intValue];
            count2 += 1;
            self.Worker_B.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"#3"]){
            int count3 = [self.Worker_B.l3.text intValue];
            count3 += 1;
            self.Worker_B.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"#4"]){
            int count4 = [self.Worker_B.l4.text intValue];
            count4 += 1;
            self.Worker_B.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }
    
    if (touchPoint.x > self.Worker_C.frame.origin.x &&
        touchPoint.x < self.Worker_C.frame.origin.x +
        self.Worker_C.frame.size.width &&
        touchPoint.y > self.Worker_C.frame.origin.y &&
        touchPoint.y < self.Worker_C.frame.origin.y +
        self.Worker_C.frame.size.height )
    {
        targetRole = @"C";
        if([self.dragObject isEqualToString:@"#1"]){
            int count1 = [self.Worker_C.l1.text intValue];
            count1 += 1;
            self.Worker_C.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"#2"]){
            int count2 = [self.Worker_C.l2.text intValue];
            count2 += 1;
            self.Worker_C.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"#3"]){
            int count3 = [self.Worker_C.l3.text intValue];
            count3 += 1;
            self.Worker_C.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"#4"]){
            int count4 = [self.Worker_C.l4.text intValue];
            count4 += 1;
            self.Worker_C.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }

    if (touchPoint.x > self.Worker_D.frame.origin.x &&
        touchPoint.x < self.Worker_D.frame.origin.x +
        self.Worker_D.frame.size.width &&
        touchPoint.y > self.Worker_D.frame.origin.y &&
        touchPoint.y < self.Worker_D.frame.origin.y +
        self.Worker_D.frame.size.height )
    {
        targetRole = @"D";
        if([self.dragObject isEqualToString:@"#1"]){
            int count1 = [self.Worker_D.l1.text intValue];
            count1 += 1;
            self.Worker_D.l1.text=[NSString stringWithFormat:@"%i",count1];
        }
        else if([self.dragObject isEqualToString:@"#2"]){
            int count2 = [self.Worker_D.l2.text intValue];
            count2 += 1;
            self.Worker_D.l2.text=[NSString stringWithFormat:@"%i",count2];
        }
        else if([self.dragObject isEqualToString:@"#3"]){
            int count3 = [self.Worker_D.l3.text intValue];
            count3 += 1;
            self.Worker_D.l3.text=[NSString stringWithFormat:@"%i",count3];
        }
        else if([self.dragObject isEqualToString:@"#4"]){
            int count4 = [self.Worker_D.l4.text intValue];
            count4 += 1;
            self.Worker_D.l4.text=[NSString stringWithFormat:@"%i",count4];
        }
        
    }
    if([targetRole isEqualToString:@""]){
        //
    }else{
        [self callWebService];
    }
    
    self.dragImage.frame = CGRectMake(self.homePosition.x,
                                       self.homePosition.y,
                                       self.dragImage.frame.size.width,
                                       self.dragImage.frame.size.height);
    targetRole = @"";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    targetRole = @"";
    _receivedData = [[NSMutableArray alloc]init];
    //[self callWebService];

}

-(void)callWebService{
    recordResults = NO;
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:addRecord xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<account>"];
    soapMessage = [soapMessage stringByAppendingString:userAccount.account];
    soapMessage = [soapMessage stringByAppendingString:@"</account>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<room>"];
    soapMessage = [soapMessage stringByAppendingString:userAccount.room];
    soapMessage = [soapMessage stringByAppendingString:@"</room>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<table>"];
    soapMessage = [soapMessage stringByAppendingString:userAccount.table];
    soapMessage = [soapMessage stringByAppendingString:@"</table>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<student>"];
    soapMessage = [soapMessage stringByAppendingString:targetRole];
    soapMessage = [soapMessage stringByAppendingString:@"</student>\n"];
    
    soapMessage = [soapMessage stringByAppendingString:@"<recordType>"];
    soapMessage = [soapMessage stringByAppendingString:self.dragObject];
    soapMessage = [soapMessage stringByAppendingString:@"</recordType>\n"];
    
    soapMessage = [soapMessage stringByAppendingString:@"<startTime>"];
    soapMessage = [soapMessage stringByAppendingString:@"1"];
    soapMessage = [soapMessage stringByAppendingString:@"</startTime>\n"];
    
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:addRecord>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/JobShop?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/addRecord"
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
    if([response isEqualToString:@"Y"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"订单下达状态" message:@"成功!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        // optional - add more buttons:
        //[alert addButtonWithTitle:@"验证"];
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"订单下达状态" message:@"失败!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        // optional - add more buttons:
        //[alert addButtonWithTitle:@"验证"];
        [alert show];
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
    response = string;
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

@end
