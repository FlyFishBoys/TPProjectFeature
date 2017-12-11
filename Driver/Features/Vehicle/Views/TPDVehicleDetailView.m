//
//  TPDVehicleDetailView.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleDetailView.h"

@interface TPDVehicleDetailView ()
{
    BOOL _isHasSeprate;
    NSString * _title;
    TPDVehicleDetailViewLayoutType _layoutType;
}

@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * contentLabel;
@property (nonatomic, strong) UIView  * separateLine;

@end

@implementation TPDVehicleDetailView

- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content layoutType:(TPDVehicleDetailViewLayoutType)layoutType isHasSeprate:(BOOL)isHasSeprate {
    if (self = [super init]) {
        _title = title;
        _content = content;
        _isHasSeprate = isHasSeprate;
        _layoutType = layoutType;
        self.clipsToBounds = YES;
        [self vd_addSubviews];
    }
    return self;
}

- (void)vd_addSubviews {
    self.backgroundColor = TPWhiteColor;
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.separateLine];
    [self vd_setupConstraints];
}

- (void)vd_setupConstraints {
    [self.separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
    }];
    
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(TPAdaptedWidth(22));
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
    }];
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = content;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = TPUNEnbleColor_LineColor;
        _separateLine.hidden = !_isHasSeprate;
    }
    return _separateLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = _title.isNotBlank ? _title : @"";
        _titleLabel.font = TPAdaptedFontSize(15);
        _titleLabel.textColor = TPTitleTextColor;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.text = _content.isNotBlank ? _content : @"";
        _contentLabel.font = TPAdaptedFontSize(15);
        _contentLabel.textColor = TPTitleTextColor;
        _contentLabel.textAlignment = _layoutType == TPDVehicleDetailViewLayoutType_Left ? NSTextAlignmentLeft : NSTextAlignmentRight;
    }
    return _contentLabel;
}

@end
