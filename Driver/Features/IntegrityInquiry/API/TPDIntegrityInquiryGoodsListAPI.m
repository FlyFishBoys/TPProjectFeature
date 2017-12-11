//
//  TPDIntegrityInquiryGoodsListAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryGoodsListAPI.h"

@implementation TPDIntegrityInquiryGoodsListAPI
{
    NSInteger _page;
    NSString * _userId;
}

- (instancetype)initWithUserId:(NSString *)userId page:(NSInteger)page {
    if (self = [super init]) {
        _userId = userId;
        _page = page;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"user-service/userpublic/queryintegrityofdriverpaging";
}

- (nullable NSString *)destination {
    return @"userpublic.queryintegrityofdriverpaging";
}

- (id)businessParameters {
    return @{
             @"user_id":_userId ? : @"",
             @"page":@(_page),
             };
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
