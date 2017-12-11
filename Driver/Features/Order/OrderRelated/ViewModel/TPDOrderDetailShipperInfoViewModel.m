//
//  TPDOrderDetailShipperInfoViewModel.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDOrderDetailShipperInfoViewModel.h"
#import "TPDOrderDetailShipperInfoModel.h"

@implementation TPDOrderDetailShipperInfoViewModel
- (instancetype)initWithModel:(TPDOrderDetailShipperInfoModel *)model {
    if (self = [super init]) {
        _model = model;
        [self od_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDOrderDetailShipperInfoModel *)model {
    _model = model;
    [self od_bindingModelWithModel:model];
}

- (void)od_bindingModelWithModel:(TPDOrderDetailShipperInfoModel *)model {
    _name = model.owner_name.isNotBlank ? model.owner_name : @"";
    _dealRecord = [NSString stringWithFormat:@"共成交%@笔订单",@(model.owner_make_a_bargain_sum.integerValue)];
    _starScore = model.owner_comment_level.floatValue;

    _mobile = model.owner_mobile.isNotBlank ? model.owner_mobile : @"";
}
@end
