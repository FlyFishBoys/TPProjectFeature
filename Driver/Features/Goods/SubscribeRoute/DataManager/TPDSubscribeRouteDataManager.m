//
//  TPDSubscribeRouteDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteDataManager.h"

#import "TPDSubscribeRouteListAPI.h"
#import "TPDAddSubscribeRoutetAPI.h"
#import "TPDDeleteSubscribeRoutetAPI.h"
#import "TPDModifySubscribeRoutetAPI.h"
#import "TPDSubscribeRouteGoodsCountAPI.h"
#import "TPDSubscribeRouteModel.h"

@implementation TPDSubscribeRouteDataManager

#pragma mark - 请求订阅路线货源总数
+ (void)requestSubscribeRouteGoodsCountAPIWithCompleteBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock {
    
    TPDSubscribeRouteGoodsCountAPI *api = [[TPDSubscribeRouteGoodsCountAPI alloc]init];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
      
        if (success && !error) {
            completeBlock(YES,responseObject[@"goods_count"],error);
        }else{
           completeBlock(NO,responseObject,error);
        }
        
       
    };
    
    [api start];
}

#pragma mark - 请求订阅路线列表
- (void)requestSubscribeRouteListAPIWithCompleteBlock:(RequestSubscribeRouteListCompleteBlock _Nullable )completeBlock{
    
    TPDSubscribeRouteListAPI *api = [[TPDSubscribeRouteListAPI alloc]init];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
         TPHiddenLoading;
        if (success && !error) {
            
        NSMutableArray *tempArr = [NSArray yy_modelArrayWithClass:[TPDSubscribeRouteModel class] json:responseObject[@"list"]].mutableCopy;
           completeBlock(YES,tempArr,responseObject[@"supply_of_goods_count"],error);
            
        }else{
            completeBlock(NO,responseObject,nil,error);
        }
    };
    
    [api start];
}




#pragma mark - 请求添加订阅路线
- (void)requestAddSubscribeRouteAPIWithDepartCode:(NSString *_Nullable)departCityCode destinationCityCode:(NSString *_Nullable)destinationCityCode truckTypeId:(NSString *_Nullable)truckTypeId truckLengthId:(NSString *_Nullable)truckLengthId completeBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock {
   
    if (![departCityCode isNotBlank]) {
        TPShowToast(@"请选择出发地");
        return;
    }else if (![destinationCityCode isNotBlank]) {
        TPShowToast(@"请选择目的地");
        return;
    }
    
    TPDAddSubscribeRoutetAPI *api = [[TPDAddSubscribeRoutetAPI alloc]initWithDepartCode:departCityCode destinationCityCode:destinationCityCode truckTypeId:truckTypeId truckLengthId:truckLengthId];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        if (success && !error) {
            completeBlock(YES,responseObject,error);
        }else{
            completeBlock(NO,responseObject,error);
        }
        
    };
    
    [api start];
}

#pragma mark - 请求删除订阅路线
- (void)requestDeleteSubscribeRouteAPIWithRouteList:(NSMutableArray *_Nullable)listArr completeBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock {
    
    TPDDeleteSubscribeRoutetAPI *api = [[TPDDeleteSubscribeRoutetAPI alloc]initWithRouteIdList:listArr];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
            completeBlock(YES,responseObject,error);
        }else{
            completeBlock(NO,responseObject,error);
        }
    };
    [api start];
}

#pragma mark - 请求修改订阅路线
- (void)requestModifySubscribeRouteAPIWithSubscribeRouteId:(NSString *_Nullable)subscribeRouteId departCode:(NSString *_Nullable)departCityCode destinationCityCode:(NSString *_Nullable)destinationCityCode truckTypeId:(NSString *_Nullable)truckTypeId truckLengthId:(NSString *_Nullable)truckLengthId completeBlock:(RequestSubscribeRouteCompleteBlock _Nullable )completeBlock {
    
    TPDModifySubscribeRoutetAPI *api = [[TPDModifySubscribeRoutetAPI alloc]initWithSubscribeLineId:subscribeRouteId departCode:departCityCode destinationCityCode:destinationCityCode truckTypeId:truckTypeId truckLengthId:truckLengthId];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
      
        if (success && !error) {
            completeBlock(YES,responseObject,error);
        }else{
            completeBlock(NO,responseObject,error);
        }
    };
    
    [api start];
}


@end
