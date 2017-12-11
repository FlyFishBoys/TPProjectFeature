//
//  TPDIntegrityInquiryAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryAPI.h"

@implementation TPDIntegrityInquiryAPI
{
    NSString *_mobile;
}

- (instancetype)initWithMobile:(NSString *)mobile {
    if (self = [super init]) {
        _mobile = mobile;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"user-service/userpublic/queryintegrityofdriver";
}

- (nullable NSString *)destination {
    return @"userpublic.queryintegrityofdriver";
}

- (id)businessParameters {
    return @{
             @"mobile":_mobile ? : @"",
             };
}

@end
