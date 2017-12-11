//
//  TPDModifyVehicleAPI.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDModifyVehicleAPI.h"
#import "TPDAddModifyVehicleModel.h"

@interface TPDModifyVehicleAPI ()
@property(nonatomic,strong) TPDAddModifyVehicleModel * model;

@end

@implementation TPDModifyVehicleAPI
- (instancetype)initWithModel:(TPDAddModifyVehicleModel *)model {
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truckteam/updatetruck";
}

- (nullable NSString *)destination {
    return @"truckteam.updatetruck";
}

- (id)businessParameters {
    return [self.model yy_modelToJSONObject];
}

@end
