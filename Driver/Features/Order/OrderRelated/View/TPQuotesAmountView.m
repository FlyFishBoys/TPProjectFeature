//
//  TPQuotesAmountView.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPQuotesAmountView.h"

@interface TPQuotesAmountView ()
@property (nonatomic, strong) UILabel * amountLabel;

@end

@implementation TPQuotesAmountView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = TPWhiteColor;
        _amountLabel = [[UILabel alloc]init];
        _amountLabel.textColor = TPMainTextColor;
        _amountLabel.font = TPAdaptedFontSize(13);
        _amountLabel.textAlignment = NSTextAlignmentCenter;

        [self addSubview:_amountLabel];
        [_amountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    _attributedText = attributedText;
    _amountLabel.attributedText = attributedText;
}


@end
