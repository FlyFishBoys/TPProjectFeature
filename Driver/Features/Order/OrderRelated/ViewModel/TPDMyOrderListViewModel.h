//
//  TPDMyOrderListViewModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
@class TPDMyOrderListItemViewModel,TPDMyOrderListModel,TPBottomButtonModel;

@interface TPDMyOrderListViewModel : NSObject

@property (nonatomic, strong,readonly) NSArray <TPDMyOrderListItemViewModel *> * viewModels;
- (instancetype)initWithModels:(NSArray <TPDMyOrderListModel *> *)models target:(id)target;

@end


@interface TPDMyOrderListItemViewModel : TPBaseTableViewItem

- (instancetype)initWithModel:(TPDMyOrderListModel *)model;

@property (nonatomic,strong,readonly) TPDMyOrderListModel * model;

/**
 出发地
 */
@property (nonatomic, copy, readonly) NSString * departCity;

/**
 目的地
 */
@property (nonatomic, copy, readonly) NSString * destinationCity;

/**
 订单状态
 */
@property (nonatomic, copy, readonly) NSString * status;

/**
 提货时间
 */
@property (nonatomic, copy, readonly) NSString * pickupTime;


/**
 更新时间
 */
@property (nonatomic, copy, readonly) NSString * updateTime;

/**
 费用：运费金额+运费状态+定金金额+定金状态
 */
@property (nonatomic, copy, readonly) NSString * fee;

/**
 订单状态图
 */
@property (nonatomic, strong, readonly) UIImage * statusImage;

/**
 货主头像
 */
@property (nonatomic, strong, readonly) UIImage * icon;

/**
 星星数量
 */
@property (nonatomic, assign, readonly) CGFloat starScore;

/**
 名字
 */
@property (nonatomic, copy, readonly) NSString * name;


/**
 按钮的模型数组
 */
@property (nonatomic, strong) NSArray <TPBottomButtonModel *> * buttonModels;

@end
