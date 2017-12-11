//
//  TPDFindGoodsDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDGoodsDataSource.h"
typedef void (^FindGoodsFetchFreightAgentComplete)(BOOL isHave);
typedef void (^FindGoodsFetchComplete)();
typedef void (^FindGoodsRequestCompleteBlock)(BOOL success, id responseObject, TPBusinessError *error);
typedef void (^FindGoodsLocationComplete)(BOOL locationSuccess, NSString *locationAddress);
@interface TPDSmartFindGoodsDataManager : NSObject

@property (nonatomic , strong) TPDGoodsDataSource *dataSource;

//获取货源数据完成
@property (nonatomic , copy) FindGoodsFetchComplete fetchHandler;



//定位完成
@property (nonatomic , copy) FindGoodsLocationComplete locationHandler;

//是否有货运经济人
@property (nonatomic , copy) FindGoodsFetchFreightAgentComplete fetchFreightAgentComplete;


@property (nonatomic , copy) NSString *requestDepartCityCode;


@property (nonatomic , copy) NSString *requestDestinationCityCode;

- (instancetype)initWithTarget:(id)target;

/**
 请求默认货源
 */
- (void)fetchDefaultGoods;

//加载更多货源
- (void)pullUpGoods;

//刷新货源
- (void)pullDownGoods;

/**
 筛选出发地货源

 @param departCityCode 出发地adcode
 */
- (void)fetchGoodsWithDepartCityCode:(NSString *)departCityCode;


/**
 筛选目的地货源

 @param destinationCityCode 目的到code
 */
- (void)fetchGoodsWithDestinationCityCode:(NSString *)destinationCityCode;


/**
 筛选车型车长货源

 @param truckTypeId 车长id
 @param truckLengthId 车型id
 */
- (void)fetchGoodsWithTruckTypeId:(NSString *)truckTypeId truckLengthId:(NSString *)truckLengthId;


/**
 请求订阅的货源数量

 @param complete complete description
 */
- (void)fetchSubscibeGoodsCountWithComplte:(void(^)(NSString *goodsCount))complete;

@end
