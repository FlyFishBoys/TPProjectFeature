//
//  TPDCancelDealAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDCancelDealAPI : TPBaseAPI
/**
 放弃承接
 
 @param orderId 订单id
 @param orderVersion 订单version
 */
- (instancetype)initWithPreOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion;
@end
