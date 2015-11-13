//
//  CreateClassRoomView.h
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccount.h"

@interface CreateClassRoomView : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *classRoom;
@property (strong, nonatomic) IBOutlet UITextField *tableCount;
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property (strong, nonatomic) IBOutlet UILabel *message;
@property (nonatomic) NSString *account;
@property(nonatomic) UserAccount *userAccount;
@end
