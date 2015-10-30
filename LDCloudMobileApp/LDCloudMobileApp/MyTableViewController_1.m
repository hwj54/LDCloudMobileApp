//
//  MyTableViewController_1.m
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/15.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "MyTableViewController_1.h"
#import "MyTableViewCell_1.h"
#import "CCPMScheduleTableViewController.h"
#import "ViewPreviewController.h"

@interface MyTableViewController_1 (){
    NSMutableData *webData;
    NSMutableString *soapResults;
    NSXMLParser *xmlParser;
    NSString *response ;
    BOOL recordResults;
    NSMutableArray *_ccpmTaskList;
    NSMutableArray *_receivedData;
    CCPMTask *task;
    NSString *clickType;
    NSString *ScheduleID;
    NSInteger *selectIndex;
    NSString *operationMode;
}

@end

@implementation MyTableViewController_1
@synthesize user;
- (void)viewDidLoad {
    [super viewDidLoad];
    //[self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyTableViewCell_1 class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyTableViewCell_1 class])];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _ccpmTaskList = [[NSMutableArray alloc]init];
    _receivedData = [[NSMutableArray alloc]init];
    clickType = @"";
    
    //NSLog(@"**************************接收到的对象**************************");
    //NSLog(@"%@",user.userName);
    //NSLog(@"%@",user.custName);
    
    [self callWebService];
    /*
    task.title = @"1111";
    task.info = @"@@@@\n"
    "####\n"
    "%%%%\n"
    "****";
    task.imgurl = @"Mate_1.jpg";
    [_ccpmTaskList addObject:task];
    
    task = [[CCPMTask alloc]init];
    task.title = @"2222";
    task.info = @"@@@@\n"
    "####\n"
    "%%%%\n"
    "****";
    task.imgurl = @"Mate_1.jpg";
    [_ccpmTaskList addObject:task];
    
    task = [[CCPMTask alloc]init];
    task.title = @"3333";
    task.info = @"@@@@\n"
    "####\n"
    "%%%%\n"
    "****";
    task.imgurl = @"Mate_1.jpg";
    [_ccpmTaskList addObject:task];
    
    task = [[CCPMTask alloc]init];
    task.title = @"4444";
    task.info = @"@@@@\n"
    "####\n"
    "%%%%\n"
    "****";
    task.imgurl = @"Mate_1.jpg";
    [_ccpmTaskList addObject:task];
     */
    }

-(void)callWebService{
    recordResults = NO;
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:queryUserTask xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<user>"];
    soapMessage = [soapMessage stringByAppendingString:user.userCode];
    soapMessage = [soapMessage stringByAppendingString:@"</user>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:queryUserTask>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/queryTaskList?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/queryUserTask"
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

-(void)callUpdateTaskWebService:(NSString *)taskState{
    recordResults = NO;
    //封装soap请求消息
    NSString *soapMessage = [NSString stringWithFormat:
                             @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
                             "<S:Envelope xmlns:S=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                             "<SOAP-ENV:Header/>\n"
                             "<S:Body>\n"
                             "<ns2:updateTaskState xmlns:ns2=\"http://service.enterpriseApp.ld.org/\">\n"
                             "<user>"];
    soapMessage = [soapMessage stringByAppendingString:user.userCode];
    soapMessage = [soapMessage stringByAppendingString:@"</user>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<taskid>"];
    soapMessage = [soapMessage stringByAppendingString:ScheduleID];
    soapMessage = [soapMessage stringByAppendingString:@"</taskid>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"<state>"];
    soapMessage = [soapMessage stringByAppendingString:taskState];
    soapMessage = [soapMessage stringByAppendingString:@"</state>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</ns2:updateTaskState>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Body>\n"];
    soapMessage = [soapMessage stringByAppendingString:@"</S:Envelope>"];
    NSLog(@"%@",soapMessage);
    //请求发送到的路径
    NSURL *url = [NSURL URLWithString:@"http://120.27.51.181:8080/LDJEEWebEnterpriseApp-war/UserTask?WSDL"];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    
    //以下对请求信息添加属性前四句是必有的，第五句是soap信息。
    [theRequest addValue: @"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue: @"http://service.enterpriseApp.ld.org/updateTaskState"
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
    [self.tableView reloadData];
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
    BOOL isSeparator = [@"|" isEqualToString:string];
    if(isSeparator){
        task = [[CCPMTask alloc]init];
        task.title = [_receivedData objectAtIndex:0];
        task.info = [_receivedData objectAtIndex:2];
        task.imgurl = [_receivedData objectAtIndex:1];
        [_ccpmTaskList addObject:task];
        _receivedData = [[NSMutableArray alloc]init];
    }else{
        [_receivedData addObject:string];
        if([operationMode isEqualToString:@"取消"] || [operationMode isEqualToString:@"关闭"]){
        if([string isEqualToString:@"Y"]){
            //NSLog(@"recordResults:%@",string);
            [_ccpmTaskList removeObjectAtIndex:selectIndex];
        }
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
    
    if( [elementName isEqualToString:@"ns2:queryUserTaskResponse"] ||
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
    return [_ccpmTaskList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTableViewCell_1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    /* Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"mycell"];
    }
    */
    
    CCPMTask *taskItem = _ccpmTaskList[indexPath.row];
    
    cell.title.text = taskItem.title;
    cell.info.text = taskItem.info;
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:taskItem.imgurl]]];
    //UIImage *img = [UIImage imageNamed:taskItem.imgurl];
    cell.imageView.image = img;
    
    //UIImageView *img = (UIImageView *)[cell viewWithTag:102];
    
    return cell;
}

//*change cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 90.0f;
}


//TableView Cell 响应选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCPMTask *taskItem = _ccpmTaskList[indexPath.row];
    selectIndex = indexPath.row;
    ScheduleID = taskItem.title;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"操作选项" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    // optional - add more buttons:
    [alert addButtonWithTitle:@"取消关注"];
    [alert addButtonWithTitle:@"关闭任务"];
    [alert addButtonWithTitle:@"报工"];
    [alert show];
    //[self performSegueWithIdentifier:@"gotoScheduleDetail1" sender:self];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0){
        NSLog(@"Cancel!");
    }
    if (buttonIndex == 1){
        NSLog(@"取消关注!");
        operationMode = @"取消";
        [self callUpdateTaskWebService:@"取消"];
        [self.tableView reloadData];
    }
    if (buttonIndex == 2){
        NSLog(@"关闭任务!");
        operationMode = @"关闭";
        [self callUpdateTaskWebService:@"关闭"];
        [self.tableView reloadData];
    }
    if (buttonIndex == 3) {
        // do stuff
        //NSLog(@"Yes!");
        clickType = @"gotoScheduleDetail";
        [self performSegueWithIdentifier:@"gotoScheduleDetail1" sender:self];
        clickType = @"";
        return;
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([clickType isEqualToString:@"gotoScheduleDetail"]){
        CCPMScheduleTableViewController *target = segue.destinationViewController;
        [target setValue:ScheduleID forKey:@"ScheduleID"];
    }else{
        ViewPreviewController *target = segue.destinationViewController;
        [target setValue:user forKey:@"user"];
    }
}


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

- (IBAction)OpenCamera:(id)sender {
    clickType = @"openCamera";
    [self performSegueWithIdentifier:@"openCamera" sender:self];clickType = @"";
    clickType = @"";
}
@end
