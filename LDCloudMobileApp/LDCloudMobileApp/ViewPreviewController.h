//
//  ViewPreviewController.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/16.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ViewPreviewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *ViewPreview;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;
@property (nonatomic,strong) User *user;

@end
