//
//  TPDCallRecordsListAPI.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCallRecordsListAPI.h"
#import "TPDCallRecordItem.h"

@implementation TPDCallRecordsListAPI

{
    NSString *page_;
}
- (instancetype)initWithPage:(NSString *)page {
    if (self = [super init]) {
        page_ = page;
    }
    return self;
}
- (NSString *)destination {
    
    return @"usercenter.callrecords";
}

- (NSString *)requestMethod {
    return @"order-service/usercenter/callrecords";
}

- (id)businessParameters {
    return @{@"page" : page_.isNotBlank ? page_ : @"1"};
}
- (id)apiBussinessResponseObjReformer:(id)responseObject andError:(NSError *)error {
    if ([responseObject isKindOfClass:[NSNull class]] || responseObject == nil) {
        return nil;
    }
    
    if ([responseObject[@"result"] isKindOfClass:[NSNull class]] || responseObject[@"result"] == nil) {
        return nil;
    }
    
    if ([responseObject[@"result"][@"data"] isKindOfClass:[NSNull class]] || responseObject[@"result"][@"data"] == nil) {
        return nil;
    }
    return [NSArray yy_modelArrayWithClass:[TPDCallRecordItem class] json:responseObject[@"result"][@"data"][@"call_response_list"]];
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}

@end
