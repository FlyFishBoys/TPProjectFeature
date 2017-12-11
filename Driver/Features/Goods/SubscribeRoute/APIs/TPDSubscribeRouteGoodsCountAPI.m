//
//  TPDSubscribeRouteGoodsCountAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteGoodsCountAPI.h"

@implementation TPDSubscribeRouteGoodsCountAPI
- (instancetype)init {
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)businessParameters {
    return @{
             };
    
}
- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/selectnewsubscribelinsum";
}

- (NSString *)destination {
    
    return @"subscribeline.selectnewsubscribelinsum";
}
@end
