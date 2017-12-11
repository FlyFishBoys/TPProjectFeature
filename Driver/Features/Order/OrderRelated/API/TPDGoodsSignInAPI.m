//
//  TPDGoodsSignInAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsSignInAPI.h"

@interface TPDGoodsSignInAPI ()
{
    NSString *_orderId;
    NSString *_orderVersion;
    NSString *_unloadCode;
}

@end

@implementation TPDGoodsSignInAPI
- (instancetype)initWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion unloadCode:(NSString *)unloadCode {
    if (self = [super init]) {
        _orderId = orderId;
        _orderVersion = orderVersion;
        _unloadCode = unloadCode;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/bill/confirmreceivingbydriver";
}

- (nullable NSString *)destination {
    return @"bill.confirmreceivingbydriver";
}

- (id)businessParameters {
    return @{
             @"order_id":_orderId.isNotBlank ? _orderId : @"",
             @"order_version":_orderVersion.isNotBlank ? _orderVersion : @"",
             @"unload_code":_unloadCode.isNotBlank ? _unloadCode : @"",
             };
}
@end
