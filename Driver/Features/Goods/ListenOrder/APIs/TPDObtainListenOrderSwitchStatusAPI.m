//
//  TPDObtainListenOrderSwitchStatusAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDObtainListenOrderSwitchStatusAPI.h"

@implementation TPDObtainListenOrderSwitchStatusAPI
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
    
    return @"/order-service/listengoods/getstatus";
}

- (NSString *)destination {
    
    return @"listengoods.getstatus";
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
