//
//  TPDModifyVehicleCerificationAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDModifyVehicleCerificationAPI.h"
#import "TPDVehicleCertificationModel.h"

@interface TPDModifyVehicleCerificationAPI ()
@property (nonatomic, strong) TPDVehicleCertificationModel * model;
@end

@implementation TPDModifyVehicleCerificationAPI
- (instancetype)initWithModel:(TPDVehicleCertificationModel *)model {
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"truck-service/truck/usercentresavetruck";
}

- (nullable NSString *)destination {
    return @"truck.usercentresavetruck";
}

- (nullable id)businessParameters {
    return @{
             @"plate_no1" : _model.plate_no1.isNotBlank ? _model.plate_no1 : @"",
             @"plate_no2" : _model.plate_no2.isNotBlank ? _model.plate_no2 : @"",
             @"plate_no3" : _model.plate_no3.isNotBlank ? _model.plate_no3 : @"",
             @"plate_color" : _model.plate_color.isNotBlank ? _model.plate_color : @"",
             @"truck_typeId" : _model.truck_typeId.isNotBlank ? _model.truck_typeId : @"",
             @"truck_lengthId" : _model.truck_lengthId.isNotBlank ? _model.truck_lengthId : @"",
             @"truck_head_img" : _model.truck_head_img.isNotBlank ? _model.truck_head_img : @"",
             @"driver_license_img" : _model.driver_license_img.isNotBlank ? _model.driver_license_img : @"",
             @"driver_truck_id" : _model.driver_truck_id.isNotBlank ? _model.driver_truck_id : @"",
             @"truck_head_img_key" : _model.truck_head_img_key.isNotBlank ? _model.truck_head_img_key : @"",
             @"driver_license_img_key" : _model.driver_license_img_key.isNotBlank ? _model.driver_license_img_key : @"",
             };
    
}
@end
