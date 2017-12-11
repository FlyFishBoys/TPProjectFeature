//
//  TPDListenOrderSetTableViewHeader.m
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderSetTableViewHeader.h"
@interface TPDListenOrderSetTableViewHeader()

@property (nonatomic , strong) UIImageView *icon;
@property (nonatomic , strong) UILabel *title;

@property (nonatomic , copy) NSString *titleStr;
@property (nonatomic , strong) NSString *iconStr;
@end

@implementation TPDListenOrderSetTableViewHeader
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPBackgroundColor;
        [self addSubviews];
        [self setFrame];
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon {
    
    self = [super init];
    if (self) {
        self.titleStr = title;
        self.iconStr = icon;
    }
    return self;
}
- (void)addSubviews {
    
    [self addSubview:self.icon];
    [self addSubview:self.title];
}
- (void)setFrame {
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.centerY.equalTo(self);
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(46));
        make.centerY.equalTo(self.icon);
    }];
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
    
}
- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc]init];
        _title.textColor = UIColorHex(#030303);
        _title.font = TPSystemFontSize(14);
    }
    return _title;
}
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    _title.text = _titleStr;
}
- (void)setIconStr:(NSString *)iconStr {
    _iconStr = iconStr;
    _icon.image = [UIImage imageNamed:_iconStr];
}
@end
