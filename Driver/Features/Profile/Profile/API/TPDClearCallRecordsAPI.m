//
//  TPDClearCallRecordsAPI.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/24.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDClearCallRecordsAPI.h"

@implementation TPDClearCallRecordsAPI

- (NSString *)destination {
    
    return @"userorder.callempty";
}

- (NSString *)requestMethod {
    return @"user-service/userorder/callempty";
}

- (id)businessParameters {
    return @{};
}

@end