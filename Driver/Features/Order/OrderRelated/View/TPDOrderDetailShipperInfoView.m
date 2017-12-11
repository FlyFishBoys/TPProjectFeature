//
//  TPDOrderDetailShipperInfoView.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDOrderDetailShipperInfoView.h"
#import "TPDOrderDetailShipperInfoViewModel.h"
#import "TPDOrderDetailShipperInfoModel.h"
#import "UIImageView+TPWebCache.h"
#import "TPStartView.h"

@interface TPDOrderDetailShipperInfoView ()
@property (nonatomic, strong) UIImageView * header;
@property (nonatomic, strong) TPStartView   * starView;
@property (nonatomic, strong) UILabel  * nameLabel;
@property (nonatomic, strong) UILabel * dealCountLabel;
@property (nonatomic, strong) UILabel * mobileLabel;
@property (nonatomic, strong) UILabel * updateTimeLabel;
@property (nonatomic, strong) UIButton * messageButton;
@property (nonatomic, strong) UIButton * callButton;

@end

@implementation TPDOrderDetailShipperInfoView

#pragma mark - LifeCycle
- (instancetype)init {
    if (self = [super init]) {
        [self oc_setupSubviews];
    }
    return self;
}

#pragma mark - Privates
- (void)oc_setupSubviews {
    
    self.backgroundColor = TPWhiteColor;
    [self addSubview:self.header];
    [self addSubview:self.nameLabel];
    [self addSubview:self.starView];
    [self addSubview:self.dealCountLabel];
    [self addSubview:self.mobileLabel];
    [self addSubview:self.messageButton];
    [self addSubview:self.callButton];
    
    [self oc_setupConstraints];
}

- (void)oc_setupConstraints {
    [self.header mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(TPAdaptedHeight(9));
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.width.height.mas_equalTo(TPScale(50));
    }];
    
    [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.header.mas_left);
        make.bottom.equalTo(self.header.mas_bottom).offset(TPAdaptedHeight(4));
        make.width.mas_equalTo(self.header.mas_width);
        make.height.mas_equalTo(TPAdaptedHeight(10));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.header.mas_right).offset(TPAdaptedWidth(8));
        make.top.equalTo(self.header.mas_top);
        make.width.mas_lessThanOrEqualTo(TPAdaptedWidth(100));
    }];
    
    [self.dealCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(TPAdaptedHeight(10));
        make.right.equalTo(self.messageButton.mas_left).offset(TPAdaptedWidth(-8));
    }];
    
    [self.callButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.width.mas_equalTo(self.callButton.currentImage.size.width);
    }];
    
    [self.messageButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.callButton.mas_left).offset(TPAdaptedWidth(-20));
        make.width.mas_equalTo(self.messageButton.currentImage.size.width);
    }];
    
    [self.mobileLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.dealCountLabel.mas_bottom).offset(TPAdaptedHeight(10));
        make.right.equalTo(self.messageButton.mas_left).offset(TPAdaptedWidth(-8));
    }];
}


#pragma mark - Setters and Getters
- (void)setViewModel:(TPDOrderDetailShipperInfoViewModel *)viewModel {
    _viewModel = viewModel;
    [self.header tp_setSizeToFitImageWithURL:[NSURL URLWithString:viewModel.model.owner_icon_url] md5Key:viewModel.model.owner_icon_key roundCornerRadius:4];
    self.starView.score = viewModel.starScore;
    self.nameLabel.text = viewModel.name;
    self.dealCountLabel.text = viewModel.dealRecord;
    self.mobileLabel.text = viewModel.mobile;
}

- (UIImageView *)header {
    if (!_header) {
        _header = [[UIImageView alloc]init];
        _header.contentMode = UIViewContentModeScaleAspectFill;
        _header.backgroundColor = TPImageViewBackgroundColor;
    }
    return _header;
}

- (TPStartView *)starView {
    if (!_starView) {
        _starView = [[TPStartView alloc]init];
    }
    return _starView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = TPAdaptedFontSize(15);
        _nameLabel.textColor = TPTitleTextColor;
        _nameLabel.text = @"";
        _nameLabel.preferredMaxLayoutWidth = YES;
    }
    return _nameLabel;
}

- (UILabel *)dealCountLabel {
    if (!_dealCountLabel) {
        _dealCountLabel = [[UILabel alloc]init];
        _dealCountLabel.font = TPAdaptedFontSize(12);
        _dealCountLabel.textColor = TPMainTextColor;
        _dealCountLabel.text = @"";
    }
    return _dealCountLabel;
}

- (UILabel *)mobileLabel {
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc]init];
        _mobileLabel.font = TPAdaptedFontSize(12);
        _mobileLabel.textColor = TPMainTextColor;
        _mobileLabel.text = @"";
    }
    return _mobileLabel;
}

- (UILabel *)updateTimeLabel {
    if (!_mobileLabel) {
        _mobileLabel = [[UILabel alloc]init];
        _mobileLabel.font = TPAdaptedFontSize(11);
        _mobileLabel.textColor = TPMinorTextColor;
        _mobileLabel.text = @"";
    }
    return _mobileLabel;
}

- (UIButton *)messageButton {
    if (!_messageButton) {
        _messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageButton setImage:[UIImage imageNamed:@"smart_find_goods_message_white"] forState:UIControlStateNormal];
        _messageButton.clipsToBounds = YES;
    }
    return _messageButton;
}

- (UIButton *)callButton {
    if (!_callButton) {
        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callButton setImage:[UIImage imageNamed:@"smart_find_goods_call_nor"] forState:UIControlStateNormal];
        _callButton.clipsToBounds = YES;
    }
    return _callButton;
}

@end
