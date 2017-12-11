//
//  TPDObtainListenOrdertSetAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDObtainListenOrdertSetAPI.h"

@implementation TPDObtainListenOrdertSetAPI

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
    
    return @"order-service/listengoods/getsetting";
}

- (NSString *)destination {
    
    return @"listengoods.getsetting";
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
