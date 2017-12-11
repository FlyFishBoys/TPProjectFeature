//
//  TPDAddSubscribeRouteCustomView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/29.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddSubscribeRouteCustomView.h"
#define TPDAddSubscribeRouteCustomView_Right_Arrow_Img  @"common_cell_arrow"
@interface TPDAddSubscribeRouteCustomView()

@property (nonatomic , strong) UILabel *leftLabel;
@property (nonatomic , strong) UIImageView *rightArrow;
@property (nonatomic , strong) UILabel *detailLabel;
@property (nonatomic , strong) UIView *line;

@end

@implementation TPDAddSubscribeRouteCustomView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        [self setFrame];
    }
    return self;
}
- (void)addSubviews {
    
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightArrow];
    [self addSubview:self.detailLabel];
    [self addSubview:self.line];
}
- (void)setFrame {
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
    
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.bottom.equalTo(self.line.mas_top);
        make.width.mas_equalTo([@"车型车长" widthForFont:TPAdaptedFontSize(16)]);
    }];
    
    [_rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
    }];
    
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right).offset(TPAdaptedWidth(18));
        make.right.equalTo(self).offset(TPAdaptedWidth(-50));
        make.top.equalTo(self);
        make.bottom.equalTo(_leftLabel.mas_bottom);
        
    }];
    
}
- (void)tapView {
    
    if (self.tapBlock) {
        self.tapBlock();
    }
    
}
- (UILabel *)leftLabel {
    
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.textColor = TPTitleTextColor;
        _leftLabel.font = TPAdaptedFontSize(15);
    }
    return _leftLabel;
}
- (UILabel *)detailLabel {
    
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.userInteractionEnabled = YES;
        _detailLabel.textColor = TPTitleTextColor;
        _detailLabel.font = TPAdaptedFontSize(15);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        [_detailLabel addGestureRecognizer:tap];
    }
    return _detailLabel;
}

- (UIImageView *)rightArrow {
    
    if (!_rightArrow) {
        _rightArrow = [[UIImageView alloc]init];
        _rightArrow.image = [UIImage imageNamed:TPDAddSubscribeRouteCustomView_Right_Arrow_Img];
        
    }
    return _rightArrow;
}

- (UIView *)line {
    if (!_line) {
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;
}

- (void)setLeftTitle:(NSString *)leftTitle {
    
    _leftTitle = leftTitle;
    _leftLabel.text = _leftTitle;
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    _detailLabel.text = placeholder;
    _detailLabel.textColor = TPPlaceholderColor;;
}
- (void)setTextFieldText:(NSString *)textFieldText {
    _textFieldText = textFieldText;
    _detailLabel.text = textFieldText;
    _detailLabel.textColor = TPTitleTextColor;;
}

@end

