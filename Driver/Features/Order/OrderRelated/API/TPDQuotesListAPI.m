//
//  TPDQuotesListAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDQuotesListAPI.h"

@interface TPDQuotesListAPI ()
{
    NSInteger _page;
    NSString * _longitude;
    NSString * _latitude;
}
@end

@implementation TPDQuotesListAPI

- (instancetype)initWithPage:(NSInteger)page longitude:(NSString *)longitude latitude:(NSString *)latitude {
    if (self = [super init]) {
        _page = page;
        _longitude = longitude;
        _latitude = latitude;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/pregoods/drvierofferlist";
}

- (nullable NSString *)destination {
    return @"pregoods.drvierofferlist";
}

- (id)businessParameters {
    return @{
             @"page":@(_page),
             @"longitude":_longitude.isNotBlank ? _longitude : @"",
             @"latitude":_latitude.isNotBlank ? _latitude : @"",
             };
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
