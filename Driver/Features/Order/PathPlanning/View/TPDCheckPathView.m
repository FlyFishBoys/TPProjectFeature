//
//  TPDCheckPathView.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCheckPathView.h"

@implementation TPDCheckPathView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = TPWhiteColor;
        [self addSubview:self.planningLable];
    }
    return self;
}

- (void)updateConstraints {
    
    [self.planningLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(TPAdaptedWidth(12));
        make.top.equalTo(self.mas_top).with.offset(TPAdaptedHeight(12));
        make.right.lessThanOrEqualTo(self.mas_right).with.offset(-TPAdaptedWidth(12));
        make.bottom.equalTo(self.mas_bottom).with.offset(-TPAdaptedHeight(12));
    }];
    [super updateConstraints];
}
#pragma mark - getter
- (UILabel *)planningLable {
    if (!_planningLable) {
        _planningLable = [[UILabel alloc] init];
        _planningLable.textColor = TPMainTextColor;
        _planningLable.font = TPAdaptedFontSize(15);
        _planningLable.numberOfLines = 0;
    }
    return _planningLable;
}

@end
