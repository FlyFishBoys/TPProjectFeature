//
//  TPDOrderDetailViewModel.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDOrderDetailViewModel.h"
#import "TPDOrderDetailModel.h"
#import "TPBottomButtonModel.h"
#import "TPDOrderDefines.h"
#import "TPDOrderDetailShipperInfoViewModel.h"
#import "TPSenderReceiverViewModel.h"
#import "TPOrerDetailFreightViewModel.h"
#import "TPOrerDetailExpandViewModel.h"
#import "TPDropdownMenuModel.h"

@implementation TPDOrderDetailViewModel
- (instancetype)initWithModel:(TPDOrderDetailModel *)model {
    if (self = [super init]) {
        _model = model;
        [self od_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDOrderDetailModel *)model {
    _model = model;
    [self od_bindingModelWithModel:model];
}

- (void)od_bindingModelWithModel:(TPDOrderDetailModel *)model {
    switch (model.order_status.integerValue) {
        case 2:
        case 3:
        {
            _progressHighlightedIndex = 0;
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"放弃承接" type:TPDOrderDetailButtonType_GiveUpTake];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"我要承接" type:TPDOrderDetailButtonType_ToTake];
            _buttonModels = @[buttonModel1,buttonModel2];
        }
            break;
            
        case 4:
        {
            _progressHighlightedIndex = 1;
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"地图导航" type:TPDOrderDetailButtonType_MapNavigation];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"确认提货" type:TPDOrderDetailButtonType_ConfirmPickUp];
            _buttonModels = @[buttonModel1,buttonModel2];
        }
            break;
            
        case 5:
        {
            _progressHighlightedIndex = 2;
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"地图导航" type:TPDOrderDetailButtonType_MapNavigation];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"确认提货" type:TPDOrderDetailButtonType_ConfirmPickUp];
            _buttonModels = @[buttonModel1,buttonModel2];
            
        }
            break;
            
        case 6:
        {
            _progressHighlightedIndex = 3;
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"地图导航" type:TPDOrderDetailButtonType_MapNavigation];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"确认签收" type:TPDOrderDetailButtonType_ConfirmSignUp];
            _buttonModels = @[buttonModel1,buttonModel2];
            
        }
            break;
            
        case 7:
        case 8:
        {
            _progressHighlightedIndex = 4;
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"评价赚积分" type:TPDOrderDetailButtonType_Evaluation];
            _buttonModels = @[buttonModel1];
        }
            break;
            
        case 9:
        case 10:
        {
            _progressHighlightedIndex = 4;
            TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"我要分享" type:TPDOrderDetailButtonType_Share];
            TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"查看回评" type:TPDOrderDetailButtonType_ViewEvaluation];
            _buttonModels = @[buttonModel1,buttonModel2];
        }
            break;
    }
    
    //提示文字
    [self od_setupTipsByRefundStatus];
    _tipsHeight = [_tips heightForFont:TPAdaptedFontSize(14) width:kScreenWidth - 2 * TPAdaptedWidth(12)]  + TPAdaptedHeight(22);
    
    [self ob_setupDeposit];
    
    _shipperViewModel = [[TPDOrderDetailShipperInfoViewModel alloc]initWithModel:model.owner_info];
    _senderViewModel = [[TPSenderReceiverViewModel alloc]initWithModel:model.sender_info];
    _receiverViewModel = [[TPSenderReceiverViewModel alloc]initWithModel:model.receiver_info];
    _freightViewModel = [[TPOrerDetailFreightViewModel alloc]initWithModel:model.freight];
    _expandViewModel = [[TPOrerDetailExpandViewModel alloc]initWithOrderNo:model.order_no updateTime:model.update_time remark:model.remark remark_img_key:model.remark_img_key remark_img_url:model.remark_img_url other_remark:model.other_remark];
    [self od_setupDropdownMenuModels];
    
}

//根据退款状态显示提示
- (void)od_setupTipsByRefundStatus {
    
    switch (_model.refund_info.refund_status.integerValue) {
        case 1://1.发起方申请退款
        {
            if ([_model.refund_info.is_oneself_refund isEqualToString:@"0"]) {
                _tips = @"您已申请退款，请等待对方确认！";
            } else {
                _tips =  [NSString stringWithFormat:@"货主发起了退款申请，退款金额：%.2f元，请及时处理！",_model.refund_info.refund_money.floatValue];
            }
        }
            break;
            
        case 4://4.接收方拒绝退款
        {
            if ([_model.refund_info.is_oneself_refund isEqualToString:@"0"]) {
                _tips = @"您申请的退款已被对方拒绝，请在退款详情中查看。";
            } else {
                [self od_setupTipsByOrderStatus];
            }
        }
            break;
            
        case 2://2.发起方取消退款
        case 5://5.退款失效
        {
            [self od_setupTipsByOrderStatus];
        }
            break;
            
        case 3://3.接收方同意退款
        {
            _tips =  [NSString stringWithFormat:@"退款成功，退款金额%.2f元。",_model.refund_info.refund_money.floatValue];
        }
            break;
            
        default:
        {
            [self od_setupTipsByOrderStatus];
        }
            break;
    }
    
}

