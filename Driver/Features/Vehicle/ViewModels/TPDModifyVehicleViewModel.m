//
//  TPDModifyVehicleViewModel.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDModifyVehicleViewModel.h"
#import "TPDAddModifyVehicleModel.h"

@implementation TPDModifyVehicleViewModel
- (instancetype)initWithModel:(TPDAddModifyVehicleModel *)model {
    if (self = [super init]) {
        _model = model;
        [self vd_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDAddModifyVehicleModel *)model {
    _model = model;
    [self vd_bindingModelWithModel:model];
}

- (void)vd_bindingModelWithModel:(TPDAddModifyVehicleModel *)model {
    _plateCity = model.plate_no1.isNotBlank ? model.plate_no1 : @"";
    _plateNo = model.plate_no2.isNotBlank ? model.plate_no2 : @"";
    _plateNo = model.plate_no3.isNotBlank ? [NSString stringWithFormat:@"%@%@",_plateNo,model.plate_no3] : _plateNo;
    _plateColor = model.plate_color;
    _truckTypeLength = model.truck_type_name.isNotBlank ? [NSString stringWithFormat:@"%@ ", model.truck_type_name] : @"";
    _truckTypeLength = model.truck_length_name.isNotBlank ? [NSString stringWithFormat:@"%@%@", _truckTypeLength,model.truck_length_name] : _truckTypeLength;
    _name = model.driver_name.isNotBlank ? model.driver_name : @"";
    _mobile = model.driver_mobile.isNotBlank ? model.driver_mobile : @"";
}
@end
