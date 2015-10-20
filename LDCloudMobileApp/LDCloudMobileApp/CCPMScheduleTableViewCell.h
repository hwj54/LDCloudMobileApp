//
//  CCPMScheduleTableViewCell.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/17.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleNode.h"

@interface CCPMScheduleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ScheduleNode;
@property (nonatomic,strong) ScheduleNode * node;

@end
