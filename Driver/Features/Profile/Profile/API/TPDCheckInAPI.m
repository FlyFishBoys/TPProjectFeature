//
//  TPDCheckInAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/27.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCheckInAPI.h"

@implementation TPDCheckInAPI
- (NSString *)requestMethod {
    return @"user-service/userpublic/signin";
}

- (nullable NSString *)destination {
    return @"userpublic.signin";
}
- (BOOL)shouldShowLoadingHUD{
    return NO;
}
@end
