//
//  TPDMyVehicleTeamViewModel.m
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyVehicleTeamViewModel.h"
#import "TPDMyVehicleTeamModel.h"

@implementation TPDMyVehicleTeamViewModel
- (instancetype)initWithModels:(NSArray<TPDMyVehicleTeamModel *> *)models target:(id)target{
    if (self = [super init]) {
        __block NSMutableArray * mutableArray = [[NSMutableArray alloc]init];
        [models enumerateObjectsUsingBlock:^(TPDMyVehicleTeamModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TPDMyVehicleTeamItemViewModel * viewModel = [[TPDMyVehicleTeamItemViewModel alloc]initWithModel:obj];
            viewModel.target = target;
            [mutableArray addObject:viewModel];
        }];
        _viewModels = [NSArray arrayWithArray:mutableArray];
    }
    return self;
}
@end

@implementation TPDMyVehicleTeamItemViewModel

- (instancetype)initWithModel:(TPDMyVehicleTeamModel *)model {
    if (self = [super init]) {
        _model = model;
        [self vt_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDMyVehicleTeamModel *)model {
    _model = model;
    [self vt_bindingModelWithModel:model];
}

- (void)vt_bindingModelWithModel:(TPDMyVehicleTeamModel *)model {
    _plate = model.plate_no1.isNotBlank ? model.plate_no1 : @"";
    _plate = model.plate_no2.isNotBlank ? [NSString stringWithFormat:@"%@%@",_plate,model.plate_no2] : _plate;
    _plate = model.plate_no3.isNotBlank ? [NSString stringWithFormat:@"%@%@",_plate,model.plate_no3] : _plate;
    _plateBackgroundImage = [model.plate_color isEqualToString:@"1"] ? [UIImage imageNamed:@"vehicle_team_plate_blue"] : [UIImage imageNamed:@"vehicle_team_plate_yellow"];
    _truckTypeLength = model.truck_type_name.isNotBlank ? [NSString stringWithFormat:@"%@ ", model.truck_type_name] : @"";
    _truckTypeLength = model.truck_length_name.isNotBlank ? [NSString stringWithFormat:@"%@%@", _truckTypeLength,model.truck_length_name] : _truckTypeLength;
    _isAudit = [model.audit_status isEqualToString:@"2"];
    _isSeekingGoods = [model.truck_status isEqualToString:@"1"];
    NSString * name = model.driver_name.isNotBlank ? [model.driver_name stringByAppendingString:@" "] : @"";
    NSString * mobile = model.driver_mobile.isNotBlank ? model.driver_mobile : @"";
    _remark = @"";
    if (name.isNotBlank && mobile.isNotBlank) {
        _remark = [NSString stringWithFormat:@"备注：%@%@",name,mobile];
    }
}


@end
