//
//  TPDSmartFindGoodsFooterView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSmartFindGoodsFooterView.h"
#import "UIImage+Gradient.h"
@interface TPDSmartFindGoodsFooterView()

@property (nonatomic , strong) UILabel *title;
@property (nonatomic , strong) UIButton *leftBtn;
@property (nonatomic , strong) UIButton *rightBtn;
@property (nonatomic , strong) UIView *line;

@end

@implementation TPDSmartFindGoodsFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        [self setFrame];
    }
    return self;
}

- (void)setFrame {
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(TPScreenWidth);
        
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(TPAdaptedHeight(20));
        make.centerX.equalTo(self);
       
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-11));
        make.width.mas_equalTo(TPAdaptedWidth(120));
        make.height.mas_equalTo(TPAdaptedHeight(34));
        make.left.equalTo(self).offset(TPAdaptedWidth(53));
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-11));
        make.width.mas_equalTo(TPAdaptedWidth(120));
        make.height.mas_equalTo(TPAdaptedHeight(34));
        make.right.equalTo(self).offset(TPAdaptedWidth(-56));
    }];
}

- (void)addSubviews {
    [self addSubview:self.title];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.line];
}

#pragma mark - Event Response
- (void)tapLeftBtn {
    if (self.tapLeftBtnBlock) {
        self.tapLeftBtnBlock();
    }
}

- (void)tapRightBtn {
    
    
    if (self.tapRightBtnBlcok) {
        self.tapRightBtnBlcok(self.rightBtnType);
    }
}


#pragma mark - Getters and Setters
- (UIView *)line {
    
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    
    return _line;
}
- (UILabel *)title {
    
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.text = @"找不到合适货源？快去联系货运经纪人！";
        _title.textColor = TPTitleTextColor;
        _title.font = TPSystemFontSize(15);
        _title.textAlignment = NSTextAlignmentCenter;
    }
    
    return _title;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"附近货源" forState:0];
        _leftBtn.titleLabel.textColor = TPTitleTextColor;
        [_leftBtn setTitleColor:TPTitleTextColor forState:0];
        _leftBtn.backgroundColor = TPWhiteColor;
        _leftBtn.layer.cornerRadius = TPAdaptedHeight(18);
        _leftBtn.layer.masksToBounds = YES;
        _leftBtn.layer.borderColor = TPMainColor.CGColor;
        _leftBtn.layer.borderWidth = 1;
        _leftBtn.titleLabel.font = TPSystemFontSize(15);
          [_leftBtn addTarget:self action:@selector(tapLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.titleLabel.textColor = TPWhiteColor;
        _rightBtn.backgroundColor = TPWhiteColor;
        _rightBtn.layer.cornerRadius = TPAdaptedHeight(18);
        _rightBtn.layer.masksToBounds = YES;
         [_rightBtn setTitleColor:TPWhiteColor forState:0];
        [_rightBtn setTitle:@"匹配中心" forState:0];
        _rightBtn.titleLabel.font = TPSystemFontSize(15);
        [_rightBtn setBackgroundImage:[UIImage createGradientImageWithSize:CGSizeMake(TPAdaptedWidth(120), TPAdaptedHeight(34)) startColor:TPGradientStartColor endColor:TPGradientEndColor] forState:0];
        [_rightBtn addTarget:self action:@selector(tapRightBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
- (void)setRightBtnType:(GoodsFooterViewRightBtnType)rightBtnType {
    
    _rightBtnType = rightBtnType;
    switch (_rightBtnType) {
        case GoodsFooterViewRightBtnType_FreightAgent:
             [_rightBtn setTitle:@"货运经济人" forState:0];
            break;
            
        case GoodsFooterViewRightBtnType_MatchedCenter:
             [_rightBtn setTitle:@"匹配中心" forState:0];
            break;
    }
}

@end
