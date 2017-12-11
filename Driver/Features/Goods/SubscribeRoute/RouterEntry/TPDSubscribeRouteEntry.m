//
//  TPDSubscribeRouteEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/9/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteEntry.h"
#import "TPDSubscribeRouteController.h"
#import "TPDAddSubscribeRouteController.h"
#import "TPDSubscribeRouteGoodsListController.h"
@implementation TPDSubscribeRouteEntry

+ (void)registerSubscribeRouteList {
    
    [MGJRouter registerURLPattern:TPRouter_SubscribeRoute_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
       TPDSubscribeRouteController *vc = [[TPDSubscribeRouteController alloc]init];
        return vc;
    }];
    
}

+ (void)registerAddSubscribeRoute {

   [MGJRouter registerURLPattern:TPRouter_AddSubscribeRoute_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDAddSubscribeRouteController *vc = [[TPDAddSubscribeRouteController alloc]init];
        return vc;
    }];
    
}

+ (void)registerSubscribeRouteGoodsList {
    
   [MGJRouter registerURLPattern:TPRouter_SubscribeRouteGoodsList_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
       TPDSubscribeRouteGoodsListController *vc = [[TPDSubscribeRouteGoodsListController alloc]init];
       vc.subscribeRouteId = routerParameters[MGJRouterParameterUserInfo][@"subscribeRouteId"];
       vc.depart = routerParameters[MGJRouterParameterUserInfo][@"depart"];
       vc.destination = routerParameters[MGJRouterParameterUserInfo][@"destination"];
        return vc;
    }];
}

@end
