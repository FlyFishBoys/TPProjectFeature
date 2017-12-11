//
//  TPDConfirmPickUpAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDConfirmPickUpAPI.h"

@interface TPDConfirmPickUpAPI ()
{
    NSString *_orderId;
    NSString *_orderVersion;
    NSString *_pickupCode;
}

@end

@implementation TPDConfirmPickUpAPI
- (instancetype)initWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion pickupCode:(NSString *)pickupCode {
    if (self = [super init]) {
        _orderId = orderId;
        _orderVersion = orderVersion;
        _pickupCode = pickupCode;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/bill/surepickupgoods";
}

- (nullable NSString *)destination {
    return @"bill.surepickupgoods";
}

- (id)businessParameters {
    return @{
             @"order_version":_orderVersion.isNotBlank ? _orderVersion : @"",
             @"order_id":_orderId.isNotBlank ? _orderId : @"",
             @"pickup_code":_pickupCode.isNotBlank ? _pickupCode : @"",
             };
}
@end
