//
//  MyTableViewController_1.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/15.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCPMTask.h"
#import "User.h"


@interface MyTableViewController_1 : UITableViewController<NSXMLParserDelegate>
- (IBAction)Refresh:(id)sender;
- (IBAction)Filter:(id)sender;
- (IBAction)OpenCamera:(id)sender;
- (IBAction)Setup:(id)sender;
@property (nonatomic,strong) User *user;
@end
