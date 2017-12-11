//
//  TPDVehicleCertificationViewModel.h
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDVehicleCertificationModel;

@interface TPDVehicleCertificationViewModel : NSObject
- (instancetype)initWithModel:(TPDVehicleCertificationModel *)model;
@property (nonatomic, strong,readonly) TPDVehicleCertificationModel * model;

/**
 车牌号城市
 */
@property (nonatomic, copy) NSString * plateCity;

/**
 车牌号
 */
@property (nonatomic, copy) NSString * plateNo;

/**
 车牌号
 */
@property (nonatomic, copy) NSString * plate;

/**
 车牌颜色
 */
@property (nonatomic, copy) NSString * plateColor;

/**
 车型车长
 */
@property (nonatomic, copy) NSString * truckTypeLength;

/**
 是否能修改
 */
@property (nonatomic,assign) BOOL isEnble;

@end
