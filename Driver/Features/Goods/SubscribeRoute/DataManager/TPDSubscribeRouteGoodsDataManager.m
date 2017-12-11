//
//  TPDSubscribeRouteGoodsDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/11/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteGoodsDataManager.h"
#import "TPDExamineSubscribeRouteGoodsListAPI.h"
#import "TPDExamineAllSubscribeRouteGoodsListAPI.h"
#import "TPDModifySubscribeRoutetQueryTimeAPI.h"
@implementation TPDSubscribeRouteGoodsDataManager {
    
    NSString *_page;
    NSString *_requestType;
    NSString *_subscribeRouteId;
    
}
- (instancetype)initWithTarget:(id)target {
    self = [super init];
    if (self) {
        self.dataSource = [[TPDGoodsDataSource alloc]initWithTarget:target];
        _dataSource.noResultViewType = TPNoResultViewTypeSubscribeRouteResultNull;
        _page = @"1";
    }
    return self;
}


//加载更多货源
- (void)pullUpGoods{
  
    if ([_requestType isEqualToString:@"1"]) {
        [self requestPullUpSubscribeRouteGoodsWithSubscribeRouteId:_subscribeRouteId];
    }else{
        [self requestPullUpAllSubscribeRouteGoods];
    }
}

//刷新货源
- (void)pullDownGoods {
    if ([_requestType isEqualToString:@"1"]) {
        [self requestPullUpSubscribeRouteGoodsWithSubscribeRouteId:_subscribeRouteId];
    }else{
        [self requestPullDownAllSubscribeRouteGoods];
    }
}



#pragma mark - 请求订阅路线全部货源列表
- (void)requestAllSubscribeRouteGoods{
    
    TPDExamineAllSubscribeRouteGoodsListAPI *api = [[TPDExamineAllSubscribeRouteGoodsListAPI alloc]initWithPage:_page];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
       [self.dataSource appendItemsWithResponseObject:responseObject];
        if (self.fetchGoodsComplete) {
            self.fetchGoodsComplete();
        }
        
    };
    
    [api start];
}

#pragma mark - 请求订阅路线全部货源列表 - 上拉
- (void)requestPullUpAllSubscribeRouteGoods{
    
    _page = [NSString stringWithFormat:@"%d",_page.intValue + 1];

    [self requestAllSubscribeRouteGoods];
}

- (void)requestPullDownAllSubscribeRouteGoods{
    
    _page = @"1";
    
    [self requestAllSubscribeRouteGoods];
}

#pragma mark - 请求订阅路线全部货源列表 - 通过订阅路线id
- (void)requestSubscribeRouteGoodsWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId {
    
    _requestType = @"1";
    _subscribeRouteId = subscribeRouteId;
    TPDExamineSubscribeRouteGoodsListAPI *api = [[TPDExamineSubscribeRouteGoodsListAPI alloc]initWithSubscribeRouteId:_subscribeRouteId page:_page];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        [self.dataSource appendItemsWithResponseObject:responseObject];
        if (self.fetchGoodsComplete) {
            self.fetchGoodsComplete();
        }
        
    };
    
    [api start];
    
}

#pragma mark - 请求订阅路线全部货源列表 - 通过订阅路线id - 上拉
- (void)requestPullUpSubscribeRouteGoodsWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId  {
    
    
    _page = [NSString stringWithFormat:@"%d",_page.intValue + 1];
    
    [self requestSubscribeRouteGoodsWithSubscribeRouteId:subscribeRouteId];
    
}

#pragma mark - 请求订阅路线全部货源列表 - 通过订阅路线id - 下拉
- (void)requestPullDownSubscribeRouteGoodsWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId {
    
    _page = @"1";
      [self requestSubscribeRouteGoodsWithSubscribeRouteId:subscribeRouteId];;
}
#pragma mark - 请求修改订阅路线查询时间
- (void)requestModifySubscribeRouteQueryTimeAPIWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId {
    
    //如果为全部就是0
    TPDModifySubscribeRoutetQueryTimeAPI *api = [[TPDModifySubscribeRoutetQueryTimeAPI alloc]initWithSubscribeLineId:subscribeRouteId];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        TPHiddenLoading;
        
        
    };
    [api start];
}
@end
