//
//  ChoiceRoleViewController.h
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserAccount.h"
@interface ChoiceRoleViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *boss;
@property (strong, nonatomic) IBOutlet UIButton *workerA;
@property (strong, nonatomic) IBOutlet UIButton *workerB;
@property (strong, nonatomic) IBOutlet UIButton *workerC;
@property (strong, nonatomic) IBOutlet UIButton *workerD;
@property(nonatomic)UserAccount *userAccount;
@end
