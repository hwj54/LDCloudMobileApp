//
//  CCPMTask.h
//  LDCloudMobileApp
//
//  Created by 何文戟 on 15/10/15.
//  Copyright © 2015年 Landing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCPMTask : NSObject

@property (nullable) NSString *title;//P_PCWOCode
@property (nullable) NSString *info;//描述
@property (nullable) NSString *imgurl;//P_PCProductPicURL
@property (nullable) NSString *contractid;//客户 + P_PCWOContractID + 供应商
@property (nullable) NSString *clientCode;//P_PCWOCustomerCode
@property (nullable) NSString *supplierCode;//P_PCWOSupplierCode
@property (nullable) NSString *clientName;//P_PCWOCustomerName
@property (nullable) NSString *supplierName;//P_PCWOSupplierName

@property (nullable) NSString *bufferState1;//进度缓冲颜色
@property (nullable) NSString *bufferState2;//交期缓冲颜色
@property (nullable) NSString *process;//当前工序
@property (nullable) NSString *buffer1;//进度缓冲%
@property (nullable) NSString *buffer2;//交期缓冲%
@property (nullable) NSString *remark;//P_PCWORemark
@property (nullable) NSString *planDate;//P_PCWOPLanDate
@property (nullable) NSString *woType;//P_PCWOType
@property (nullable) NSString *isCCPM;//P_PCIsCCPM
@end
