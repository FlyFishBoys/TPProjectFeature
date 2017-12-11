//
//  TPDHomeFunctionItemAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeFunctionItemAPI.h"
#define HomeFunctionVersion @"3000001"
@implementation TPDHomeFunctionItemAPI {
    
    NSString *_version;
}
- (instancetype)initWithVersion:(NSString *)version {
    
    self = [super init];
    if (self) {
        _version = [[NSUserDefaults standardUserDefaults]objectForKey:@"HomeFunctionVersion"];
        if (![_version isNotBlank]) {
            _version = HomeFunctionVersion;
        }
    }
    return self;
}

- (id)businessParameters {
    
    return @{
             @"version":_version ?: @""
             };
    
}

- (NSString *)requestMethod {
    
    return @"resource-service/resourcehome/themiddleofoptions";
}

- (NSString *)destination {
    
    return @"resourcehome.themiddleofoptions";
}

- (BOOL)shouldShowLoadingHUD {
    
    return NO;
    
}
@end
