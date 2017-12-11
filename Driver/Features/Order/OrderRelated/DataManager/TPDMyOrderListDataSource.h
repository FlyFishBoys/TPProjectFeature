//
//  TPDMyOrderListDataSource.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"
#import "TPDOrderDefines.h"

@interface TPDMyOrderListDataSource : TPBaseTableViewDataSource

- (instancetype _Nonnull)initWithTarget:(id _Nonnull)target;

//刷新我的订单数据
- (void)refreshMyOrderListWithStatus:(NSString *_Nullable)status completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

//加载更多我的订单数据
- (void)loadMoreMyOrderListWithStatus:(NSString *_Nullable)status completeBlock:(RequestListCompleteBlock _Nonnull )completeBlock;


/**
 货物签收
 
 @param orderId 订单id
 @param orderVersion 订单版本
 @param unloadCode 卸货吗
 @param completeBlock 请求到的参数
 */
- (void)goodsSignUpWithOrderId:(NSString *_Nullable)orderId orderVersion:(NSString *_Nullable)orderVersion unloadCode:(NSString *_Nullable)unloadCode completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

/**
 确认提货
 
 @param orderId 订单id
 @param orderVersion 订单版本
 @param pickupCode 提货码
 @param completeBlock 请求到的参数
 */
- (void)confirmPickUpWithOrderId:(NSString *_Nullable)orderId orderVersion:(NSString *_Nullable)orderVersion pickupCode:(NSString *_Nullable)pickupCode completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

/**
 确认承接
 
 @param orderId 订单id
 @param orderVersion 订单版本
 @param completeBlock 请求到的参数
 */
- (void)confirmDealWithOrderId:(NSString *_Nullable)orderId orderVersion:(NSString *_Nullable)orderVersion completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

/**
 放弃承接
 
 @param orderId 订单id
 @param orderVersion 订单版本
 @param completeBlock 请求到的参数
 */
- (void)cancelDealWithOrderId:(NSString *_Nullable)orderId orderVersion:(NSString *_Nullable)orderVersion completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;
@end
