//
//  TPDMyOrderListViewModel.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyOrderListViewModel.h"
#import "TPDMyOrderListModel.h"
#import "NSString+Regular.h"
#import "TPDOrderDefines.h"
#import "NSString+TimesTamp.h"
#import "TPBottomButtonModel.h"

@implementation TPDMyOrderListViewModel

- (instancetype)initWithModels:(NSArray<TPDMyOrderListModel *> *)models target:(id)target {
    if (self = [super init]) {
        __block NSMutableArray * mutableArray = [[NSMutableArray alloc]init];
        [models enumerateObjectsUsingBlock:^(TPDMyOrderListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TPDMyOrderListItemViewModel * viewModel = [[TPDMyOrderListItemViewModel alloc]initWithModel:obj];
            viewModel.target = target;
            [mutableArray addObject:viewModel];
        }];
        _viewModels = [NSArray arrayWithArray:mutableArray];
    }
    return self;
}

@end


@implementation TPDMyOrderListItemViewModel

- (instancetype)initWithModel:(TPDMyOrderListModel *)model {
    if (self = [super init]) {
        _model = model;
        [self mo_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDMyOrderListModel *)model {
    _model = model;
    [self mo_bindingModelWithModel:model];
}


- (void)mo_bindingModelWithModel:(TPDMyOrderListModel *)model {
    _departCity = model.sender_info.city.isNotBlank ? model.sender_info.city : @"";
    _destinationCity = model.receiver_info.city.isNotBlank ? model.receiver_info.city : @"";
    _name = model.owner_name.isNotBlank ? model.owner_name : @"";
    _starScore = model.owner_comment_level.doubleValue;
    _pickupTime = [self mo_getPickUpTimeWithLoadDateName:model.pickup_start_time];
    _updateTime = [model.order_update_time convertedToUpdatetime];
    _fee = [self mo_getFeeText];
    _status = [self mo_getStatusWithOrderStatus:model.order_status];
    _statusImage = [self mo_getStatusImageWithOrderStatus:model.order_status];
    [self mo_configButtonTitlesAndButtonTypes];
}

/**
 提货时间
 */
- (NSString *)mo_getPickUpTimeWithLoadDateName:(NSString *)loadDateName {
    if ([NSString checkPureNumber:loadDateName]) {
        return [loadDateName convertedToTimeWithDateFormat:@"YYYY-MM-dd HH点 提货"];
    } else {
        return loadDateName;
    }
}

/**
 费用信息
 */
- (NSString *)mo_getFeeText {
    NSString * fee = @"";
    //运费
    NSString * isFreightManaged = [_model.is_freight_fee_managed isEqualToString:@"1"] ? @"  托管" : @"";
    if (_model.freight_fee.isNotBlank && _model.freight_fee.integerValue > 0) {
        fee = [NSString stringWithFormat:@"运费￥%@%@",_model.freight_fee,isFreightManaged];
    }
    
    //定金
    if (_model.agency_fee.isNotBlank && _model.agency_fee.integerValue > 0) {
        fee = [NSString stringWithFormat:@"%@ | 定金%@",fee,_model.agency_fee];
    }
    
    return fee;
}

/**
 状态图片
 */
- (UIImage *)mo_getStatusImageWithOrderStatus:(NSString *)orderStatus {
    if (orderStatus.integerValue > 6) {//已承运是灰色
        return [UIImage imageNamed:@"order_list_statusbackground_gray"];
    } if (orderStatus.integerValue > 2) {//已承接后是蓝色
        return [UIImage imageNamed:@"order_list_statusbackground_blue"];
    } else {//待承接是红色
        return [UIImage imageNamed:@"order_list_statusbackground_red"];
    }
}

/**
 状态文字
 */
- (NSString *)mo_getStatusWithOrderStatus:(NSString *)orderStatus {
    NSString * status = @"";
    if (orderStatus.integerValue == 2) {
        switch ([orderStatus integerValue]) {
            case 2:
                return @"待承接";
                break;
            case 3:
                return @"支付中";
                break;
            case 4:
            case 5:
                return @"提货中";
                break;
            case 6:
                return @"配送中";
                break;
            case 7:
            case 8:
                return @"待评价";
                break;
            case 9:
            case 10:
                return @"已评价";
                break;
        }
    } else {
        switch ([_model.goods_status integerValue]) {
            case 1:
                return @"报价中";
                break;
            case 3:
            case 6:
                return @"已撤销";
                break;
            case 4:
                return @"待指派";
                break;
            case 5:
                return @"已过期";
                break;
        }
    }
    return status;
}

/**
 设置按钮的标题和Type
 */
- (void)mo_configButtonTitlesAndButtonTypes {
    switch ([_model.order_status integerValue]) {
        case 2://货主确认成交:待承接
        {
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"  我要承接  " type:TPDMyOrderListCellButtonType_ToTake];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"  放弃承接  " type:TPDMyOrderListCellButtonType_GiveUpTake];
            TPBottomButtonModel * buttonModel3 = [[TPBottomButtonModel alloc]initWithTitle:@"  呼叫货主  " type:TPDMyOrderListCellButtonType_CallShipper];
            _buttonModels = @[buttonModel1,buttonModel2,buttonModel3];
        }
            break;
            
        case 3://待支付运费:支付中
        {
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"  确认签收  " type:TPDMyOrderListCellButtonType_ConfirmSignUp];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"  地图导航  " type:TPDMyOrderListCellButtonType_MapNavigation];
            TPBottomButtonModel * buttonModel3 = [[TPBottomButtonModel alloc]initWithTitle:@"  呼叫货主  " type:TPDMyOrderListCellButtonType_CallShipper];
            _buttonModels = @[buttonModel1,buttonModel2,buttonModel3];
        }
            break;
        case 4:
        case 5://提货中
        {
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"  确认提货  " type:TPDMyOrderListCellButtonType_ConfirmPickUp];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"  地图导航  " type:TPDMyOrderListCellButtonType_MapNavigation];
            TPBottomButtonModel * buttonModel3 = [[TPBottomButtonModel alloc]initWithTitle:@"  呼叫货主  " type:TPDMyOrderListCellButtonType_CallShipper];
            _buttonModels = @[buttonModel1,buttonModel2,buttonModel3];
        }
            break;
            
        case 6://承运中:配送中
        {
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"  确认签收  " type:TPDMyOrderListCellButtonType_ConfirmSignUp];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"  地图导航  " type:TPDMyOrderListCellButtonType_MapNavigation];
            TPBottomButtonModel * buttonModel3 = [[TPBottomButtonModel alloc]initWithTitle:@"  呼叫货主  " type:TPDMyOrderListCellButtonType_CallShipper];
            _buttonModels = @[buttonModel1,buttonModel2,buttonModel3];
        }
            break;
            
        case 7://已承运
        case 8://待评价
        {
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"  评价赚积分  " type:TPDMyOrderListCellButtonType_Evaluation];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"  呼叫货主  " type:TPDMyOrderListCellButtonType_CallShipper];
            _buttonModels = @[buttonModel1,buttonModel2];
        }
            break;
            
        case 9:
        case 10://已评价
        {
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"  好友分享  " type:TPDMyOrderListCellButtonType_FriendsShare];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"  查看回评  " type:TPDMyOrderListCellButtonType_ViewEvaluation];
            _buttonModels = @[buttonModel1,buttonModel2];
        }
            break;
    }
}

@end
