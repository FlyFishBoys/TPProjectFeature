//
//  TPDOrderDetailDataManager.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDOrderDefines.h"

@interface TPDOrderDetailDataManager : NSObject
/**
 请求订单详情
 
 @param orderId 订单id
 @param completeBlock 请求到的参数
 */
- (void)requestGoodsDetailWithOrderId:(NSString * _Nullable)orderId completeBlock:(RequestModelCompleteBlock _Nonnull )completeBlock;

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
