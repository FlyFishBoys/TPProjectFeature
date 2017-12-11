//
//  TPDModifyVehicleViewModel.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDAddModifyVehicleModel;

@interface TPDModifyVehicleViewModel : NSObject
@property (nonatomic,strong,readonly) TPDAddModifyVehicleModel * model;
- (instancetype)initWithModel:(TPDAddModifyVehicleModel *)model;


/**
 车牌号
 */
@property (nonatomic, copy) NSString * plateNo;

/**
 车牌城市
 */
@property (nonatomic, copy) NSString * plateCity;

/**
 车牌颜色
 */
@property (nonatomic, copy) NSString * plateColor;

/**
 车型车长
 */
@property (nonatomic, copy) NSString * truckTypeLength;

/**
 姓名
 */
@property (nonatomic, copy) NSString * name;

/**
 电话
 */
@property (nonatomic, copy) NSString * mobile;

@end
