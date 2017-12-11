//
//  TPDNearbyMapListHeaderView.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearbyMapListHeaderView.h"

@interface TPDNearbyMapListHeaderView ()

@property (nonatomic,strong) UIView * lineView;

@end

@implementation TPDNearbyMapListHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.lineView];
        [self addSubview:self.titleLable];
        [self addSubview:self.dismissButton];
    }
    return self;
}
- (void)updateConstraints {
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-TPAdaptedWidth(16));
        make.centerY.equalTo(self);
    }];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.right.lessThanOrEqualTo(self.dismissButton.mas_left).with.offset(-TPAdaptedWidth(16)).with.priorityLow();
    }];
    [super updateConstraints];
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
        _titleLable.text = @"---------";
        _titleLable.textColor = TPTitleTextColor;
        _titleLable.font = TPAdaptedFontSize(17);
    }
    return _titleLable;
}
- (UIButton *)dismissButton {
    if (!_dismissButton) {
        _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissButton setImage:[UIImage imageNamed:@"order_list_close"] forState:UIControlStateNormal];
    }
    return _dismissButton;
}
@end
