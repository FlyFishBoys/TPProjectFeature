//
//  TPDOrderDetailAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDOrderDetailAPI.h"

@interface TPDOrderDetailAPI ()
{
    NSString * _orderId;
}

@end

@implementation TPDOrderDetailAPI

- (instancetype)initWithOrderId:(NSString *)orderId {
    if (self = [super init]) {
        _orderId = orderId;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/driverorder/driverorderinfo";
}

- (nullable NSString *)destination {
    return @"driverorder.driverorderinfo";
}

- (id)businessParameters {
    return @{
             @"order_id":_orderId.isNotBlank ? _orderId : @"",
             };
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
