//
//  CCPMScheduleTableViewCell.m
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/17.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPMScheduleTableViewCell.h"

@interface CCPMScheduleTableViewCell(){
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    NSString *response ;
    BOOL recordResults;
    UITextField *dateInput;
}

@end

@implementation CCPMScheduleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected && [_node.NodeState isEqualToString:@"Y"]){
        if([_node.Status isEqualToString:@"初始"]){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[_node.NodeName stringByAppendingString:@"操作选项"]
            message:@"请选择您要执行的操作!"
            delegate:self
            cancelButtonTitle:@"取消"
            otherButtonTitles:@"报工",
            @"修改交期",
            nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[_node.NodeName stringByAppendingString:@"操作选项"] message:@"您确认要报工吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"报工",nil];
            // optional - add more buttons:
            //[alert addButtonWithTitle:@"报工"];
            [alert show];
        }
    }else if(selected && [_node.NodeState isEqualToString:@"N"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[_node.NodeName stringByAppendingString:@"操作选项"] message:@"您确认要修改交期吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"修改交期",nil];
        // optional - add more buttons:
        //[alert addButtonWithTitle:@"修改交期"];
        [alert show];    }
    // Configure the view for the selected state
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"取消"]){
        NSLog(@"取消!");
    }
    if ([buttonTitle isEqualToString:@"确定"]){
        NSLog(@"确定!");
    }
    if ([buttonTitle isEqualToString:@"报工"]) {
        // do stuff
        NSLog(@"报工!");
        [self callWebService];
        return;
    }
    if ([buttonTitle isEqualToString:@"修改交期"]) {
        // do stuff
        NSLog(@"修改交期!");
        
        UIDatePicker *picker = [[UIDatePicker alloc]init];
        //picker.frame = CGRectMake(0, 0, 320, 216);
        picker.datePickerMode = UIDatePickerModeDate;
        [picker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[_node.NodeName stringByAppendingString:@"重新确认交期"] message:@"" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认交期",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        
        dateInput = [alert textFieldAtIndex:0];
        dateInput.inputView = picker;
        [dateInput setTextAlignment:NSTextAlignmentCenter];
        //alert.frame = CGRectMake(0, 144, 320, 256);
        //[alert addSubview:picker];
        [alert show];
        [dateInput becomeFirstResponder];
        return;
    }
    if ([buttonTitle isEqualToString:@"确认交期"]) {
        // do stuff
        NSLog(@"确认交期!");
        [self callWebService2];
        return;
    }

}

-(void)dateChanged:(UIDatePicker *)datePicker{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy'-'MM'-'dd'";
    //[formatter setDateStyle:NSDateFormatterMediumStyle];
    dateInput.text = [formatter stringFromDate:datePicker.date];
    //NSString *text = [formatter stringFromDate:datePicker.date];
    //dateInput.text = text;
}

-(void)callWebService{
    recordResults = NO;
    response = [[NSString alloc]init];
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:update xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<barcode>"];
    soapMessage = [soapMessage stringByAppendingString:_node.ScheduleID];
    soapMessage = [soapMessage stringByAppendingString:@"</barcode>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<node>"];
    soapMessage = [soapMessage stringByAppendingString:_node.ProcessNum];
    soapMessage = [soapMessage stringByAppendingString:@"</node>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:update>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/updateSchedule?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/update"
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


-(void)callWebService2{
    recordResults = NO;
    response = [[NSString alloc]init];
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:updatePlanDate xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<barcode>"];
    soapMessage = [soapMessage stringByAppendingString:_node.ScheduleID];
    soapMessage = [soapMessage stringByAppendingString:@"</barcode>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<node>"];
    soapMessage = [soapMessage stringByAppendingString:_node.ProcessNum];
    soapMessage = [soapMessage stringByAppendingString:@"</node>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<plandate>"];
    soapMessage = [soapMessage stringByAppendingString:dateInput.text];
    soapMessage = [soapMessage stringByAppendingString:@"</plandate>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:updatePlanDate>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/updateSchedule?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/update"
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
    if([response isEqualToString:@"Y"]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"操作已完成!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        // optional - add more buttons:
        [alert show];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"操作未完成!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        // optional - add more buttons:
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
    //NSLog(@"recordResults:%@",string);
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
    
    if( [elementName isEqualToString:@"ns2:updateResponse"])
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
