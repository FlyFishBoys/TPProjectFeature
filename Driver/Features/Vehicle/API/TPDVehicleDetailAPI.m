//
//  TPDVehicleDetailAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleDetailAPI.h"

@interface TPDVehicleDetailAPI ()
{
    NSString * _driverTruckId;
}

@end

@implementation TPDVehicleDetailAPI
- (instancetype)initWithDriverTruckId:(NSString *)driverTruckId {
    if (self = [super init]) {
        _driverTruckId = driverTruckId;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truckteam/truckinfo";
}

- (nullable NSString *)destination {
    return @"truckteam.truckinfo";
}

- (id)businessParameters {
    return @{
             @"driver_truck_id":_driverTruckId.isNotBlank ? _driverTruckId : @"",
             };
    
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
