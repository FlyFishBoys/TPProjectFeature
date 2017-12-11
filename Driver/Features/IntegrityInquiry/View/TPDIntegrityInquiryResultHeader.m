//
//  TPDIntegrityInquiryResultHeader.m
//  Driver
//
//  Created by Mr.mao on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryResultHeader.h"
#import "TPStartView.h"
#import "TPDIntegrityInquiryViewModel.h"
#import "TPDIntegrityInquiryModel.h"

@interface TPDIntegrityInquiryResultHeader ()
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UIButton * typeButton;
@property (nonatomic, strong) UIButton * authenticationButton;
@property (nonatomic, strong) UIButton * verifiedButton;
@property (nonatomic, strong) UIButton * vehicleCertificationButton;
@property (nonatomic, strong) TPStartView * star;
@property (nonatomic, strong) UILabel * starLabel;
@property (nonatomic, strong) UIButton * integrityLevelButton;
@property (nonatomic, strong) UILabel * integrityTitleLabel;
@property (nonatomic, strong) UILabel * integrityScoreLabel;
@property (nonatomic, strong) UILabel * receivingTitleLabel;
@property (nonatomic, strong) UILabel * receivingNumLabel;
@property (nonatomic, strong) UILabel * clinchDealTitleLabel;
@property (nonatomic, strong) UILabel * clinchDealNumLabel;

@end

@implementation TPDIntegrityInquiryResultHeader

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = TPWhiteColor;
        [self ih_addSubviews];
    }
    return self;
}

#pragma mark - Privates
- (UIButton *)createButtonWithTitle:(NSString *)title backgroundImageNameNormal:(NSString *)backgroundImageNameNormal backgroundImageNameSelected:(NSString *)backgroundImageNameSelected {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorHex(FFB000) forState:UIControlStateSelected];
    [button setTitleColor:TPMinorTextColor forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameNormal] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:backgroundImageNameSelected] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.font = TPAdaptedFontSize(11);
    return button;
}

- (UILabel *)createLabelWithText:(NSString *)text {
    UILabel * label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = TPMainTextColor;
    label.font = TPAdaptedFontSize(17);
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)ih_addSubviews {
    [self addSubview:self.icon];
    [self addSubview:self.typeButton];
    [self addSubview:self.authenticationButton];
    [self addSubview:self.verifiedButton];
    [self addSubview:self.vehicleCertificationButton];
    [self addSubview:self.starLabel];
    [self addSubview:self.star];
    [self addSubview:self.integrityLevelButton];
    [self addSubview:self.integrityTitleLabel];
    [self addSubview:self.integrityScoreLabel];
    [self addSubview:self.receivingTitleLabel];
    [self addSubview:self.receivingNumLabel];
    [self addSubview:self.clinchDealTitleLabel];
    [self addSubview:self.clinchDealNumLabel];

    [self ih_remakeConstraints];
}

- (void)ih_remakeConstraints {
    [self.icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(TPAdaptedHeight(16));
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.width.height.mas_equalTo(TPScale(50));
    }];
    
    [self.typeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(TPAdaptedHeight(20));
        make.left.equalTo(self.icon.mas_right).offset(TPAdaptedWidth(12));
        make.width.mas_equalTo(TPAdaptedWidth(34));
        make.height.mas_equalTo(TPAdaptedHeight(16));
    }];
    
    [self.verifiedButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton.mas_top);
        make.left.equalTo(self.typeButton.mas_right).offset(TPAdaptedWidth(6));
        make.width.mas_equalTo(TPAdaptedWidth(56));
        make.height.mas_equalTo(TPAdaptedHeight(16));
    }];
    
    [self.authenticationButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton.mas_top);
        make.left.equalTo(self.verifiedButton.mas_right).offset(TPAdaptedWidth(6));
        make.width.mas_equalTo(TPAdaptedWidth(56));
        make.height.mas_equalTo(TPAdaptedHeight(16));
    }];
    
    [self.vehicleCertificationButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton.mas_top);
        make.left.equalTo(self.authenticationButton.mas_right).offset(TPAdaptedWidth(6));
        make.width.mas_equalTo(TPAdaptedWidth(56));
        make.height.mas_equalTo(TPAdaptedHeight(16));
    }];
    
    [self.star mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeButton.mas_bottom).offset(TPAdaptedHeight(10));
        make.left.equalTo(self.typeButton.mas_left);
        make.width.mas_equalTo(TPAdaptedWidth(13.3 * 5));
        make.height.mas_equalTo(TPAdaptedWidth(13.3));
    }];
    
    [self.starLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.star.mas_top);
        make.left.equalTo(self.star.mas_right).offset(TPAdaptedWidth(8));
    }];
    
    [self.integrityTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-12));
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1 / 3.0);
    }];
    
    [self.integrityScoreLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.integrityTitleLabel.mas_top).offset(TPAdaptedHeight(-7));
        make.left.equalTo(self.integrityTitleLabel.mas_left);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1 / 3.0);
    }];
    
    [self.integrityLevelButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.integrityScoreLabel.mas_top).offset(TPAdaptedHeight(-4));
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(77));
    }];
    
    [self.receivingTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.integrityTitleLabel.mas_bottom);
        make.left.equalTo(self.integrityTitleLabel.mas_right);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1 / 3.0);
    }];
    
    [self.receivingNumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.integrityScoreLabel.mas_bottom);
        make.left.equalTo(self.receivingTitleLabel.mas_left);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1 / 3.0);
    }];
    
    [self.clinchDealTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.integrityTitleLabel.mas_bottom);
        make.left.equalTo(self.receivingTitleLabel.mas_right);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1 / 3.0);
    }];
    
    [self.clinchDealNumLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.integrityScoreLabel.mas_bottom);
        make.left.equalTo(self.clinchDealTitleLabel.mas_left);
        make.width.mas_equalTo(self.mas_width).multipliedBy(1 / 3.0);
    }];
}

