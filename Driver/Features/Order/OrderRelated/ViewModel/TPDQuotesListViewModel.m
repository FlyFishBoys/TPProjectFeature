//
//  TPDQuotesListViewModel.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDQuotesListViewModel.h"
#import "TPDQuotesListModel.h"
#import "NSString+TimesTamp.h"

@implementation TPDQuotesListViewModel

- (instancetype)initWithModels:(NSArray<TPDQuotesListModel *> *)models target:(id)target {
    if (self = [super init]) {
        __block NSMutableArray * mutableArray = [[NSMutableArray alloc]init];
        [models enumerateObjectsUsingBlock:^(TPDQuotesListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TPDQuotesListItemViewModel * viewModel = [[TPDQuotesListItemViewModel alloc]initWithModel:obj];
            viewModel.target = target;
            [mutableArray addObject:viewModel];
        }];
        _viewModels = [NSArray arrayWithArray:mutableArray];
    }
    return self;
}

@end


@implementation TPDQuotesListItemViewModel

- (instancetype)initWithModel:(TPDQuotesListModel *)model {
    if (self = [super init]) {
        _model = model;
        [self ql_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDQuotesListModel *)model {
    _model = model;
    [self ql_bindingModelWithModel:model];
}


- (void)ql_bindingModelWithModel:(TPDQuotesListModel *)model{
    _truckInfo = model.truck_length_type.isNotBlank ? [NSString stringWithFormat:@"求%@",model.truck_length_type] : @"";
    _departCity = model.depart_city.isNotBlank ? model.depart_city : @"";
    _destinationCity = model.destination_city.isNotBlank ? model.destination_city : @"";
    _truckInfo = model.goods_size.isNotBlank ? [NSString stringWithFormat:@"货物数量%@ %@",model.goods_size,_truckInfo] : _truckInfo;
    _address = model.distance.doubleValue > 0 ? [NSString stringWithFormat:@"距提货地%@公里",model.distance] : @"";
    _address = model.the_total_distance.doubleValue > 0 ? [NSString stringWithFormat:@"%@  全程%@公里",_address,model.the_total_distance] : _address;
    _updateTime = [model.update_time convertedToUpdatetime];
    _quotes = [NSString stringWithFormat:@"%@",@(model.transport_fee.integerValue)];
    _deposit = model.deposit_fee.integerValue > 0 ? [NSString stringWithFormat:@"%@",@(model.deposit_fee.integerValue)] : @"";
    _isHideDepositTag = !(model.deposit_fee.integerValue > 0);
}


@end
