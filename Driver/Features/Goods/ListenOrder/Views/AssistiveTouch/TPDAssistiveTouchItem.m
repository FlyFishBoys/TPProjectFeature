//
//  TPDAssistiveTouchItem.m
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/27.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import "TPDAssistiveTouchItem.h"
#import "UIButton+ResetContent.h"
@implementation TPDAssistiveTouchItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

           
        self.titleLabel.font = TPAdaptedFontSize(15);
        CGFloat width = [@"开启听单" widthForFont:TPAdaptedFontSize(15)];
        self.titleEdgeInsets = UIEdgeInsetsMake(TPAdaptedHeight(44),- width+TPAdaptedWidth(2), 0, -TPAdaptedWidth(13));
        self.imageEdgeInsets = UIEdgeInsetsMake(0, TPAdaptedWidth(8),TPAdaptedHeight(30), TPAdaptedWidth(8));
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addTarget:self action:@selector(tapBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.titleLabel.frame = CGRectMake(0, 0, TPAdaptedWidth(60), TPAdaptedHeight(20));

    }
    return self;
    
}
+ (instancetype)creatItemWithFrame:(CGRect)frame {
    
    return [[self alloc]initWithFrame:frame];
}

#pragma mark - Event Response
- (void)tapBtn:(UIButton *)tapBtn {
    if (self.tapBlock) {
        self.tapBlock(tapBtn);
    }
}

#pragma mark - Getters and Setters
- (void)setBtnTag:(NSInteger)btnTag{
    _btnTag = btnTag;
    switch (btnTag) {
        case 51:
            [self setImage:[UIImage imageNamed:@"assistiveTouch_content_item_listen_order_on"] forState:0];
             [self setTitle:@"开启听单" forState:0];
            break;
        case 52:
            [self setImage:[UIImage imageNamed:@"assistiveTouch_content_item_set_route"] forState:0];
            [self setTitle:@"设置路线" forState:0];
            break;
            
        case 53:
            [self setImage:[UIImage imageNamed:@"assistiveTouch_content_item_listen_order_off"] forState:0];
            [self setTitle:@"关闭听单" forState:0];
            break;
            
    }
    
}
@end
