//
//  TPDModifySubscribeRoutetQueryTimeAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDModifySubscribeRoutetQueryTimeAPI.h"

@implementation TPDModifySubscribeRoutetQueryTimeAPI {
    
    NSString *_subscribeLineId;
}

- (instancetype)initWithSubscribeLineId:(NSString *)subscribeLineId {
    
    self = [super init];
    if (self) {
    
        _subscribeLineId = subscribeLineId;
    }
    return self;
}

- (id)businessParameters {
    return @{
             @"subscribe_line_id":_subscribeLineId
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/updatesubscribelinequerytime";
}

- (NSString *)destination {
    
    return @"subscribeline.updatesubscribelinequerytime";
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
