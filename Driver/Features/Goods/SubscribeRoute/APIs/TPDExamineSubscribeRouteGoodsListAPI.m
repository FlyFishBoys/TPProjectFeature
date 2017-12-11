//
//  TPDExamineSubscribeRouteGoodsListAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDExamineSubscribeRouteGoodsListAPI.h"

@implementation TPDExamineSubscribeRouteGoodsListAPI {
    
    NSString *_page;
    NSString *_subscribeRouteId;
}

- (instancetype)initWithSubscribeRouteId:(NSString *)subscribeRouteId page:(NSString *)page {
    
    self = [super init];
    if (self) {
        _page = page;
        _subscribeRouteId = subscribeRouteId;
    }
    return self;
}

- (id)businessParameters {
    
    return @{
             @"page":_page,
             @"subscribe_line_id":_subscribeRouteId
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/selectsubscribelineinfo";
}

- (NSString *)destination {
    
    return @"subscribeline.selectsubscribelineinfo";
}


@end
