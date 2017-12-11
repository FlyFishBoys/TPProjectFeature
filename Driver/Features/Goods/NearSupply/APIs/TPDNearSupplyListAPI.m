//
//  TPDNearSupplyListAPI.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearSupplyListAPI.h"

@interface TPDNearSupplyListAPI()
{
    NSDictionary *params_;
}
@end

@implementation TPDNearSupplyListAPI
- (instancetype)initWithParams:(NSDictionary *)params {
    
    if(self = [super init]){
        params_ = params;
    }
    return self;
}

- (NSString *)requestMethod {
    
    return @"order-service/drivergoods/getneargoodstotable";
}
- (NSString *)destination {
    
    return @"drivergoods.getneargoodstotable";
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
//    return responseObject[@"result"][@"data"][@"near_goods_response_list"];
//}
@end
