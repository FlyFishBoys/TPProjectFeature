//
//  TPDOrderDetailViewModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDOrderDetailModel,TPOrerDetailExpandViewModel,TPSenderReceiverViewModel,TPBottomButtonModel,TPDOrderDetailShipperInfoViewModel,TPOrderDetailMapViewModel,TPOrerDetailFreightViewModel,TPDropdownMenuModel;

@interface TPDOrderDetailViewModel : NSObject
- (instancetype)initWithModel:(TPDOrderDetailModel *)model;
@property (nonatomic, strong,readonly) TPDOrderDetailModel * model;


/**
 提示文字
 */
@property (nonatomic, copy) NSString * tips;

/**
 进度条进度
 */
@property (nonatomic, assign) NSInteger progressHighlightedIndex;

/**
 货主信息
 */
@property (nonatomic, strong) TPDOrderDetailShipperInfoViewModel * shipperViewModel;

/**
 地图信息
 */
@property (nonatomic, strong) TPOrderDetailMapViewModel * mapViewModel;

/**
 发货信息
 */
@property (nonatomic, strong) TPSenderReceiverViewModel * senderViewModel;

/**
 收货信息
 */
@property (nonatomic, strong) TPSenderReceiverViewModel * receiverViewModel;

/**
 运费信息
 */
@property (nonatomic, strong) TPOrerDetailFreightViewModel * freightViewModel;

/**
 定金
 */
@property (nonatomic, copy) NSString * deposit;

/**
 定金标题
 */
@property (nonatomic, copy) NSString * depositTitle;

/**
 定金托管状态
 */
@property (nonatomic, copy) NSString * depositPayStatus;

/**
 展开视图
 */
@property (nonatomic, strong) TPOrerDetailExpandViewModel * expandViewModel;

/**
 按钮的模型数组
 */
@property (nonatomic, strong) NSArray <TPBottomButtonModel *> * buttonModels;

/**
 提示文字高度
 */
@property (nonatomic, assign) CGFloat tipsHeight;

/**
 定金高度
 */
@property (nonatomic, assign) CGFloat depositHeight;

/**
 导航条右按钮的模型数组
 */
@property (nonatomic, strong) NSArray <TPDropdownMenuModel *> * dropdownMenuModels;
@end
