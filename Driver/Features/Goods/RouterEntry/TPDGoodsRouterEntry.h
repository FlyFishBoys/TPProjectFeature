//
//  TPDGoodsRouterEntry.h
//  TopjetPicking
//
//  Created by lish on 2017/9/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDGoodsRouterEntry : NSObject

+ (void)registerGoodsDetail;

+ (void)registerNearSupply;

/** 注册撤销报价操作 */
+ (void)registerRevokedQuotes;

@end
