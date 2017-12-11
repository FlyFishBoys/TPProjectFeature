//
//  TPDSelectProvinceView.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSelectProvinceView.h"
#import "UIView+Gradient.h"

static NSInteger MaxRowCount = 6;

static CGFloat ButtonW_H = 38;

@interface TPDSelectProvinceView ()

@property (nonatomic,strong) UIView * contentView;

@property (nonatomic,strong) UILabel * titleLable;

@property (nonatomic,strong) UIView * lineView;

@property (nonatomic,strong) UIButton * dismissButton;

@property (nonatomic,strong) UIButton * submitButton;

@end

@implementation TPDSelectProvinceView
{
    NSArray *proData_;
    UIButton *selectedButton_;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame ]) {
        proData_ = @[@"京",@"津",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"沪",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"川",@"云",@"渝",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"港",@"澳",@"台"];
        
        [self addSubviews];
    }
    return self;
}
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - event
- (void)selectProvince:(UIButton *)sender {
    selectedButton_.selected = NO;
    sender.selected = YES;
    selectedButton_ = sender;
}
- (void)submit {
    if (self.selectedBolck) {
        self.selectedBolck(selectedButton_.titleLabel.text);
    }
    [self dismiss];
}
- (void)addSubviews {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLable];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.dismissButton];
    [self.contentView addSubview:self.submitButton];
    
    self.contentView.frame = CGRectMake(TPAdaptedWidth(23), TPAdaptedHeight(122), kScreenWidth - TPAdaptedWidth(46), 0);
    
    self.titleLable.frame = CGRectMake(0, 0, self.contentView.width, TPAdaptedHeight(44));
    
    self.lineView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLable.frame), self.contentView.width, 0.5);
    
    self.dismissButton.frame = CGRectMake(self.contentView.width - TPAdaptedHeight(44), 0, TPAdaptedHeight(44), TPAdaptedHeight(44));
    
    int idx = 0;
    CGFloat margin = (self.contentView.width - MaxRowCount *ButtonW_H)/(MaxRowCount + 1);
    for (NSString *pro in proData_) {
        CGFloat x = margin * (idx % MaxRowCount + 1) + ButtonW_H * (idx % MaxRowCount);
        CGFloat y = CGRectGetMaxY(self.lineView.frame) + margin * (idx / MaxRowCount + 1) + ButtonW_H *(idx / MaxRowCount);
        UIButton *btn = [self itemButtonWithTitle:pro];
        btn.frame = CGRectMake(x, y, ButtonW_H, ButtonW_H);
        [self.contentView addSubview:btn];
        idx ++;
    }
    
    self.submitButton.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.subviews.lastObject.frame) + TPAdaptedHeight(12), self.contentView.width, TPAdaptedHeight(44));
    [self.submitButton addGradientWithStartColor:TPGradientStartColor endColor:TPGradientEndColor];
    
    self.contentView.frame = CGRectMake(TPAdaptedWidth(23), TPAdaptedHeight(122), kScreenWidth - TPAdaptedWidth(46), CGRectGetMaxY(self.submitButton.frame));
}
#pragma mark - factory
- (UIButton *)itemButtonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = TPAdaptedFontSize(16);
    [btn setTitleColor:TPTitleTextColor forState:UIControlStateNormal];
    [btn setTitleColor:TPWhiteColor forState:UIControlStateSelected];
    UIImage *normalImage = [[UIImage imageWithColor:TPWhiteColor
                                               size:CGSizeMake(ButtonW_H, ButtonW_H)] imageByRoundCornerRadius:2 borderWidth:0.5 borderColor:TPUNEnbleColor_LineColor];
    [btn setBackgroundImage:normalImage forState:UIControlStateNormal];
    
    UIImage *selectedImage = [[UIImage imageWithColor:TPMainColor
                                                 size:CGSizeMake(ButtonW_H, ButtonW_H)] imageByRoundCornerRadius:2];
    [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(selectProvince:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
   
}
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = TPWhiteColor;
        _contentView.layer.cornerRadius = 4;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _lineView;
}
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"请选择省份";
        _titleLable.textColor = TPTitleTextColor;
        _titleLable.font = TPAdaptedFontSize(17);
        _titleLable.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLable;
}
- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setImage:[UIImage imageNamed:@"smart_find_goods_scroll_text_close_icon"] forState:UIControlStateNormal];
        [_dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissButton;
}
- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}
@end
