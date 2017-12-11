//
//  TPDExamineAllSubscribeRouteGoodsListAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDExamineAllSubscribeRouteGoodsListAPI.h"

@implementation TPDExamineAllSubscribeRouteGoodsListAPI
{
    
    NSString *_page;
}

- (instancetype)initWithPage:(NSString *)page {
    
    self = [super init];
    if (self) {
        _page = page;
    }
    return self;
}

- (id)businessParameters {
    
    return @{
             @"page":_page
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/selectsubscribelineallgoods";
}

- (NSString *)destination {
    
    return @"subscribeline.selectsubscribelineallgoods";
}


@end
