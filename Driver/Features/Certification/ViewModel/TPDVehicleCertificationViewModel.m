//
//  TPDVehicleCertificationViewModel.m
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleCertificationViewModel.h"
#import "TPDVehicleCertificationModel.h"

@implementation TPDVehicleCertificationViewModel

- (instancetype)initWithModel:(TPDVehicleCertificationModel *)model {
    if (self = [super init]) {
        _model = model;
        [self od_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDVehicleCertificationModel *)model {
    _model = model;
    [self od_bindingModelWithModel:model];
}

- (void)od_bindingModelWithModel:(TPDVehicleCertificationModel *)model {
    if (model.plate_no1.isNotBlank) {
        _plateCity = model.plate_no1;
    } else if ([model.audit_status isEqualToString:@"1"]) {
        _plateCity = @"沪";
    }
    _plateNo = model.plate_no2.isNotBlank ? model.plate_no2 : @"";
    _plateNo = model.plate_no3.isNotBlank ? [NSString stringWithFormat:@"%@%@",_plateNo,model.plate_no3] : _plateNo;
    _plate = [_plateCity stringByAppendingString:_plateNo];
    _plateColor = [model.plate_color isEqualToString:@"1"] ? @"蓝牌" : @"黄牌";
    _truckTypeLength = model.truck_type.isNotBlank ? [NSString stringWithFormat:@"%@ ", model.truck_type] : @"";
    _truckTypeLength = model.truck_length.isNotBlank ? [NSString stringWithFormat:@"%@%@", _truckTypeLength,model.truck_length] : _truckTypeLength;
    if ([model.audit_status isEqualToString:@"2"] || [model.audit_status isEqualToString:@"3"]) {
        _isEnble = NO;
    } else {
        _isEnble = YES;
    }
}
@end
