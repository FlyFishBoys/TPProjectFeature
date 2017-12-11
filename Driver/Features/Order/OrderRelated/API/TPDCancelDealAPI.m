//
//  TPDCancelDealAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCancelDealAPI.h"


@interface TPDCancelDealAPI ()
{
    NSString *_orderId;
    NSString *_orderVersion;
}
@end

@implementation TPDCancelDealAPI

- (instancetype)initWithPreOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion {
    if (self = [super init]) {
        _orderId = orderId;
        _orderVersion = orderVersion;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/driverorder/giveuporder";
}

- (nullable NSString *)destination {
    return @"driverorder.giveuporder";
}

- (id)businessParameters {
    return @{
             @"order_version":_orderVersion.isNotBlank ? _orderVersion : @"",
             @"order_id":_orderId.isNotBlank ? _orderId : @"",
             };
}
@end
