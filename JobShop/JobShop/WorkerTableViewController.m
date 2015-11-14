//
//  WorkerTableViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "WorkerTableViewController.h"
#import "MyRecord.h"
#import "WorkerTableViewCell.h"

@interface WorkerTableViewController (){
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    NSString *response ;
    BOOL recordResults;
    NSMutableArray *_recordList;
    NSMutableArray *_receivedData;
    NSString *clickType;
    NSString *ScheduleID;
    NSInteger *selectIndex;
    NSString *operationMode;
    MyRecord *record;
    NSString *wsOption;
    NSString *newClock;
}

@end

@implementation WorkerTableViewController
@synthesize role;
@synthesize userAccount;
@synthesize myTable;
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *workStation = @"工作站";
    self.navigationItem.title = [workStation stringByAppendingString:role];
    self.navigationItem.rightBarButtonItems[1].title = myTable.clock;
    _recordList = [[NSMutableArray alloc]init];
    _receivedData = [[NSMutableArray alloc]init];
    [self callWebService];

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


-(void)callWebService{
    _recordList = [[NSMutableArray alloc]init];
    wsOption = @"同步";
    recordResults = NO;
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:GetRecord xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
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
    soapMessage = [soapMessage stringByAppendingString:userAccount.role];
    soapMessage = [soapMessage stringByAppendingString:@"</student>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:GetRecord>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/JobShop?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/GetRecord"
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
    if([wsOption isEqualToString:@"同步"]){
        [self.tableView reloadData];
        [self clockSynchWebService];
    }
    else if ([wsOption isEqualToString:@"时钟同步"]){
        self.navigationItem.rightBarButtonItems[1].title = myTable.clock;
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
    if([wsOption isEqualToString:@"时钟同步"]){
        myTable.clock = string;
    }else if([wsOption isEqualToString:@"同步"]){
    BOOL isSeparator = [@"|" isEqualToString:string];
    if(isSeparator){
        record = [[MyRecord alloc]init];
        record.recordID = [_receivedData objectAtIndex:0];
        record.role = userAccount.role;
        record.recordType = [_receivedData objectAtIndex:1];
        record.startTime = [_receivedData objectAtIndex:2];
        [_recordList addObject:record];
        _receivedData = [[NSMutableArray alloc]init];
    }else{
        [_receivedData addObject:string];
        /*
         if([operationMode isEqualToString:@"取消"] || [operationMode isEqualToString:@"关闭"]){
         if([string isEqualToString:@"Y"]){
         //NSLog(@"recordResults:%@",string);
         [_roomList removeObjectAtIndex:selectIndex];
         }
         }
         */
    }
    }
    
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
    
    if( [elementName isEqualToString:@"ns2:GetRecordResponse"] ||
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return [_recordList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WorkerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    /* Configure the cell...
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
     reuseIdentifier:@"mycell"];
     }
     */
    
    MyRecord *recordItem = _recordList[indexPath.row];
    
    cell.label.text = [@"投料日期 " stringByAppendingString: recordItem.startTime];
    //UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:taskItem.imgurl]]];
    NSString *imageName = [[NSString alloc]init];
    if([recordItem.recordType isEqualToString:@"#1"]){
        imageName = @"WorkOrder#1Logo.png";
    }else if ([recordItem.recordType isEqualToString:@"#2"]){
        imageName = @"WorkOrder#2Logo.png";
    }else if ([recordItem.recordType isEqualToString:@"#3"]){
        imageName = @"WorkOrder#3Logo.png";
    }else if ([recordItem.recordType isEqualToString:@"#4"]){
        imageName = @"WorkOrder#4Logo.png";
    }
        UIImage *img = [UIImage imageNamed:imageName];
    cell.image.image = img;
    
    //UIImageView *img = (UIImageView *)[cell viewWithTag:102];
    
    return cell;
}

//*change cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 61.0f;
}


//TableView Cell 响应选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyRecord *recordItem = _recordList[indexPath.row];
    
    //selectIndex = indexPath.row;
    /*
     //ScheduleID = taskItem.title;
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"操作选项" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
     // optional - add more buttons:
     [alert addButtonWithTitle:@"取消关注"];
     [alert addButtonWithTitle:@"关闭任务"];
     [alert addButtonWithTitle:@"报工"];
     [alert show];
     */
    //[self performSegueWithIdentifier:@"gotoChoiceRole" sender:self];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)synch:(id)sender {
    [self callWebService];
}
@end
