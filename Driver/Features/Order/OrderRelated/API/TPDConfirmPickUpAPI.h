//
//  TPDConfirmPickUpAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDConfirmPickUpAPI : TPBaseAPI
/**
 确认提货
 
 @param orderId 订单Id
 @param orderVersion 订单版本号
 @param pickupCode 提货码
 @return 初始化对象
 */
- (instancetype)initWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion pickupCode:(NSString *)pickupCode;
@end
