//
//  TPDGoodsCell.m
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsCell.h"
#import "TPStartView.h"
#import "TPCallCenter.h"
#import "TPDGoodsViewModel.h"
#import "TPDGoodsConst.h"

static NSString * const AddressIconImage = @"order_list_arrow";
static NSString * const CallBtnImage_Highlight = @"smart_find_goods_call_highlight";
static NSString * const CallBtnImage_nor = @"smart_find_goods_call_nor";
static NSString * const ReceiveBtn_Nor_Image = @"smart_find_goods_jie_icon_nor";
static NSString * const ReceiveBtn_Hight_Image = @"smart_find_goods_jie_icon_highlight";
@interface TPDGoodsCell()


@property (nonatomic , strong) UILabel *depart;

@property (nonatomic , strong) UILabel *destination;

@property (nonatomic , strong) UIImageView *addressIcon;

@property (nonatomic , strong) UILabel *detail;

@property (nonatomic , strong) UIImageView *headerIcon;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) TPStartView *starView;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) UIButton *receiveBtn;

@property (nonatomic , strong) UIButton *callBtn;

//优质货主图标
@property (nonatomic , strong) UIButton *highQualityShipperActivityIcon;

//好货节图标
@property (nonatomic , strong) UIImageView *highQualityGoodActivityIcon;

@end

@implementation TPDGoodsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubviews];
        [self setFrame];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
- (void)addSubviews {
    
    
    [self addSubview:self.depart];
    [self addSubview:self.addressIcon];
    [self addSubview:self.destination];
    [self addSubview:self.detail];
    [self addSubview:self.headerIcon];
    [self addSubview:self.nameLabel];
    [self addSubview:self.starView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.receiveBtn];
    [self addSubview:self.callBtn];
    [self addSubview:self.highQualityGoodActivityIcon];
    // [self addSubview:self.highQualityShipperActivityIcon];
    
}
- (void)setFrame {
    
    [_depart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(10));
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
    }];
    
    [_addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_depart.mas_right).offset(TPAdaptedWidth(6));
        make.centerY.equalTo(_depart);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(11));
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(50));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedHeight(10));
    }];
    
    [_destination mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressIcon.mas_right).offset(TPAdaptedWidth(6));
        make.top.equalTo(_depart.mas_top);
        make.right.lessThanOrEqualTo(_timeLabel.mas_left).offset(TPAdaptedWidth(5));
    }];
    
    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.top.equalTo(self.mas_top).offset(TPAdaptedHeight(33));
        make.width.mas_lessThanOrEqualTo(TPScreenWidth - TPAdaptedWidth(24));
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(200));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedHeight(10));
        
    }];
    
    [_headerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_detail.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-8));
        make.width.mas_equalTo(TPAdaptedWidth(35));
        make.height.mas_equalTo(TPAdaptedWidth(35));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(55));
        make.top.equalTo(_headerIcon.mas_top);
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedWidth(10));
    }];
    
    UIImage *yellow = [UIImage imageNamed:@"star_view_yellow_all"];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-8));
        make.left.equalTo(self).offset(TPAdaptedWidth(55));
        make.height.mas_equalTo(TPAdaptedHeight(8));
        make.width.mas_equalTo(yellow.size.width);
        
    }];
    
    [_callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-9));
        make.width.mas_equalTo(TPAdaptedHeight(40));
        make.height.mas_equalTo(TPAdaptedHeight(40));
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
    }];
    
    [_receiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_callBtn);
        make.height.equalTo(_callBtn);
        make.bottom.equalTo(_callBtn.mas_bottom);
        make.right.equalTo(_callBtn.mas_left).offset(TPAdaptedWidth(-16));
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
    }];
    
    //    [_highQualityShipperActivityIcon mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(_nameLabel.mas_right).offset(TPAdaptedWidth(8));
    //        make.top.equalTo(_detail.mas_bottom).offset(TPAdaptedHeight(8));
    //        make.width.mas_equalTo(TPAdaptedWidth(55));
    //        make.height.mas_equalTo(TPAdaptedHeight(16));
    //    }];
    //
    [_highQualityGoodActivityIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right).offset(TPAdaptedWidth(8));
        make.top.equalTo(_detail.mas_bottom).offset(TPAdaptedHeight(8));
        make.width.mas_equalTo(TPAdaptedWidth(55));
        make.height.mas_equalTo(TPAdaptedHeight(16));
    }];
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    
    return TPAdaptedHeight(GoodsListCellHeight);
}
#pragma mark - Event Response
- (void)tapCallBtn:(UIButton *)tapCallBtn {
    
    if ([self.delegate respondsToSelector:@selector(didSelectGoodsCellBtn:itemViewModel:)]) {
        [self.delegate didSelectGoodsCellBtn:TPDGoodsCell_CallUp itemViewModel:(TPDGoodsItemViewModel *)self.object];
    }
}
- (void)tapReceiveBtn:(UIButton *)tapReceiveBtn {
    
    if ([self.delegate respondsToSelector:@selector(didSelectGoodsCellBtn:itemViewModel:)]) {
         [self.delegate didSelectGoodsCellBtn:TPDGoodsCell_ReceiveOrder itemViewModel:(TPDGoodsItemViewModel *)self.object];
    }
    
}
#pragma mark - Getters and Setters
- (UILabel *)depart {
    if (!_depart) {
        _depart = [[UILabel alloc]init];
        _depart.textColor = TPTitleTextColor;
        _depart.font = TPAdaptedBoldFontSize(GoodsAddressFontSize);
        _depart.preservesSuperviewLayoutMargins = YES;
       
    }
    return _depart;
}
- (UILabel *)destination {
    if (!_destination) {
        _destination = [[UILabel alloc]init];
        _destination.textColor = TPTitleTextColor;
        _destination.font = TPAdaptedBoldFontSize(GoodsAddressFontSize);
        _destination.preservesSuperviewLayoutMargins = YES;
    }
    return _destination;
}
- (UIImageView *)addressIcon {
    
    if (!_addressIcon) {
        _addressIcon = [[UIImageView alloc]init];
        _addressIcon.image = [UIImage imageNamed:@"order_list_arrow"];
    }
    return _addressIcon;
    
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = TPMainTextColor;
        _timeLabel.font =TPAdaptedFontSize(GoodsTimeFontSize);
        _timeLabel.preservesSuperviewLayoutMargins = YES;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)detail {
    if (!_detail) {
        _detail = [[UILabel alloc]init];
        _detail.font = TPAdaptedFontSize(GoodsGoodsInfoFontSize);
        _detail.textColor = TPMainTextColor;
        _detail.preservesSuperviewLayoutMargins = YES;
        _detail.preservesSuperviewLayoutMargins = YES;
    }
    
    return _detail;
}
- (UIImageView *)headerIcon {
    if (!_headerIcon) {
        _headerIcon = [[UIImageView alloc] init];
        _headerIcon.backgroundColor = TPUNEnbleColor_LineColor;
        _headerIcon.preservesSuperviewLayoutMargins = YES;
        
    }
    return _headerIcon;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = TPTitleTextColor;
        _nameLabel.font = TPSystemFontSize(13);
        _nameLabel.preservesSuperviewLayoutMargins = YES;
    }
    return _nameLabel;
}

