//
//  TPDSubscribeRouteEntry.h
//  TopjetPicking
//
//  Created by lish on 2017/9/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDSubscribeRouteEntry : NSObject
//注册订阅路线
+ (void)registerSubscribeRouteList;

//注册添加订阅路线
+ (void)registerAddSubscribeRoute;

//注册订阅路线货源列表
+ (void)registerSubscribeRouteGoodsList;

@end
