//
//  TPDListenOrderDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDGoodsDataSource.h"
#import "TPDListenOrderSetDataSource.h"
#import "TPDListenOrderDataStorage.h"
#import "TPDListenOrderToolDefine.h"
@class TPDListenOrderSetModel;
typedef void (^ListenOrderFetchComplete)();
typedef void (^ListenOrderFetchLocationComplete)(BOOL isLocationSuccess);
typedef void (^ListenOrderStatusChangeBlock)(ListenOrderSwicthStatus status);
typedef void (^ListenOrderFetchSetComplete)(NSString *depart,NSString *destination);
@interface TPDListenOrderDataManager : NSObject

//货源数据源
@property (nonatomic , strong) TPDGoodsDataSource *goodsDataSource;

//听单设置数据源
@property (nonatomic , strong) TPDListenOrderSetDataSource *listenOrderSetDataSource;

//数据存储
@property (nonatomic , strong) TPDListenOrderDataStorage *dataStorage;

//听单状态
@property (nonatomic , assign) ListenOrderSwicthStatus listenOrderStatus;

//获取货源回调
@property (nonatomic , copy) ListenOrderFetchComplete fetchGoodsComplete;

//听单开关状态改变
@property (nonatomic , copy) ListenOrderStatusChangeBlock listenOrderStausChanged;

//辅助菜单听单状态改变
@property (nonatomic , copy) ListenOrderStatusChangeBlock ATlistenOrderStausChanged;

//获取听单设置完成
@property (nonatomic , copy) ListenOrderFetchSetComplete fetchListenOrderSetComplete;

//定位完成
@property (nonatomic , copy) ListenOrderFetchLocationComplete locationComplete;

@property (nonatomic , strong) id target;

+ (instancetype)sharedInstance;

/**
 获取听单货源
 */
- (void)fetchListenOrderGoods;

/**
 更新听单开关设置

 */
- (void)updateListenOrderSet;

/**
 更新听单开关状态
 */
- (void)updateListenOrderSwitchStatus;


/**
 获取听单开关状态
 */
- (void)fetchListenOrderSwitchStatus;


/**
 清除听单所有数据
 */
- (void)clearAllListenOrderGoods;

/**
 定位

 @param complete complete description
 */
- (void)obtainLocationInforWithComplete:(void(^)(TPDListenOrderSetModel *model))complete;


/**
 刷新听单设置数据
 */
- (void)refreshListenOrderSetDataSource;


/**
 删除听单货源

 @param goodsId goodsId description
 */
- (void)removeGoodsWithGoodsId:(NSString *)goodsId;


/**
 货源打电话记录

 @param goodsId goodsId description
 */
- (void)callUpWithGoodsId:(NSString *)goodsId;


/**
 查看货源记录

 @param goodsId goodsId description
 */
- (void)lookupWithGoodsId:(NSString *)goodsId;

@end