#pragma mark - Getters and Setters
- (void)setViewModel:(TPDIntegrityInquiryViewModel *)viewModel {
    _viewModel = viewModel;
    [self.icon tp_setSizeToFitCircleImageWithURL:
                                                 [NSURL URLWithString:viewModel.model.icon_image_url]
                                                 md5Key:viewModel.model.icon_image_key
                                                 placeholderImage:[UIImage imageNamed:@"user_setup_refereerecord_icon"]];
    [self.typeButton setTitle:viewModel.userType forState:UIControlStateNormal];
    self.authenticationButton.selected = viewModel.isAuthentication;
    self.verifiedButton.selected = viewModel.isVerified;
    self.vehicleCertificationButton.selected = viewModel.isVehicleCertification;
    self.vehicleCertificationButton.hidden = viewModel.isHiddenVehicleCertification;
    self.star.score = viewModel.score;
    self.starLabel.text = viewModel.starRating;
    [self.integrityLevelButton setTitle:viewModel.integrityLevel forState:UIControlStateNormal];
    self.integrityScoreLabel.text = viewModel.integrityValue;
    self.receivingNumLabel.text = viewModel.receivingNum;
    self.clinchDealNumLabel.text = viewModel.clinchDealNum;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UIButton *)typeButton {
    if (!_typeButton) {
        _typeButton = [self createButtonWithTitle:@"司机" backgroundImageNameNormal:@"integrityinquiry_type_background" backgroundImageNameSelected:@"integrityinquiry_type_background"];
        _typeButton.selected = YES;
    }
    return _typeButton;
}

- (UIButton *)authenticationButton {
    if (!_authenticationButton) {
        _authenticationButton = [self createButtonWithTitle:@"实名认证" backgroundImageNameNormal:@"integrityinquiry_certification_background_normal" backgroundImageNameSelected:@"integrityinquiry_certification_background_selected"];
    }
    return _authenticationButton;
}

- (UIButton *)verifiedButton {
    if (!_verifiedButton) {
        _verifiedButton = [self createButtonWithTitle:@"身份认证" backgroundImageNameNormal:@"integrityinquiry_certification_background_normal" backgroundImageNameSelected:@"integrityinquiry_certification_background_selected"];
    }
    return _verifiedButton;
}

- (UIButton *)vehicleCertificationButton {
    if (!_vehicleCertificationButton) {
        _vehicleCertificationButton = [self createButtonWithTitle:@"车辆认证" backgroundImageNameNormal:@"integrityinquiry_certification_background_normal" backgroundImageNameSelected:@"integrityinquiry_certification_background_selected"];
    }
    return _vehicleCertificationButton;
}

- (TPStartView *)star {
    if (!_star) {
        _star = [[TPStartView alloc] initWithStarViewType:StartViewType_Middle];
    }
    return _star;
}

- (UILabel *)starLabel {
    if (!_starLabel) {
        _starLabel = [[UILabel alloc] init];
        _starLabel.text = @"0.0分";
        _starLabel.textColor = TPTitleTextColor;
        _starLabel.font = TPAdaptedFontSize(13);
    }
    return _starLabel;
}

- (UIButton *)integrityLevelButton {
    if (!_integrityLevelButton) {
        _integrityLevelButton = [self createButtonWithTitle:@"" backgroundImageNameNormal:@"integrityinquiry_level_background" backgroundImageNameSelected:@"integrityinquiry_type_background"];
    }
    return _integrityLevelButton;
}

- (UILabel *)integrityTitleLabel {
    if (!_integrityTitleLabel) {
        _integrityTitleLabel = [self createLabelWithText:@"诚信值"];
    }
    return _integrityTitleLabel;
}

- (UILabel *)integrityScoreLabel {
    if (!_integrityScoreLabel) {
        _integrityScoreLabel = [self createLabelWithText:@"0.0"];
    }
    return _integrityScoreLabel;
}

- (UILabel *)receivingTitleLabel {
    if (!_receivingTitleLabel) {
        _receivingTitleLabel = [self createLabelWithText:@"接单数"];
    }
    return _receivingTitleLabel;
}

- (UILabel *)receivingNumLabel {
    if (!_receivingNumLabel) {
        _receivingNumLabel = [self createLabelWithText:@"0"];
    }
    return _receivingNumLabel;
}

- (UILabel *)clinchDealTitleLabel {
    if (!_clinchDealTitleLabel) {
        _clinchDealTitleLabel = [self createLabelWithText:@"成交量"];
    }
    return _clinchDealTitleLabel;
}

- (UILabel *)clinchDealNumLabel {
    if (!_clinchDealNumLabel) {
        _clinchDealNumLabel = [self createLabelWithText:@"0.0"];
    }
    return _clinchDealNumLabel;
}

@end
