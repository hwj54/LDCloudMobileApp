//
//  ScanResultTableViewController.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/17.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ScanResultTableViewController : UITableViewController<NSXMLParserDelegate>
@property (nonatomic,strong) NSString *QRCode;
@property (nonatomic,strong) User *user;
@end
