//
//  ViewController.h
//  JobShop
//
//  Created by 何文戟 on 15/11/12.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkerUIView.h"
#import "UserAccount.h"
@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *Product_1;
@property (strong, nonatomic) IBOutlet UIImageView *Product_2;
@property (strong, nonatomic) IBOutlet UIImageView *Product_3;
@property (strong, nonatomic) IBOutlet UIImageView *Product_4;
@property (strong, nonatomic) IBOutlet WorkerUIView  *Worker_A;
@property (strong, nonatomic) IBOutlet WorkerUIView *Worker_B;
@property (strong, nonatomic) IBOutlet WorkerUIView *Worker_C;
@property (strong, nonatomic) IBOutlet WorkerUIView *Worker_D;

@property (nonatomic, strong) UIImageView *dragImage;
@property (nonatomic, strong) NSString *dragObject;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;
@property(nonatomic) UserAccount *userAccount;
@end

