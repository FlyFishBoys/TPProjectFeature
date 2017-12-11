//
//  TPDIntegrityInquiryGoodsListViewModel.h
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
@class TPDIntegrityInquiryGoodsListItem,TPDIntegrityInquiryGoodsModel,TPBottomButtonModel;

@interface TPDIntegrityInquiryGoodsListViewModel : NSObject
@property (nonatomic, strong,readonly) NSArray <TPDIntegrityInquiryGoodsListItem *> * viewModels;
- (instancetype)initWithModels:(NSArray <TPDIntegrityInquiryGoodsModel *> *)models target:(id)target;
@end


@interface TPDIntegrityInquiryGoodsListItem : TPBaseTableViewItem

- (instancetype)initWithModel:(TPDIntegrityInquiryGoodsModel *)model;

@property (nonatomic,strong,readonly) TPDIntegrityInquiryGoodsModel * model;

/**
 出发地
 */
@property (nonatomic, copy, readonly) NSString * departCity;

/**
 目的地
 */
@property (nonatomic, copy, readonly) NSString * destinationCity;

/**
 货物信息
 */
@property (nonatomic, copy, readonly) NSString * goodsInfo;

/**
 时间
 */
@property (nonatomic, copy, readonly) NSString * time;

/**
 按钮的模型数组
 */
@property (nonatomic, strong) NSArray <TPBottomButtonModel *> * buttonModels;

@end
