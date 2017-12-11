//
//  TPDFreightAgentHeaderView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreightAgentHeaderView.h"
@interface TPDFreightAgentHeaderView()

@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIButton *closeBtn;
@property (nonatomic , strong) UIView *line;

@end


@implementation TPDFreightAgentHeaderView

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
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.closeBtn];
    [self addSubview:self.line];
}

- (void)setFrame {
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-16));
        make.centerY.equalTo(self);
        
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
    }];
}

- (void)tapCloseBtn{
    
    if (self.tapCloseBtnBlock) {
        self.tapCloseBtnBlock();
    }
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"共为您找到以下经纪人";
        _titleLabel.font = TPSystemFontSize(17);
        _titleLabel.textColor = TPTitleTextColor;
    }
    return _titleLabel;
    
}
- (UIButton *)closeBtn {
    
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"smart_find_goods_scroll_text_close_icon"] forState:0];
        [_closeBtn addTarget:self action:@selector(tapCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
    
}

- (UIView *)line {
    
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;
    
}

@end
