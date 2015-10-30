//
//  ScheduleNode.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/17.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleNode : NSObject
@property (nonatomic,strong) NSString *NodeCode;
@property (nonatomic,strong) NSString *NodeName;
@property (nonatomic,strong) NSString *NodeState;
@property (nonatomic,strong) NSString *PlanDate;
@property (nonatomic,strong) NSString *ScheduleID;
@property (nonatomic,strong) NSString *ProcessNum;
@property (nonatomic,strong) NSString *Status;
@end
