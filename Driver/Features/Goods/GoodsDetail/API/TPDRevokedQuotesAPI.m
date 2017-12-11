//
//  TPDRevokedQuotesAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDRevokedQuotesAPI.h"
#import "TPDGoodsRouterEntry.h"

@interface TPDRevokedQuotesAPI () {
    NSArray *_quotesIds;
}

@end

@implementation TPDRevokedQuotesAPI

+ (void)load {
    [TPDGoodsRouterEntry registerRevokedQuotes];
}

- (instancetype)initWithQuotesIds:(NSArray<NSString *> *)quotesIds {
    if (self = [super init]) {
        _quotesIds = quotesIds;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/pregoods/drvierundooffer";
}

- (nullable NSString *)destination {
    return @"pregoods.drvierundooffer";
}

- (id)businessParameters {
    return @{
             @"pregoods_ids":_quotesIds,
             };
}

@end
