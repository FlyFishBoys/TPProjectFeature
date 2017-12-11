//
//  TPDAddVehicleAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddVehicleAPI.h"
#import "TPDAddModifyVehicleModel.h"

@interface TPDAddVehicleAPI ()
@property(nonatomic,strong) TPDAddModifyVehicleModel * model;

@end

@implementation TPDAddVehicleAPI
- (instancetype)initWithModel:(TPDAddModifyVehicleModel *)model {
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truckteam/addtruck";
}

- (nullable NSString *)destination {
    return @"truckteam.addtruck";
}

- (id)businessParameters {
    return [self.model yy_modelToJSONObject];
}

@end