- (TPStartView *)starView {
    if (!_starView) {
        _starView = [[TPStartView alloc]init];
        _starView.preservesSuperviewLayoutMargins = YES;
    }
    return _starView;
}
- (UIButton *)receiveBtn {
    
    if (!_receiveBtn) {
        _receiveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _receiveBtn.titleLabel.textColor = TPWhiteColor;
        _receiveBtn.titleLabel.font = TPSystemFontSize(20);
        [_receiveBtn addTarget:self action:@selector(tapReceiveBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_receiveBtn setBackgroundImage:[UIImage imageNamed:ReceiveBtn_Nor_Image] forState:0];
        [_receiveBtn setBackgroundImage:[UIImage imageNamed:ReceiveBtn_Hight_Image] forState:UIControlStateSelected];
        _receiveBtn.preservesSuperviewLayoutMargins = YES;
    }
    return _receiveBtn;
}
- (UIButton *)callBtn {
    if (!_callBtn) {
        _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callBtn setBackgroundImage:[UIImage imageNamed:CallBtnImage_nor] forState:0];
        [_callBtn setBackgroundImage:[UIImage imageNamed:CallBtnImage_Highlight] forState:UIControlStateSelected];
        [_callBtn addTarget:self action:@selector(tapCallBtn:) forControlEvents:UIControlEventTouchUpInside];
        _callBtn.preservesSuperviewLayoutMargins = YES;
        
    }
    return _callBtn;
}

- (UIButton *)highQualityShipperActivityIcon {
    if (!_highQualityShipperActivityIcon) {
        _highQualityShipperActivityIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        _highQualityShipperActivityIcon.titleLabel.font = TPAdaptedFontSize(10);
        [_highQualityShipperActivityIcon setTitleColor:UIColorHex(#FFB000 ) forState:0];
        
    }
    return _highQualityShipperActivityIcon;
}

- (UIImageView *)highQualityGoodActivityIcon {
    if (!_highQualityGoodActivityIcon) {
        _highQualityGoodActivityIcon = [[UIImageView alloc]init];
        
    }
    return _highQualityGoodActivityIcon;
}
- (void)setObject:(TPDGoodsItemViewModel *)object {
    
    [super setObject:object];
    self.delegate = object.target;
    
    _detail.font = TPAdaptedFontSize(GoodsGoodsInfoFontSize);
    
    _timeLabel.font =TPAdaptedFontSize(GoodsTimeFontSize);
    
    _depart.font = TPAdaptedBoldFontSize(GoodsAddressFontSize);
    
    _destination.font = TPAdaptedBoldFontSize(GoodsAddressFontSize);
    
    _depart.text = object.depart_address;
    
    _destination.text = object.destination_address;
    
    _detail.text = object.details;
    
    _nameLabel.text = object.name;

    _timeLabel.text = object.update_time;
    
    _starView.score = object.rate.floatValue;
    
    _callBtn.selected = object.is_call.intValue;
    
    _receiveBtn.selected = object.is_receive_order.intValue;
    
     self.backgroundColor = object.is_examine.intValue == 1 ? UIColorHex(#EFEFEF):TPWhiteColor;
    
    [_highQualityGoodActivityIcon tp_setOriginalImageWithURL:[NSURL URLWithString:object.goodsModel.Icon_url ] md5Key:object.goodsModel.Icon_key];
    
    if (object.isAnonymous) {
        _headerIcon.image = object.anonymousImage;
    }else{
        [_headerIcon tp_setOriginalImageWithURL:[NSURL URLWithString:object.goodsModel.owner_info.owner_icon_url] md5Key:object.goodsModel.owner_info.owner_icon_key placeholderImage:[UIImage imageNamed:@"common_user_image"]];
    }
    
}
@end
