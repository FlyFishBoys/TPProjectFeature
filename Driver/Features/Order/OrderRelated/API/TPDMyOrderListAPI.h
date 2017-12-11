//
//  TPDMyOrderListAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDMyOrderListAPI : TPBaseAPI

/**
 初始化
 
 @param status 订单状态  0:全部 1：新货源 2:待成交 3:待支付 4:承运中
 @param page 页数	   初始为1
 @return 初始化对象
 */
- (instancetype)initWithStatus:(NSString *)status page:(NSInteger)page;
@end
