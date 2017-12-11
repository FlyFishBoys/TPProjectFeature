//
//  TPDDeleteVehicleAPI.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDDeleteVehicleAPI : TPBaseAPI
/**
 删除车辆
 
 @param driverTruckId 司机车辆id
 @param driverTruckVersion 司机车辆version
 @return 初始化对象
 */
- (instancetype)initWithDriverTruckId:(NSString *)driverTruckId driverTruckVersion:(NSString *)driverTruckVersion;
@end
