//
//  TPDPathPlanningBottomView.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDPathPlanningBottomView.h"
#import "UIImage+Gradient.h"

@interface TPDPathPlanningBottomView ()

@end

@implementation TPDPathPlanningBottomView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = TPWhiteColor;
        [self addSubview:self.planningLable];
        [self addSubview:self.navButton];
    }
    return self;
}

- (void)updateConstraints {
    [self.navButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-TPAdaptedWidth(12));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(TPAdaptedWidth(80));
        make.height.mas_equalTo(TPAdaptedHeight(34));
    }];
    
    [self.planningLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(TPAdaptedWidth(12));
        make.centerY.equalTo(self);
        make.right.lessThanOrEqualTo(self.navButton.mas_left).with.offset(-TPAdaptedWidth(12));
    }];
    [super updateConstraints];
}
#pragma mark - getter
- (UILabel *)planningLable {
    if (!_planningLable) {
        _planningLable = [[UILabel alloc] init];
        _planningLable.textColor = TPMainTextColor;
        _planningLable.font = TPAdaptedFontSize(15);
    }
    return _planningLable;
}
- (UIButton *)navButton {
    if (!_navButton) {
        _navButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_navButton setTitle:@"导航" forState:UIControlStateNormal];
        [_navButton setTitleColor:TPWhiteColor forState:UIControlStateNormal];
        UIImage *bgImage = [[UIImage createGradientImageWithSize:CGSizeMake(TPAdaptedWidth(80), TPAdaptedHeight(34)) startColor:TPGradientStartColor endColor:TPGradientEndColor] imageByRoundCornerRadius:TPAdaptedHeight(17)];
        [_navButton setBackgroundImage:bgImage forState:UIControlStateNormal];
    }
    return _navButton;
}
@end
