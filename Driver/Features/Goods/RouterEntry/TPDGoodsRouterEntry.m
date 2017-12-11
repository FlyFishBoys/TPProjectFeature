//
//  TPDGoodsRouterEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/9/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsRouterEntry.h"
#import "TPDGoodsDetailViewController.h"
#import "TPDNearSupplyViewController.h"
#import "TPDRevokedQuotesAPI.h"

@implementation TPDGoodsRouterEntry
+ (void)registerGoodsDetail {
  
    [MGJRouter registerURLPattern:TPRouter_GoodsDetail_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDGoodsDetailViewController * goodsDetailViewController = [[TPDGoodsDetailViewController alloc]init];
        goodsDetailViewController.goodId = routerParameters[MGJRouterParameterUserInfo][@"goodsId"];
        return goodsDetailViewController;
    }];
}

+ (void)registerNearSupply {

    [MGJRouter registerURLPattern:TPRouter_NearSupply_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
         TPDNearSupplyViewController *controller = [[TPDNearSupplyViewController alloc] init];
        return controller;
    }];
}

+ (void)registerRevokedQuotes {
    [MGJRouter registerURLPattern:TPRouter_Goods_Operating_Revoked_Quotes toHandler:^(NSDictionary *routerParameters) {
        NSArray * quotesIds = routerParameters[MGJRouterParameterUserInfo][@"quotesIds"];
        void(^handler)(BOOL success,TPBusinessError * error) = routerParameters[MGJRouterParameterUserInfo][MGJRouterParameterCompletion];
        TPDRevokedQuotesAPI * api = [[TPDRevokedQuotesAPI alloc] initWithQuotesIds:quotesIds];
        api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
            if (success && error == nil) {
                handler(YES,nil);
            } else {
                handler(NO,error);
            }
        };
        [api start];
    }];
}
@end
