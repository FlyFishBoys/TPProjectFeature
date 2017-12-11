//
//  TPDSubscribeRouteListAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteListAPI.h"

@implementation TPDSubscribeRouteListAPI
- (instancetype)init {
    
    if (self = [super init]) {
        
    }
    return self;
}

- (id)businessParameters {
    return @{
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/selectsubscribelinelist";
}

- (NSString *)destination {
    
    return @"subscribeline.selectsubscribelinelist";
}
@end
