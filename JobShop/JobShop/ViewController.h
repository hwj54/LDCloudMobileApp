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
#import "MyTable.h"
@interface ViewController : UIViewController
- (IBAction)synch:(id)sender;
- (IBAction)clockPlus:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *Product_1;
@property (strong, nonatomic) IBOutlet UIImageView *Product_2;
@property (strong, nonatomic) IBOutlet UIImageView *Product_3;
@property (strong, nonatomic) IBOutlet UIImageView *Product_4;
@property (strong, nonatomic) IBOutlet WorkerUIView  *Worker_A;
@property (strong, nonatomic) IBOutlet WorkerUIView *Worker_B;
@property (strong, nonatomic) IBOutlet WorkerUIView *Worker_C;
@property (strong, nonatomic) IBOutlet WorkerUIView *Worker_D;
@property (strong, nonatomic) IBOutlet UILabel *A1;
@property (strong, nonatomic) IBOutlet UILabel *A2;
@property (strong, nonatomic) IBOutlet UILabel *A3;
@property (strong, nonatomic) IBOutlet UILabel *A4;
@property (strong, nonatomic) IBOutlet UILabel *B1;
@property (strong, nonatomic) IBOutlet UILabel *B2;
@property (strong, nonatomic) IBOutlet UILabel *B3;
@property (strong, nonatomic) IBOutlet UILabel *B4;
@property (strong, nonatomic) IBOutlet UILabel *C1;
@property (strong, nonatomic) IBOutlet UILabel *C2;
@property (strong, nonatomic) IBOutlet UILabel *C3;
@property (strong, nonatomic) IBOutlet UILabel *C4;
@property (strong, nonatomic) IBOutlet UILabel *D1;
@property (strong, nonatomic) IBOutlet UILabel *D2;
@property (strong, nonatomic) IBOutlet UILabel *D3;
@property (strong, nonatomic) IBOutlet UILabel *D4;

@property (nonatomic, strong) UIImageView *dragImage;
@property (nonatomic, strong) NSString *dragObject;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;
@property(nonatomic) UserAccount *userAccount;
@property(nonatomic)MyTable *myTable;
@end

