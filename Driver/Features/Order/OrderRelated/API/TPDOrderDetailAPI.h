//
//  TPDOrderDetailAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDOrderDetailAPI : TPBaseAPI
/**
 用orderId初始化
 
 @param orderId 订单Id
 @return 初始化对象
 */
- (instancetype)initWithOrderId:(NSString *)orderId;

@end
