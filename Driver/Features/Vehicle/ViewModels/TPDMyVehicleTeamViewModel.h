//
//  TPDMyVehicleTeamViewModel.h
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
@class TPDMyVehicleTeamItemViewModel,TPDMyVehicleTeamModel;

@interface TPDMyVehicleTeamViewModel : NSObject
@property (nonatomic, strong,readonly) NSArray <TPDMyVehicleTeamItemViewModel *> * viewModels;
- (instancetype)initWithModels:(NSArray <TPDMyVehicleTeamModel *> *)models target:(id)target;
@end


@interface TPDMyVehicleTeamItemViewModel : TPBaseTableViewItem
- (instancetype)initWithModel:(TPDMyVehicleTeamModel *)model;
@property (nonatomic,strong,readonly) TPDMyVehicleTeamModel * model;

/**
 车牌号
 */
@property (nonatomic, copy) NSString * plate;

/**
 车牌号背景图片
 */
@property (nonatomic, strong) UIImage * plateBackgroundImage;

/**
 车型车长
 */
@property (nonatomic, copy) NSString * truckTypeLength;

/**
 备注
 */
@property (nonatomic, copy) NSString * remark;

/**
 是否是求货
 */
@property (nonatomic, assign) BOOL isSeekingGoods;

/**
 是否已认证
 */
@property (nonatomic, assign) BOOL isAudit;
@end
