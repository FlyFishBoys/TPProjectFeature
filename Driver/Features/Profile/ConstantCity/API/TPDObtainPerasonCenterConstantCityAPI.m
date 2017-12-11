//
//  TPDObtainPerasonCenterConstantCityAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDObtainPerasonCenterConstantCityAPI.h"

@implementation TPDObtainPerasonCenterConstantCityAPI

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        
    }
    return self;
}


- (id)businessParameters {
    return @{
             };
    
}

- (NSString *)requestMethod {
    
    return @"truck-service/truck/businesslinecentrelist";
}

- (NSString *)destination {
    
    return @"truck.businesslinecentrelist";
}
@end
