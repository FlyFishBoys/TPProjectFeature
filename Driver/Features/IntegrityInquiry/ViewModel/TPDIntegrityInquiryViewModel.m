//
//  TPDIntegrityInquiryViewModel.m
//  Driver
//
//  Created by Mr.mao on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryViewModel.h"
#import "TPDIntegrityInquiryModel.h"

@implementation TPDIntegrityInquiryViewModel

- (instancetype)initWithModel:(TPDIntegrityInquiryModel *)model {
    if (self = [super init]) {
        _model = model;
        [self ii_bindWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDIntegrityInquiryModel *)model {
    _model = model;
    [self ii_bindWithModel:model];
}

- (void)ii_bindWithModel:(TPDIntegrityInquiryModel *)model {
    _name = model.user_name.isNotBlank ? model.user_name : @"";
    _userType = [model.user_type isEqualToString:@"1"] ? @"司机" : [model.user_type isEqualToString:@"2"] ? @"货主" : @"";
    _isVerified = [model.use_status isEqualToString:@"1"];
    _isAuthentication = [model.user_auth_status isEqualToString:@"1"];
    _isVehicleCertification = [model.truck_status isEqualToString:@"1"];
    _score = model.degree_of_praise.floatValue;
    _starRating = [NSString stringWithFormat:@"%.1f分",model.evaluation_score.floatValue];
    _integrityLevel = model.integrity_value_level.isNotBlank ? model.integrity_value_level : @"";
    _integrityValue = [NSString stringWithFormat:@"%.1f",model.integrity_value.floatValue];
    _receivingNum = [NSString stringWithFormat:@"%@",@(model.shipments_or_receiving_num.integerValue)];
    _clinchDealNum = [NSString stringWithFormat:@"%@",@(model.clinch_a_deal_num.integerValue)];
    _isHiddenVehicleCertification = ![model.user_type isEqualToString:@"1"];
}
@end
