//
//  TPDSwitchSeekGoodsStatusAllAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSwitchSeekGoodsStatusAllAPI.h"


@interface TPDSwitchSeekGoodsStatusAllAPI ()
{
    NSString * _truckStatus;
}

@end

@implementation TPDSwitchSeekGoodsStatusAllAPI
- (instancetype)initWithTruckStatus:(NSString *)truckStatus {
    if (self = [super init]) {
        _truckStatus = truckStatus;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truckteam/switchstatusall";
}

- (nullable NSString *)destination {
    return @"truckteam.switchstatusall";
}

- (id)businessParameters {
    return @{
             @"truck_status":_truckStatus.isNotBlank ? _truckStatus : @"",
             };
}

@end
