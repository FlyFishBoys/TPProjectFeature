//
//  TPDProfileAuthenticationParameterAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/10/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileAuthenticationParameterAPI.h"

@implementation TPDProfileAuthenticationParameterAPI
- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}


- (id)businessParameters {
    return @{
             };
    
}

- (NSString *)requestMethod {
    
    return @"user-service/userpublic/queryusercentrerealnameauthentication";
}

- (NSString *)destination {
    
    return @"userpublic.queryusercentrerealnameauthentication";
}

@end
