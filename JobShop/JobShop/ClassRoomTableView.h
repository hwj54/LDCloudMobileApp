//
//  ClassRoomTableView.h
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccount.h"

@interface ClassRoomTableView : UITableViewController
@property(nonatomic) NSString *account;
@property(nonatomic) UserAccount *userAccount;
@end
