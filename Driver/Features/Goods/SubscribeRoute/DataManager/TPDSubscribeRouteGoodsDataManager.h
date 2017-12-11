//
//  TPDSubscribeRouteGoodsDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/11/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDGoodsDataSource.h"
#import "TPDGoodsViewModel.h"
typedef void (^SubscribeRouteFetchGoodsComplete)();
@interface TPDSubscribeRouteGoodsDataManager : NSObject

@property (nonatomic , strong) TPDGoodsDataSource *dataSource;

@property (nonatomic , copy) SubscribeRouteFetchGoodsComplete fetchGoodsComplete;

- (instancetype)initWithTarget:(id)target;
//TPNoResultViewTypeSubscribeRouteResultNull

//加载更多货源
- (void)pullUpGoods;

//刷新货源
- (void)pullDownGoods;

- (void)requestPullDownAllSubscribeRouteGoods;

- (void)requestPullDownSubscribeRouteGoodsWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId;

/**
 修改订阅路线查询时间
 
 @param subscribeRouteId 订阅路线id

 */
- (void)requestModifySubscribeRouteQueryTimeAPIWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId;
@end
