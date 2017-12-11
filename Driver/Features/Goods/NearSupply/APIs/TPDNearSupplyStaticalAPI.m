//
//  TPDNearSupplyStaticalAPI.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearSupplyStaticalAPI.h"
#import "TPDNearbyMapStaticalModel.h"

@implementation TPDNearSupplyStaticalAPI
{
    NSDictionary *params_;
    NSInteger page_;
}
- (instancetype)initWithParams:(NSDictionary *)params page:(NSInteger)page {
    
    if(self = [super init]){
        params_ = params;
        page_ = page;
    }
    return self;
}


- (NSString *)requestMethod {
    
    return @"order-service/drivergoods/getneargoodstolist";
}
- (NSString *)destination {
    
    return @"drivergoods.getneargoodstolist";
}
- (id)businessParameters {
    
    return params_;
    
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}
//- (id)apiBussinessResponseObjReformer:(id)responseObject andError:(NSError *)error {
//    if ([responseObject isKindOfClass:[NSNull class]] || responseObject == nil) {
//        return nil;
//    }
//    
//    if ([responseObject[@"result"] isKindOfClass:[NSNull class]] || responseObject[@"result"] == nil) {
//        return nil;
//    }
//    
//    if ([responseObject[@"result"][@"data"] isKindOfClass:[NSNull class]] || responseObject[@"result"][@"data"] == nil) {
//        return nil;
//    }
//    return [NSArray yy_modelArrayWithClass:[TPDNearbyMapStaticalModel class] json:responseObject[@"result"][@"data"]];
//}
@end
