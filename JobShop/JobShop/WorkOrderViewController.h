//
//  WorkOrderViewController.h
//  JobShop
//
//  Created by 何文戟 on 15/11/16.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyRecord.h"
#import "MyTable.h"

@interface WorkOrderViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *product;
@property (strong, nonatomic) IBOutlet UILabel *startTime;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *lt;
@property (strong, nonatomic) IBOutlet UILabel *process1;
@property (strong, nonatomic) IBOutlet UILabel *process1Time;
@property (strong, nonatomic) IBOutlet UILabel *process2;
@property (strong, nonatomic) IBOutlet UILabel *process2Time;
@property (strong, nonatomic) IBOutlet UILabel *process3;
@property (strong, nonatomic) IBOutlet UILabel *process3Time;
@property (strong, nonatomic) IBOutlet UILabel *process4;
@property (strong, nonatomic) IBOutlet UILabel *process4Time;
@property(nonatomic)MyTable *myTable;
@property(nonatomic) MyRecord *myRecord;
@end
