//
//  TPDOrderDetailShipperInfoViewModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDOrderDetailShipperInfoModel;

@interface TPDOrderDetailShipperInfoViewModel : NSObject
- (instancetype)initWithModel:(TPDOrderDetailShipperInfoModel *)model;
@property (nonatomic, strong,readonly) TPDOrderDetailShipperInfoModel * model;

/**
 名字
 */
@property (nonatomic, copy) NSString * name;

/**
 电话
 */
@property (nonatomic, copy) NSString * dealRecord;

/**
 车辆信息
 */
@property (nonatomic, copy) NSString * mobile;

/**
 星星数量
 */
@property (nonatomic, assign) CGFloat starScore;
@end
