//
//  TPDMyVehicleTeamAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyVehicleTeamAPI.h"

@interface TPDMyVehicleTeamAPI ()
{
    NSInteger _page;
}

@end

@implementation TPDMyVehicleTeamAPI
- (instancetype)initWithPage:(NSInteger)page {
    if (self = [super init]) {
        _page = page;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truckteam/list";
}

- (nullable NSString *)destination {
    return @"truckteam.list";
}

- (id)businessParameters {
    return @{
             @"page":@(_page),
             };
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}

@end
