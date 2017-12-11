//
//  TPDArrowsButton.m
//  TopjetPicking
//
//  Created by lish on 2017/9/1.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDArrowsButton.h"
#import "UIButton+ResetContent.h"
@interface TPDArrowsButton()




@end

@implementation TPDArrowsButton

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        [self setImage:[UIImage imageNamed:@"smart_find_goods_arrows_down_nor"] forState:0];
        [self setImage:[UIImage imageNamed:@"smart_find_goods_arrows_up_highlight"] forState:UIControlStateSelected];
        [self setTitleColor:TPMainTextColor  forState:0];
        [self setTitleColor:TPTitleTextColor forState:UIControlStateSelected];
        self.titleLabel.font = TPAdaptedFontSize(14);
        [self addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
      
        
    }
    return self;
}

- (void)tapBtn:(UIButton *)tapBtn {
    tapBtn.selected = !tapBtn.selected;

    if (self.tapBlock) {
        self.tapBlock(tapBtn);
    }
}


@end
