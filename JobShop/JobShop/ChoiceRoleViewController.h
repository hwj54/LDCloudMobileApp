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
@property (strong, nonatomic) IBOutlet UIImageView *boss;
@property (strong, nonatomic) IBOutlet UIImageView *workerA;
@property (strong, nonatomic) IBOutlet UIImageView *workerB;
@property (strong, nonatomic) IBOutlet UIImageView *workerC;
@property (strong, nonatomic) IBOutlet UIImageView *workerD;
@property(nonatomic)UserAccount *userAccount;
@end
