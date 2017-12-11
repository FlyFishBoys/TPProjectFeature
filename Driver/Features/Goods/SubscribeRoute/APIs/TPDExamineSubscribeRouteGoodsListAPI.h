//
//  TPDExamineSubscribeRouteGoodsListAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDExamineSubscribeRouteGoodsListAPI : TPBaseAPI


/**
 查看订阅路线货源列表

 @param subscribeRouteId 订阅路线id
 @param page 页码
 @return object
 */
- (instancetype)initWithSubscribeRouteId:(NSString *)subscribeRouteId page:(NSString *)page;

@end
