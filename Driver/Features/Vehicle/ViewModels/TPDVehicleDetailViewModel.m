//
//  TPDVehicleDetailViewModel.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleDetailViewModel.h"
#import "TPDVehicleDetailModel.h"

@implementation TPDVehicleDetailViewModel
- (instancetype)initWithModel:(TPDVehicleDetailModel *)model {
    if (self = [super init]) {
        _model = model;
        [self vd_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDVehicleDetailModel *)model {
    _model = model;
    [self vd_bindingModelWithModel:model];
}

- (void)vd_bindingModelWithModel:(TPDVehicleDetailModel *)model {
    _plate = model.plate_no1.isNotBlank ? model.plate_no1 : @"";
    _plate = model.plate_no2.isNotBlank ? [NSString stringWithFormat:@"%@%@",_plate,model.plate_no2] : _plate;
    _plate = model.plate_no3.isNotBlank ? [NSString stringWithFormat:@"%@%@",_plate,model.plate_no3] : _plate;
    _plateColor = [model.plate_color isEqualToString:@"1"] ? @"蓝牌" : @"黄牌";
    _truckTypeLength = model.truck_type_name.isNotBlank ? [NSString stringWithFormat:@"%@ ", model.truck_type_name] : @"";
    _truckTypeLength = model.truck_length_name.isNotBlank ? [NSString stringWithFormat:@"%@%@", _truckTypeLength,model.truck_length_name] : _truckTypeLength;
    
    _name = model.driver_name.isNotBlank ? model.driver_name : @"";
    _nameHeight = model.driver_name.isNotBlank ? TPAdaptedHeight(48) : 0;

    _mobile = model.driver_mobile.isNotBlank ? model.driver_mobile : @"";
    _mobileHeight = model.driver_mobile.isNotBlank ? TPAdaptedHeight(48) : 0;

    if (_name.isNotBlank || _mobile.isNotBlank) {
        _remarkHeight = TPAdaptedHeight(36);
    } else {
        _remarkHeight = TPAdaptedHeight(0);
    }
    if ([model.audit_status isEqualToString:@"0"]) {
        _tipsViewHeight = TPAdaptedHeight(40);
        _bottomButtonHeight = 0;
    } else {
        _tipsViewHeight = 0;
        _bottomButtonHeight = TPAdaptedHeight(44);
    }
}

@end
