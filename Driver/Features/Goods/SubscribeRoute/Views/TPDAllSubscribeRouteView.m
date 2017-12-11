//
//  TPDAllSubscribeRouteView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAllSubscribeRouteView.h"
@interface TPDAllSubscribeRouteView()

@property (nonatomic , strong) UILabel *allSubscribeRoute;//全部订阅路线
@property (nonatomic , strong) UILabel *badgeLabel;//角标
@property (nonatomic , strong) UIView *line;

@end

@implementation TPDAllSubscribeRouteView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        [self setFrame];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (void)addSubviews {
    
    [self addSubview:self.allSubscribeRoute];
    [self addSubview:self.badgeLabel];
    [self addSubview:self.line];
}
- (void)setFrame {
   
    [_allSubscribeRoute mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.centerY.equalTo(self);
        
    }];

    [_badgeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
        make.height.mas_greaterThanOrEqualTo(TPAdaptedHeight(16));
     
        if (_badge.intValue > 9 ) {
            make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(24));
            
        }else {
            make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(16));
            
        }

    }];
    
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.bottom.equalTo(self.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(self);
    }];

    
}

- (void)tap {
    if (self.tapAllSubscribeRouteView) {
        self.tapAllSubscribeRouteView();
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
- (UILabel *)badgeLabel {
    
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.font = TPSystemFontSize(11);
        _badgeLabel.textColor = TPWhiteColor;
        _badgeLabel.backgroundColor = UIColorHex(#FF0000);
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.preservesSuperviewLayoutMargins = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}
- (UILabel *)allSubscribeRoute {
    if (!_allSubscribeRoute) {
        _allSubscribeRoute = [[UILabel alloc]init];
        _allSubscribeRoute.textColor = TPTitleTextColor;
        _allSubscribeRoute.font = TPSystemFontSize(15);
        _allSubscribeRoute.text = @"全部路线";
        
    }
    return _allSubscribeRoute;
}
- (void)setBadge:(NSString *)badge {
    
    _badge = badge;
    _badgeLabel.text = _badge;
    if (_badge.intValue > 9 ) {
        [_badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(24));
        }];
        _badgeLabel.layer .cornerRadius = TPAdaptedHeight(8);
    }else {
        [_badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(16));
        }];
        _badgeLabel.layer .cornerRadius = TPAdaptedWidth(14)/2;
    }
    if (_badge.intValue == 0) {
        _badgeLabel.hidden = YES;
    }
    
}


@end
