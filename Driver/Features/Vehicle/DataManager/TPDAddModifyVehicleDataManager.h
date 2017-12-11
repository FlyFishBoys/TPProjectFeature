//
//  TPDAddModifyVehicleDataManager.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDVehicleDefines.h"
@class TPDAddModifyVehicleModel;

@interface TPDAddModifyVehicleDataManager : NSObject

/**
 添加车辆

 @param model 添加车辆模型
 */
- (void)addVehicleWithModel:(TPDAddModifyVehicleModel *)model completeBlock:(RequestCompleteBlock)completeBlock;

/**
 修改车辆信息
 
 @param model 添加车辆模型
 */
- (void)modifyVehicleWithModel:(TPDAddModifyVehicleModel *)model completeBlock:(RequestCompleteBlock)completeBlock;
@end
