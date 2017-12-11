//
//  TPDVehicleDetailAPI.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDVehicleDetailAPI : TPBaseAPI
/**
 获取车辆详情
 
 @param driverTruckId 司机车辆id
 @return 初始化对象
 */
- (instancetype)initWithDriverTruckId:(NSString *)driverTruckId;
@end
