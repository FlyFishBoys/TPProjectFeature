//
//  TPDQuotesListViewModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
@class TPDQuotesListItemViewModel,TPDQuotesListModel;


@interface TPDQuotesListViewModel : NSObject

@property (nonatomic, strong,readonly) NSArray <TPDQuotesListItemViewModel *> * viewModels;
- (instancetype)initWithModels:(NSArray <TPDQuotesListModel *> *)models target:(id)target;

@end

@interface TPDQuotesListItemViewModel : TPBaseTableViewItem

- (instancetype)initWithModel:(TPDQuotesListModel *)model;
@property (nonatomic,strong,readonly) TPDQuotesListModel * model;

/**
 车辆信息
 */
@property (nonatomic, copy, readonly) NSString * truckInfo;

/**
 地址
 */
@property (nonatomic, copy, readonly) NSString * address;

/**
 报价
 */
@property (nonatomic, copy, readonly) NSString * quotes;

/**
 定金
 */
@property (nonatomic, copy, readonly) NSString * deposit;

/**
 定金tag隐藏
 */
@property (nonatomic, assign, readonly) BOOL isHideDepositTag;

/**
 出发地
 */
@property (nonatomic, copy, readonly) NSString * departCity;

/**
 目的地
 */
@property (nonatomic, copy, readonly) NSString * destinationCity;

/**
 更新时间
 */
@property (nonatomic, copy, readonly) NSString * updateTime;


/**
 是否选择cell
 */
@property (nonatomic, assign) BOOL isSelected;

@end
