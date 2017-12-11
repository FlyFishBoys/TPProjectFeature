//
//  TPDVehicleDetailViewModel.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDVehicleDetailModel;

@interface TPDVehicleDetailViewModel : NSObject
@property (nonatomic,strong,readonly) TPDVehicleDetailModel * model;
- (instancetype)initWithModel:(TPDVehicleDetailModel *)model;


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
 姓名
 */
@property (nonatomic, copy) NSString * name;

/**
 电话
 */
@property (nonatomic, copy) NSString * mobile;

/**
 备注高度
 */
@property (nonatomic, assign) CGFloat remarkHeight;

/**
 电话高度
 */
@property (nonatomic, assign) CGFloat  mobileHeight;

/**
 名字高度
 */
@property (nonatomic, assign) CGFloat nameHeight;

/**
 底部按钮高度
 */
@property (nonatomic, assign) CGFloat bottomButtonHeight;

/**
 提示高度
 */
@property (nonatomic, assign) CGFloat tipsViewHeight;
@end
