//
//  MyRecord.h
//  JobShop
//
//  Created by 何文戟 on 15/11/13.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRecord : NSObject
@property(nonatomic)NSString *recordID;
@property(nonatomic)NSString *role;
@property(nonatomic)NSString *recordType;
@property(nonatomic)NSString *startTime;
@property(nonatomic)NSString *endTime;
@property(nonatomic)NSString *status;
@property(nonatomic)NSString *transmitTime;
@property(nonatomic)NSMutableArray *_reportList;
@end
