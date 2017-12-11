//
//  TPDAddVehicleAPI.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"
@class TPDAddModifyVehicleModel;

@interface TPDAddVehicleAPI : TPBaseAPI

/**
 添加车辆

 @param model 添加车辆模型
 @return 初始化对象
 */
- (instancetype)initWithModel:(TPDAddModifyVehicleModel *)model;
@end
