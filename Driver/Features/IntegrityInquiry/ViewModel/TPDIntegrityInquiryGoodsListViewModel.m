//
//  TPDIntegrityInquiryGoodsListViewModel.m
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryGoodsListViewModel.h"
#import "TPDIntegrityInquiryGoodsModel.h"
#import "TPBottomButtonModel.h"
#import "NSString+TimesTamp.h"
#import "TPDIntegrityInquiryDefines.h"

@implementation TPDIntegrityInquiryGoodsListViewModel
- (instancetype)initWithModels:(NSArray<TPDIntegrityInquiryGoodsModel *> *)models target:(id)target {
    if (self = [super init]) {
        __block NSMutableArray * mutableArray = [[NSMutableArray alloc]init];
        [models enumerateObjectsUsingBlock:^(TPDIntegrityInquiryGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TPDIntegrityInquiryGoodsListItem * viewModel = [[TPDIntegrityInquiryGoodsListItem alloc]initWithModel:obj];
            viewModel.target = target;
            [mutableArray addObject:viewModel];
        }];
        _viewModels = [NSArray arrayWithArray:mutableArray];
    }
    return self;
}

@end

@implementation TPDIntegrityInquiryGoodsListItem

- (instancetype)initWithModel:(TPDIntegrityInquiryGoodsModel *)model {
    if (self = [super init]) {
        _model = model;
        [self mo_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDIntegrityInquiryGoodsModel *)model {
    _model = model;
    [self mo_bindingModelWithModel:model];
}


- (void)mo_bindingModelWithModel:(TPDIntegrityInquiryGoodsModel *)model {
    _departCity = model.depart_city.isNotBlank ? model.depart_city : @"";
    _destinationCity = model.destination_city.isNotBlank ? model.destination_city : @"";
    _time = [model.create_time convertedToUpdatetime];
    _goodsInfo = model.goods_size.isNotBlank ? model.goods_size : @"";
    _goodsInfo = model.truck_length_type.isNotBlank ? [NSString stringWithFormat:@"%@  %@",_goodsInfo,model.truck_length_type] : _goodsInfo;
    if (model.pre_goods_id.integerValue > 0) {
        TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"修改报价" type:TPDIntegrityInquiryGoodsCellButtonType_ModifyQuotes];
        TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"撤销报价" type:TPDIntegrityInquiryGoodsCellButtonType_RevokedQuotes];
        _buttonModels = @[buttonModel1,buttonModel2];
    } else {
        TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"接单" type:TPDIntegrityInquiryGoodsCellButtonType_TakeOrder];
        _buttonModels = @[buttonModel1,];
    }
}

@end

