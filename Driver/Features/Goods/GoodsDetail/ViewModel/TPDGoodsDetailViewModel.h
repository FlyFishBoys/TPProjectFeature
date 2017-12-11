//
//  TPDGoodsDetailViewModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDGoodsDetailModel,TPSenderReceiverViewModel,TPBottomButtonModel;

@interface TPDGoodsDetailViewModel : NSObject
- (instancetype)initWithModel:(TPDGoodsDetailModel *)model;
@property (nonatomic, strong,readonly) TPDGoodsDetailModel * model;

/**
 提示文字
 */
@property (nonatomic, copy) NSString * tips;

/**
 提示文字右边文字
 */
@property (nonatomic, copy) NSAttributedString * tipsRightAttributed;

/**
 订单号
 */
@property (nonatomic, copy) NSString * orderSerial;

/**
 订单时间
 */
@property (nonatomic, copy) NSString * orderTime;

/**
 货源信息
 */
@property (nonatomic, copy) NSString * goodsInfo;

/**
 备注文字
 */
@property (nonatomic, copy) NSString * remarkText;

/**
 报价定金金额
 */
@property(nonatomic,copy)   NSAttributedString * quotesAmountAttributed;

/**
 距离
 */
@property (nonatomic, copy) NSString * distance;

/**
 距离高度
 */
@property (nonatomic, assign) CGFloat distanceHeight;

/**
 货源高度
 */
@property (nonatomic, assign) CGFloat goodsInfoHeight;

/**
 货主信息高度
 */
@property (nonatomic, assign) CGFloat shipperInfoHeight;

/**
 报价高度
 */
@property (nonatomic, assign) CGFloat quotesHeight;

/**
 备注高度
 */
@property (nonatomic, assign) CGFloat remarkHeight;

/**
 备注图片高度
 */
@property (nonatomic, assign) CGFloat remarkImageHeight;

/**
 发货信息
 */
@property (nonatomic, strong) TPSenderReceiverViewModel * senderViewModel;

/**
 收货信息
 */
@property (nonatomic, strong) TPSenderReceiverViewModel * receiverViewModel;

/**
 按钮的模型数组
 */
@property (nonatomic, strong) NSArray <TPBottomButtonModel *> * buttonModels;

@end
