//
//  TPDConfirmDealAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDConfirmDealAPI.h"

@interface TPDConfirmDealAPI ()
{
    NSString *_orderId;
    NSString *_orderVersion;
}
@end

@implementation TPDConfirmDealAPI
- (instancetype)initWithPreOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion {
    if (self = [super init]) {
        _orderId = orderId;
        _orderVersion = orderVersion;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/driverorder/acceptorder";
}

- (nullable NSString *)destination {
    return @"driverorder.acceptorder";
}

- (id)businessParameters {
    return @{
             @"order_id":_orderId.isNotBlank ? _orderId : @"",
             @"order_version":_orderVersion.isNotBlank ? _orderVersion : @"",
             };
}
@end
