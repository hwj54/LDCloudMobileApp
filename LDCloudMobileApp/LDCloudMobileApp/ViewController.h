//
//  ViewController.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/15.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>
@property (strong, nonatomic) IBOutlet UITextField *user;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UILabel *loginStatus;
- (IBAction)loginBtn:(id)sender;


@end

