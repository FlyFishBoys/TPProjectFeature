//
//  TPHomeUserParameterAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/8/17.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeUserParameterAPI.h"

@implementation TPDHomeUserParameterAPI
- (instancetype)initUserParameter {
    
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (NSString *)destination {
    
    return @"home.getTheUserParameter";
}

- (NSString *)requestMethod {
    return @"user-service/home/getTheUserParameter";
}

- (id)businessParameters {
    return nil;
}

- (BOOL)shouldShowLoadingHUD {
    
    return NO;
}
@end
