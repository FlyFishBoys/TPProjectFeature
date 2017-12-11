//
//  TPDDeleteVehicleAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDDeleteVehicleAPI.h"

@interface TPDDeleteVehicleAPI ()
{
    NSString * _driverTruckId;
    NSString * _driverTruckVersion;
}

@end

@implementation TPDDeleteVehicleAPI

- (instancetype)initWithDriverTruckId:(NSString *)driverTruckId driverTruckVersion:(NSString *)driverTruckVersion {
    if (self = [super init]) {
        _driverTruckId = driverTruckId;
        _driverTruckVersion = driverTruckVersion;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truckteam/deletetruck";
}

- (nullable NSString *)destination {
    return @"truckteam.deletetruck";
}

- (id)businessParameters {
    return @{
             @"driver_truck_version":_driverTruckVersion.isNotBlank ? _driverTruckVersion : @"",
             @"driver_truck_id":_driverTruckId.isNotBlank ? _driverTruckId : @"",
             };
    
}
@end
