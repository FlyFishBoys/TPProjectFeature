//
//  TPDColorPlateView.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDColorPlateView.h"
#import "UIButton+ResetContent.h"

typedef NS_ENUM(NSInteger, ColorPlateType) {
    ColorPlateType_Yellow = 1000,
    ColorPlateType_Blue,
};

@interface TPDColorPlateView ()
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * yellowCardButton;
@property (nonatomic,strong) UIButton * blueCardButton;

@end

@implementation TPDColorPlateView
#pragma mark - LifeCycle
- (instancetype)init {
    if (self = [super init]) {
        _isEnble = YES;
        _plateColor = @"2";//黄色
        [self cp_addSubviews];
    }
    return self;
}

#pragma mark - Events
- (void)cp_colorBUttonEvent:(UIButton *)button {
    if (!self.isEnble) return;

    button.selected = !button.selected;
    switch (button.tag) {
        case ColorPlateType_Yellow:
        {
            self.blueCardButton.selected = !button.selected;
        }
            break;
            
        case ColorPlateType_Blue:
        {
            self.yellowCardButton.selected = !button.selected;
        }
            break;
    }
    
    if (self.colorPlateCompleteBlock) {
        NSString *plateColor;
        if (self.blueCardButton.selected) {
            plateColor = @"1";
        } else if (self.yellowCardButton.selected) {
            plateColor = @"2";
        } else {
            plateColor = @"2";
        }
        self.colorPlateCompleteBlock(plateColor);
    }
}

#pragma mark - Private
- (void)cp_addSubviews {
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = TPAdaptedFontSize(15);
    [_titleLabel setText:@"车牌颜色"];
    _titleLabel.textColor = TPTitleTextColor;
    [self addSubview:_titleLabel];
    
    _yellowCardButton = [self createColorBUttonWithColorPlateType:ColorPlateType_Yellow];
    [self addSubview:_yellowCardButton];
    
    _blueCardButton = [self createColorBUttonWithColorPlateType:ColorPlateType_Blue];
    [self addSubview:_blueCardButton];
    
    [self cp_setupConstraints];
}

- (void)cp_setupConstraints {
    
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.top.bottom.equalTo(self);
    }];
    
    [_blueCardButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(TPAdaptedWidth(60));
    }];
    [_blueCardButton horizontalCenterImageAndTitle:TPAdaptedWidth(8)];

    
    [_yellowCardButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_blueCardButton.mas_left).offset(TPAdaptedWidth(-24));
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(TPAdaptedWidth(60));
    }];
    [_yellowCardButton horizontalCenterImageAndTitle:TPAdaptedWidth(8)];

    UIView * bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = TPUNEnbleColor_LineColor;
    [self addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}


- (UIButton *)createColorBUttonWithColorPlateType:(ColorPlateType)colorPlateType {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(cp_colorBUttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_normal"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_selected"] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.font = TPAdaptedFontSize(15);
    button.tag = colorPlateType;
    switch (button.tag) {
        case ColorPlateType_Yellow:
        {
            [button setTitle:@"黄牌" forState:UIControlStateNormal];
            [button setTitleColor:UIColorHex(FFBE5E) forState:UIControlStateNormal];
            button.selected = YES;
        }
            break;
            
        case ColorPlateType_Blue:
        {
            [button setTitle:@"蓝牌" forState:UIControlStateNormal];
            [button setTitleColor:TPMainColor forState:UIControlStateNormal];
            button.selected = NO;
        }
            break;
    }
    return button;
}

- (void)setPlateColor:(NSString *)plateColor {
    _plateColor = plateColor;
    if ([plateColor isEqualToString:@"1"]) {//黄色
        self.blueCardButton.selected = YES;
        self.yellowCardButton.selected = NO;
    } else if ([plateColor isEqualToString:@"2"]) {//绿色
        self.blueCardButton.selected = NO;
        self.yellowCardButton.selected = YES;
    } else {//默认黄色
        self.blueCardButton.selected = YES;
        self.yellowCardButton.selected = NO;
    }
}

@end
