//
//  TPDProfileParameter API.m
//  TopjetPicking
//
//  Created by lish on 2017/10/24.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileParameterAPI.h"

@implementation TPDProfileParameterAPI
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
    
    return @"user-service/userpublic/usercentreparameterdriver";
}

- (NSString *)destination {
    
    return @"userpublic.usercentreparameterdriver";
}
- (BOOL)shouldShowLoadingHUD{
    return NO;
}
@end
