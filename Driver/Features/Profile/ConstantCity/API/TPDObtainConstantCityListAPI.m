//
//  TPDObtainConstantCityListAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDObtainConstantCityListAPI.h"

@implementation TPDObtainConstantCityListAPI
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
    
    return @"truck-service/truck/businesslinelist";
}

- (NSString *)destination {
    
    return @"truck.businesslinelist";
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
