//
//  TPDSwitchSeekGoodsStatusAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSwitchSeekGoodsStatusAPI.h"
@interface TPDSwitchSeekGoodsStatusAPI ()
{
    NSString * _driverTruckId;
    NSString * _truckStatus;
}

@end

@implementation TPDSwitchSeekGoodsStatusAPI
- (instancetype)initWithDriverTruckId:(NSString *)driverTruckId truckStatus:(NSString *)truckStatus {
    if (self = [super init]) {
        _driverTruckId = driverTruckId;
        _truckStatus = truckStatus;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truckteam/switchstatus";
}

- (nullable NSString *)destination {
    return @"truckteam.switchstatus";
}

- (id)businessParameters {
    return @{
             @"driver_truck_id":_driverTruckId.isNotBlank ? _driverTruckId : @"",
             @"truck_status":_truckStatus.isNotBlank ? _truckStatus : @"",
             };
}

@end
