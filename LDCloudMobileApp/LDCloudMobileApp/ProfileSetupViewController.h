//
//  ProfileSetupViewController.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 16/7/26.
//  Copyright © 2016年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface ProfileSetupViewController : UIViewController<NSXMLParserDelegate>
@property (strong, nonatomic) IBOutlet UITextField *inputNewPass;
@property (strong, nonatomic) IBOutlet UITextField *confirmNewPass;
@property (strong, nonatomic) IBOutlet UILabel *checkNewPass;
- (IBAction)commit:(id)sender;
@property (nonatomic,strong) User *user;
@end
