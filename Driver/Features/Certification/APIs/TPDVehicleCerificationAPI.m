//
//  TPDVehicleCerificationAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleCerificationAPI.h"

@implementation TPDVehicleCerificationAPI

- (NSString *)requestMethod {
    return @"truck-service/truck/getusercentresavetruck";
}

- (nullable NSString *)destination {
    return @"truck.getusercentresavetruck";
}

@end
