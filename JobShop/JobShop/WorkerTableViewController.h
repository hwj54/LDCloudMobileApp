//
//  WorkerTableViewController.h
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccount.h"
#import "MyTable.h"
@interface WorkerTableViewController : UITableViewController
@property(nonatomic)UserAccount *userAccount;
@property(nonatomic)MyTable *myTable;
@property(nonatomic)NSString *role;
@end
