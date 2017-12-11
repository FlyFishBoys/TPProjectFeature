//
//  TPDSubscribeRouteDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^RequestSubscribeRouteCompleteBlock)(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error);

typedef void (^RequestSubscribeRouteListCompleteBlock)(BOOL success, id  _Nonnull goodsListResponseObject, NSString * _Nullable goodsCount,TPBusinessError * _Nullable error);

@interface TPDSubscribeRouteDataManager : NSObject


/**
 请求订阅路线新增货源总数

 @param completeBlock blcok
 */
+ (void)requestSubscribeRouteGoodsCountAPIWithCompleteBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock;


/**
 请求订阅路线列表

 @param completeBlock block
 */
- (void)requestSubscribeRouteListAPIWithCompleteBlock:(RequestSubscribeRouteListCompleteBlock _Nullable )completeBlock;




/**
 请求添加订阅路线

 @param departCityCode 出发地id
 @param destinationCityCode 目的地id
 @param truckTypeId 车型id
 @param truckLengthId 车长id
 */
- (void)requestAddSubscribeRouteAPIWithDepartCode:(NSString *_Nullable)departCityCode destinationCityCode:(NSString *_Nullable)destinationCityCode truckTypeId:(NSString *_Nullable)truckTypeId truckLengthId:(NSString *_Nullable)truckLengthId completeBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock;




/**
 请求删除订阅路线

 @param listArr 路线的集合
 @param completeBlock block
 */
- (void)requestDeleteSubscribeRouteAPIWithRouteList:(NSMutableArray *_Nullable)listArr completeBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock;



/**
 请求修改订阅路线(没有用到)
 
 @param subscribeRouteId 订阅路线id
 @param departCityCode 出发地id
 @param destinationCityCode 目的地id
 @param truckTypeId 车型id
 @param truckLengthId 车长id
 */
- (void)requestModifySubscribeRouteAPIWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId departCode:(NSString *_Nullable)departCityCode destinationCityCode:(NSString *_Nullable)destinationCityCode truckTypeId:(NSString *_Nullable)truckTypeId truckLengthId:(NSString *_Nullable)truckLengthId completeBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock;




@end


