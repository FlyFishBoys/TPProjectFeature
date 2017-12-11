//
//  TPDVehicleDetailDataManager.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDVehicleDefines.h"

@interface TPDVehicleDetailDataManager : NSObject

/**
 获取车辆详情

 @param driverTruckId 司机车辆ID
 @param completeBlock 请求完成的block
 */
- (void)getVehicleDetailWithDriverTruckId:(NSString *)driverTruckId completeBlock:(RequestViewModelCompleteBlock)completeBlock;

/**
 删除车辆
 
 @param driverTruckId 司机车辆ID
 @param driverTruckVersion 司机车辆version
 @param completeBlock 请求完成的block
 */
- (void)deleteVehicleWithDriverTruckId:(NSString *)driverTruckId driverTruckVersion:(NSString *)driverTruckVersion completeBlock:(RequestCompleteBlock)completeBlock;
@end
