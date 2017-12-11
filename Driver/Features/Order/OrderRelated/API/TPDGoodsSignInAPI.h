//
//  TPDGoodsSignInAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDGoodsSignInAPI : TPBaseAPI
/**
 确认签收
 
 @param orderId 订单Id
 @param orderVersion 订单版本号
 @param unloadCode 卸货码
 @return 初始化对象
 */
- (instancetype)initWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion unloadCode:(NSString *)unloadCode;
@end
