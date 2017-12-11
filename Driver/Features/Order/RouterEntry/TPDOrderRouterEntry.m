//
//  TPSOrderRouterEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/9/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDOrderRouterEntry.h"
#import "TPDOrderDetailViewController.h"
#import "TPDQuotesListViewController.h"
@implementation TPDOrderRouterEntry
+ (void)registerOrderDetail {
    
    [MGJRouter registerURLPattern:TPRouter_OrderDetail_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDOrderDetailViewController * orderDetailViewController = [[TPDOrderDetailViewController alloc]init];
        orderDetailViewController.orderId = routerParameters[MGJRouterParameterUserInfo][@"orderId"];
        return orderDetailViewController;
    }];
  
}

+ (void)regisetrQuotesList {
    
    [MGJRouter registerURLPattern:TPRouter_QuotesList_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDQuotesListViewController * quotesListViewController = [[TPDQuotesListViewController alloc]init];
        return quotesListViewController;
    }];
}
@end
