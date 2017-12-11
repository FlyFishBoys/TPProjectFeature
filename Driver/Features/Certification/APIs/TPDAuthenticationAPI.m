//
//  TPDAuthenticationAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/27.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAuthenticationAPI.h"

@implementation TPDAuthenticationAPI

- (NSString *)requestMethod {
    return @"user-service/userpublic/getusercentretypeauthdriver";
}

- (nullable NSString *)destination {
    return @"userpublic.getusercentretypeauthdriver";
}

@end