//根据订单状态显示提示
- (void)od_setupTipsByOrderStatus {
    switch (_model.order_status.integerValue) {
        case 2:
        case 3:
        {
            _tips = @"货主已将订单指派给您，请尽快确认承接。";
        }
            break;
            
        case 4:
        {
            _tips =  @"货主正在托管运费，请确认运费托成功后再去提货。";
        }
            break;
            
        case 5:
        {
            _tips =  @"向货主或发货人索取提货码，完成提货。";
        }
            break;
            
        case 6:
        {
            _tips = @"签收时需要签收码，请现场向收货人索取，或拨打电话。";
        }
            break;
            
        case 7:
        case 8:
        {
            _tips =  @"交易已完成，评价货主可获积分！";
        }
            break;
            
        case 9:
        case 10:
        {
            _tips =  @"感谢您的评价，560竭诚为您服务。";
        }
            break;
        case 11:
        {
            _tips =  [NSString stringWithFormat:@"退款成功，退款金额%.2f元。",_model.refund_info.refund_money.floatValue];
        }
            break;
    }
}

//设置下拉菜单
- (void)od_setupDropdownMenuModels {
    
    //refund_status:1.发起方申请退款 2.发起方取消退款 3.接收方同意退款 4.接收方拒绝退款 5.退款失效
    if ([self.model.refund_info.refund_status isEqualToString:@"1"] ||
        [self.model.refund_info.refund_status isEqualToString:@"3"] ||
        [self.model.refund_info.refund_status isEqualToString:@"4"])
    {
        if (self.model.order_status.integerValue > 6) {//已签收
            TPDropdownMenuModel * dropdownMenuModel1 = [[TPDropdownMenuModel alloc]initWithTitle:@"查看合同" indexType:TPDOrderDetailDropdownMenuType_ViewContract iconName:nil];
            TPDropdownMenuModel * dropdownMenuModel2 = [[TPDropdownMenuModel alloc]initWithTitle:@"退款详情" indexType:TPDOrderDetailDropdownMenuType_RefundDetail iconName:nil];
            TPDropdownMenuModel * dropdownMenuModel3 = [[TPDropdownMenuModel alloc]initWithTitle:@"我要投诉" indexType:TPDOrderDetailDropdownMenuType_omplainByMyself iconName:nil];
            _dropdownMenuModels = @[dropdownMenuModel1,dropdownMenuModel2,dropdownMenuModel3];
        } else {
            TPDropdownMenuModel * dropdownMenuModel2 = [[TPDropdownMenuModel alloc]initWithTitle:@"退款详情" indexType:TPDOrderDetailDropdownMenuType_RefundDetail iconName:nil];
            TPDropdownMenuModel * dropdownMenuModel1 = [[TPDropdownMenuModel alloc]initWithTitle:@"查看合同" indexType:TPDOrderDetailDropdownMenuType_ViewContract iconName:nil];
            _dropdownMenuModels = @[dropdownMenuModel1,dropdownMenuModel2];
        }
    } else {
        switch (self.model.order_status.integerValue) {
            case 2:
            case 3:
            {
                TPDropdownMenuModel * dropdownMenuModel1 = [[TPDropdownMenuModel alloc]initWithTitle:@"分享货源" indexType:TPDOrderDetailDropdownMenuType_ShareGoods iconName:nil];
                _dropdownMenuModels = @[dropdownMenuModel1];
            }
                break;
                
            case 4:
            case 5:
            {
                if (self.model.freight.agency_fee.integerValue > 0) {
                    TPDropdownMenuModel * dropdownMenuModel2 = [[TPDropdownMenuModel alloc]initWithTitle:@"我要退款" indexType:TPDOrderDetailDropdownMenuType_RefundByMyself iconName:nil];
                    TPDropdownMenuModel * dropdownMenuModel1 = [[TPDropdownMenuModel alloc]initWithTitle:@"查看合同" indexType:TPDOrderDetailDropdownMenuType_ViewContract iconName:nil];
                    _dropdownMenuModels = @[dropdownMenuModel1,dropdownMenuModel2];
                } else {
                    TPDropdownMenuModel * dropdownMenuModel = [[TPDropdownMenuModel alloc]initWithTitle:@"查看合同" indexType:TPDOrderDetailNavRightButtonType_ViewContract iconName:nil];
                    _dropdownMenuModels = @[dropdownMenuModel];
                }
            }
                break;
            case 6:
            {
                TPDropdownMenuModel * dropdownMenuModel = [[TPDropdownMenuModel alloc]initWithTitle:@"查看合同" indexType:TPDOrderDetailNavRightButtonType_ViewContract iconName:nil];
                _dropdownMenuModels = @[dropdownMenuModel];
            }
                break;

            case 7:
            case 9:
            case 8:
            case 10:
            {
                TPDropdownMenuModel * dropdownMenuModel2 = [[TPDropdownMenuModel alloc]initWithTitle:@"我要投诉" indexType:TPDOrderDetailDropdownMenuType_omplainByMyself iconName:nil];
                TPDropdownMenuModel * dropdownMenuModel1 = [[TPDropdownMenuModel alloc]initWithTitle:@"查看合同" indexType:TPDOrderDetailDropdownMenuType_ViewContract iconName:nil];
                _dropdownMenuModels = @[dropdownMenuModel1,dropdownMenuModel2];
            }
                break;
                
        }
    }
}

- (void)ob_setupDeposit {
    _deposit = [NSString stringWithFormat:@"￥%@",@(_model.freight.agency_fee.integerValue)];
    _depositHeight = _model.freight.agency_fee.integerValue > 0 ? TPAdaptedHeight(52) : 0.0f;
    _depositPayStatus = _model.order_status.integerValue > 4 ? @"已到账" : @"提货后到账";
    _depositTitle = _model.order_status.integerValue > 4 ? @"已收定金" : @"待收定金";
}

@end
