//
//  TPPersonalCenterCellView.m
//  TopjetPicking
//
//  Created by lish on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileCellView.h"
@interface TPDProfileCellView()

@property (nonatomic , strong) UILabel *title;

@property (nonatomic , strong) UILabel *detail;

@property (nonatomic , strong) UIImageView *arrow;

@property (nonatomic , strong) UISwitch *switchImg;

@property (nonatomic , strong) UIView *line;

@end

@implementation TPDProfileCellView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        [self setFrame];
        
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.anyObject.view == self && self.viewType == PersonalCenterCellViewType_Arrow) {
        if (self.tapArrowHandle) {
            self.tapArrowHandle();
        }
    }
}
- (void)setFrame {
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.centerY.equalTo(self);
    }];

    [_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-34));
        make.centerY.equalTo(self);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
    }];
    
    [_switchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.width.mas_equalTo(TPScreenWidth-TPAdaptedWidth(12));
    }];
}

#pragma mark - Event Response
- (void)switchAction:(UISwitch *)switchImg{
    
    
    if (self.tapSwitchHandle) {
        self.tapSwitchHandle(_switchImg.on);
    }
    
}

- (void)addSubviews {
    
    
    [self addSubview:self.title];
    [self addSubview:self.detail];
    [self addSubview:self.arrow];
    [self addSubview:self.switchImg];
    [self addSubview:self.line];
}

- (UIImageView *)arrow {
    
    
    if (!_arrow) {
        _arrow = [[UIImageView alloc]init];
        _arrow.image = [UIImage imageNamed:@"common_cell_arrow"];

    }
    return _arrow;
    
}
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
        _title.text = @"客服热线";
        _title.font = TPAdaptedFontSize(15);
        _title.textColor = TPTitleTextColor;
    }
    return _title;
    
}

- (UILabel *)detail {
    
    if (!_detail) {
        _detail = [[UILabel alloc]init];
        _detail.text = @"400-056-6560";
        _detail.font = TPAdaptedFontSize(13);
        _detail.textColor = TPTitleTextColor;
    }
    return _detail;
    
}

- (UISwitch *)switchImg {
    
    if (!_switchImg) {
        _switchImg = [[UISwitch alloc]init];
        _switchImg.onImage = [UIImage imageNamed:@"personal_center_swicth_on"];
        _switchImg.offImage = [UIImage imageNamed:@"personal_center_swicth_off"];
        _switchImg.tintColor = TPPlaceholderColor;
        _switchImg.onTintColor = TPGradientStartColor;
        _switchImg.on = YES;
        [_switchImg addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchImg;

}


- (void)setViewType:(PersonalCenterCellViewType)viewType {
    
    _viewType = viewType;
  
    _switchImg.hidden = _viewType == PersonalCenterCellViewType_Swicth?NO:YES;
    _arrow.hidden = _viewType == PersonalCenterCellViewType_Arrow?NO:YES;
    _detail.hidden = _viewType == PersonalCenterCellViewType_Arrow?NO:YES;
}

- (void)setTitleStr:(NSString *)titleStr {
    
    _titleStr = titleStr;
    _title.text = _titleStr;
    
}

- (void)setDetailStr:(NSString *)detailStr {
    _detailStr = detailStr;
    _detail.text = _detailStr;
    
}
@end
