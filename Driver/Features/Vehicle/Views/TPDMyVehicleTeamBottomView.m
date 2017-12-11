//
//  TPDMyVehicleTeamBottomView.m
//  Driver
//
//  Created by Mr.mao on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyVehicleTeamBottomView.h"

@interface TPDMyVehicleTeamBottomView ()
@property (nonatomic, strong) UIButton * swatchSeekGoodsButton;
@property (nonatomic, strong) UIButton * swatchRestButton;
@property (nonatomic, strong) UIView   * separateLine;
@end

@implementation TPDMyVehicleTeamBottomView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = TPMainColor;
        [self vb_setupSubviews];
    }
    return self;
}

#pragma mark Events
- (void)vb_swatchSeekGoodsButtonEvent {
    if (self.swithAllStatusBlock) {
        self.swithAllStatusBlock(@"1");
    }
}

- (void)vb_swatchRestButtonEvent {
    if (self.swithAllStatusBlock) {
        self.swithAllStatusBlock(@"2");
    }
}

#pragma mark - Privates
- (void)vb_setupSubviews {
    [self addSubview:self.swatchSeekGoodsButton];
    [self addSubview:self.swatchRestButton];
    [self addSubview:self.separateLine];
    [self vb_setupConstraints];
}

- (void)vb_setupConstraints {
    [self.separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo(TPAdaptedHeight(20));
    }];
    
    [self.swatchSeekGoodsButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/2.0f);
    }];
    
    [self.swatchRestButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1/2.0f);
    }];
}

#pragma mark - Getters
- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _separateLine;
}

- (UIButton *)swatchSeekGoodsButton {
    if (!_swatchSeekGoodsButton) {
        _swatchSeekGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_swatchSeekGoodsButton setTitle:@"全部求货" forState:UIControlStateNormal];
        [_swatchSeekGoodsButton setTitleColor:TPWhiteColor forState:UIControlStateNormal];
        _swatchSeekGoodsButton.titleLabel.font = TPAdaptedFontSize(17);
        [_swatchSeekGoodsButton addTarget:self action:@selector(vb_swatchSeekGoodsButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        _swatchSeekGoodsButton.adjustsImageWhenHighlighted = NO;
    }
    return _swatchSeekGoodsButton;
}

- (UIButton *)swatchRestButton {
    if (!_swatchRestButton) {
        _swatchRestButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_swatchRestButton setTitle:@"全部休息" forState:UIControlStateNormal];
        [_swatchRestButton setTitleColor:TPWhiteColor forState:UIControlStateNormal];
        _swatchRestButton.titleLabel.font = TPAdaptedFontSize(17);
        [_swatchRestButton addTarget:self action:@selector(vb_swatchRestButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        _swatchRestButton.adjustsImageWhenHighlighted = NO;
    }
    return _swatchRestButton;
}

@end
