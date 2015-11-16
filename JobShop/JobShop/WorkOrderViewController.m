//
//  WorkOrderViewController.m
//  JobShop
//
//  Created by 何文戟 on 15/11/16.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import "WorkOrderViewController.h"

@interface WorkOrderViewController ()

@end

@implementation WorkOrderViewController
@synthesize product;
@synthesize startTime;
@synthesize endTime;
@synthesize lt;
@synthesize process1;
@synthesize process1Time;
@synthesize process2;
@synthesize process2Time;
@synthesize process3;
@synthesize process3Time;
@synthesize process4;
@synthesize process4Time;
@synthesize myRecord;
- (void)viewDidLoad {
    [super viewDidLoad];
    if([myRecord.recordType isEqualToString:@"#1"]){
        self.view.backgroundColor = [UIColor colorWithRed:250/255.0 green:79/255.0 blue:148/255.0 alpha:1];
    }
    if([myRecord.recordType isEqualToString:@"#2"]){
        self.view.backgroundColor = [UIColor colorWithRed:152/255.0 green:230/255.0 blue:144/255.0 alpha:1];
    }
    if([myRecord.recordType isEqualToString:@"#3"]){
        self.view.backgroundColor = [UIColor colorWithRed:252/255.0 green:240/255.0 blue:109/255.0 alpha:1];
    }
    if([myRecord.recordType isEqualToString:@"#4"]){
        self.view.backgroundColor = [UIColor colorWithRed:97/255.0 green:177/255.0 blue:252/255.0 alpha:1];
    }
    self.product.text = myRecord.recordType;
    self.startTime.text = myRecord.startTime;
    self.endTime.text = myRecord.endTime;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
