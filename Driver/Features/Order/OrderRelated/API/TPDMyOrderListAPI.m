//
//  TPDMyOrderListAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyOrderListAPI.h"

@interface TPDMyOrderListAPI ()
{
    NSString *_status;
    NSInteger _page;
}

@end

@implementation TPDMyOrderListAPI
- (instancetype)initWithStatus:(NSString *)status page:(NSInteger)page {
    if (self = [super init]) {
        _status = status;
        _page = page;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/driverorder/driverorderlist";
}

- (nullable NSString *)destination {
    return @"driverorder.driverorderlist";
}

- (id)businessParameters {
    return @{
             @"status":_status.isNotBlank ? _status : @"",
             @"page":@(_page),
             };
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
