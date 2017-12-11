//
//  TPDIntegrityInquiryViewModel.h
//  Driver
//
//  Created by Mr.mao on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDIntegrityInquiryModel;

@interface TPDIntegrityInquiryViewModel : NSObject

@property(nonatomic,strong,readonly) TPDIntegrityInquiryModel * model;
- (instancetype)initWithModel:(TPDIntegrityInquiryModel *)model;


/**
 姓名
 */
@property (nonatomic,copy) NSString * name;

/**
 身份类型
 */
@property (nonatomic,copy) NSString * userType;

/**
 是否实名认证
 */
@property (nonatomic,assign) BOOL isVerified;

/**
 是否身份认证
 */
@property (nonatomic,assign) BOOL isAuthentication;

/**
 是否车辆认证
 */
@property (nonatomic,assign) BOOL isVehicleCertification;

/**
 车辆认证是否隐藏
 */
@property (nonatomic,assign) BOOL isHiddenVehicleCertification;

/**
 星级
 */
@property (nonatomic,assign) CGFloat score;

/**
 评分
 */
@property (nonatomic,copy) NSString * starRating;

/**
 诚信值等级
 */
@property (nonatomic,copy) NSString * integrityLevel;

/**
 诚信值
 */
@property (nonatomic,copy) NSString * integrityValue;

/**
 接单数
 */
@property (nonatomic,copy) NSString * receivingNum;

/**
 成交数
 */
@property (nonatomic,copy) NSString * clinchDealNum;

@end
