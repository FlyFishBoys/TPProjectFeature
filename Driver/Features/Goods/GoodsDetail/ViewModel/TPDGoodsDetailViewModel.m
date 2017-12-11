//
//  TPDGoodsDetailViewModel.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsDetailViewModel.h"
#import "TPDGoodsDetailModel.h"
#import "TPSenderReceiverViewModel.h"
#import "TPBottomButtonModel.h"
#import "TPDOrderDefines.h"
#import "NSString+TimesTamp.h"

@implementation TPDGoodsDetailViewModel
- (instancetype)initWithModel:(TPDGoodsDetailModel *)model {
    if (self = [super init]) {
        _model = model;
        [self gd_bindingModelWithModel:model];
    }
    return self;
}

- (void)setModel:(TPDGoodsDetailModel *)model {
    _model = model;
    [self gd_bindingModelWithModel:model];
}

- (void)gd_bindingModelWithModel:(TPDGoodsDetailModel *)model {
    if ([model.goods_status isEqualToString:@"6"]) {
        _tips = @"退款成功，订单已撤销。";
    } else {
        _tips = [NSString stringWithFormat:@"已推送%@人。",@(model.goods_push_num.integerValue)];
        NSString * tipsRightText = [NSString stringWithFormat:@"已有%@人报价",@(model.offer_sum.integerValue)];
        NSMutableAttributedString * tipsRightAttributed = [[NSMutableAttributedString alloc]initWithString:tipsRightText];
        [tipsRightAttributed addAttribute:NSFontAttributeName value:TPAdaptedFontSize(16) range:NSMakeRange(2, model.offer_sum.length)];
        [tipsRightAttributed addAttribute:NSForegroundColorAttributeName value:UIColorHex(ff5e5e) range:NSMakeRange(2, model.offer_sum.length)];
        _tipsRightAttributed = [tipsRightAttributed copy];
    }
    
    _orderSerial = model.goods_no.isNotBlank ? [NSString stringWithFormat:@"订单号：%@",model.goods_no] : @"";
    _orderTime = [model.update_time convertedToTimeWithDateFormat:@"YYYY-MM-dd HH:MM"];
    
    _distanceHeight = TPAdaptedHeight(76);
    _shipperInfoHeight = TPAdaptedHeight(80);
    if ([model.is_offer isEqualToString:@"1"]) {//已报价
        _distanceHeight = 0.0f;
        _shipperInfoHeight = 0.0f;
    }
    
    _quotesHeight = 0.0f;
    _quotesAmountAttributed = [[NSAttributedString alloc]initWithString:@""];
    if ([model.is_offer isEqualToString:@"1"] && model.transport_fee.integerValue > 0) {
        _quotesHeight = TPAdaptedHeight(48);
        NSString * deposit_fee = [NSString stringWithFormat:@"%@",@(model.deposit_fee.integerValue)];
        NSString * transport_fee = [NSString stringWithFormat:@"%@",@(model.transport_fee.integerValue)];
        NSString * quotesAmountText = [NSString stringWithFormat:@"已报价:￥%@",transport_fee];
        quotesAmountText = deposit_fee.integerValue > 0 ? [NSString stringWithFormat:@"%@    待付定金:￥%@",quotesAmountText,deposit_fee] : quotesAmountText;
        NSMutableAttributedString * quotesAmountAttributed = [[NSMutableAttributedString alloc]initWithString:quotesAmountText];
        [quotesAmountAttributed addAttribute:NSFontAttributeName value:TPAdaptedFontSize(21) range:NSMakeRange(5, transport_fee.length)];
        [quotesAmountAttributed addAttribute:NSForegroundColorAttributeName value:UIColorHex(F5A623) range:NSMakeRange(4, transport_fee.length + 1)];
        if (model.deposit_fee.integerValue > 0) {
            [quotesAmountAttributed addAttribute:NSFontAttributeName value:TPAdaptedFontSize(21) range:NSMakeRange(quotesAmountText.length - deposit_fee.length, deposit_fee.length)];
            [quotesAmountAttributed addAttribute:NSForegroundColorAttributeName value:UIColorHex(ff5e5e) range:NSMakeRange(quotesAmountText.length - deposit_fee.length - 1, deposit_fee.length + 1)];
        }
        _quotesAmountAttributed = [quotesAmountAttributed copy];
    }

    _remarkText = @"";
    _remarkHeight = 0.0f;
    _remarkImageHeight = 0.0f;
    if (model.other_remark.isNotBlank) {
        _remarkText = model.other_remark;
        _remarkHeight = [model.other_remark heightForFont:TPAdaptedFontSize(15) width:kScreenWidth - 2 * TPAdaptedWidth(12)] + TPAdaptedHeight(50);
    }
    if (model.remark_img_url.isNotBlank) {
        _remarkHeight = _remarkHeight > 0 ? _remarkHeight + TPAdaptedWidth(80) + TPAdaptedHeight(10) : TPAdaptedWidth(80) + TPAdaptedHeight(50);
        _remarkImageHeight = TPAdaptedWidth(80);
    }
    
    _goodsInfo = @"";
    _goodsInfoHeight = 0.0f;
    if (model.remark.isNotBlank) {
        _goodsInfo = model.remark;
        _goodsInfoHeight = [model.remark heightForFont:TPAdaptedFontSize(15) width:kScreenWidth - 2 * TPAdaptedWidth(12)] + TPAdaptedHeight(50);
    }
    if ([model.is_offer isEqualToString:@"1"]) {
        TPBottomButtonModel * buttonModel1 = [[TPBottomButtonModel alloc]initWithTitle:@"撤销报价" type:TPDGoodsDetailButtonType_RevokedQuotes];
        TPBottomButtonModel * buttonModel2 = [[TPBottomButtonModel alloc]initWithTitle:@"修改报价" type:TPDGoodsDetailButtonType_ModifyQuotes];
        _buttonModels = @[buttonModel1,buttonModel2];
        
    } else {
        TPBottomButtonModel * buttonModel = [[TPBottomButtonModel alloc]initWithTitle:@"我要接单" type:TPDGoodsDetailButtonType_TakeOrder];
        _buttonModels = @[buttonModel];
        
    }
    
    
    _senderViewModel = [[TPSenderReceiverViewModel alloc]initWithModel:model.sender_info];
    _receiverViewModel = [[TPSenderReceiverViewModel alloc]initWithModel:model.receiver_info];
}
@end
