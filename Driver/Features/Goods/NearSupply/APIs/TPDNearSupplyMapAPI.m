//
//  TPDNearSupplyMapAPI.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearSupplyMapAPI.h"

@interface TPDNearSupplyMapAPI()
{
    NSDictionary *params_;
}
@end

@implementation TPDNearSupplyMapAPI
- (instancetype)initWithParams:(NSDictionary *)params {
    if(self = [super init]){
        params_ = params;
    }
    return self;
}


- (NSString *)requestMethod {
    
    return @"order-service/drivergoods/getneargoodstomap";
}
- (NSString *)destination {
    
    return @"drivergoods.getneargoodstomap";
}
- (id)businessParameters {
    
    return params_;
    
}

- (BOOL)shouldShowLoadingHUD{
    return NO;
}

@end
