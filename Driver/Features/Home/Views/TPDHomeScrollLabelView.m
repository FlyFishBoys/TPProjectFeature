//
//  TPHomeMiddleView.m
//  TopjetPicking
//
//  Created by leeshuangai on 2017/8/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeScrollLabelView.h"
#import "TXScrollLabelView.h"

@interface TPDHomeScrollLabelView()<TXScrollLabelViewDelegate>

@property (nonatomic , strong) UIImageView *icon;
@property (nonatomic , strong) TXScrollLabelView *scrollLabelView;
@property (nonatomic , strong) UIView *line;


@end
@implementation TPDHomeScrollLabelView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = TPWhiteColor;
        [self addSubview:self.icon];
        [self addSubview:self.line];
        [self setFrame];
    }
    return self;
}


- (void)setFrame {
    
    UIImage *iconImage = [UIImage imageNamed:@"homepage_icon_top"];
    [_icon mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.width.mas_equalTo(iconImage.size.width);
        make.height.mas_equalTo(iconImage.size.height);
        make.centerY.equalTo(self);
    }];
    
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(TPAdaptedHeight(27));
        make.centerY.equalTo(_icon);
        make.left.equalTo(_icon.mas_right).offset(TPAdaptedWidth(6));
        
    }];
    
    
    [_scrollLabelView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_line.mas_right).offset(TPAdaptedWidth(2));
        make.centerY.equalTo(self.icon);
        make.width.mas_equalTo(self.frame.size.width-TPAdaptedWidth(68));
        make.height.mas_equalTo(TPAdaptedHeight(30));
    }];
 
}


#pragma mark - Custom Delegate
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    if (self.tapScrollLabelHander) {
        self.tapScrollLabelHander(index);
    }
}


#pragma mark - Getters and Setters
- (TXScrollLabelView *)scrollLabelView {
    
    if (!_scrollLabelView) {
        
        _scrollLabelView = [TXScrollLabelView scrollWithTextArray:self.scrollTextArray type:TXScrollLabelViewTypeFlipNoRepeat velocity:5 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
        /** Step3: 设置代理进行回调 */
        _scrollLabelView.scrollLabelViewDelegate = self;
        
        /** Step4: 布局(Required) */
        _scrollLabelView.frame = CGRectMake(TPAdaptedWidth(50) , TPAdaptedHeight(10), self.frame.size.width-TPAdaptedWidth(68), TPAdaptedHeight(30));
        
        _scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
        _scrollLabelView.scrollSpace = 10;
        _scrollLabelView.font = TPAdaptedFontSize(13);
        _scrollLabelView.backgroundColor = TPWhiteColor;
        _scrollLabelView.layer.cornerRadius = 5;
        _scrollLabelView.scrollTitleColor = TPTitleTextColor;
        _scrollLabelView.textAlignment = NSTextAlignmentLeft;
        [_scrollLabelView beginScrolling];
        
    }
    return _scrollLabelView;
    
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithImage:[UIImage  imageNamed:@"homepage_icon_top"]];
       
    }
    
    return _icon;
}

- (UIView *)line {
    
    if (!_line) {
        
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;
}

- (void)setScrollTextArray:(NSArray *)scrollTextArray {
    
    _scrollTextArray = scrollTextArray;
     [self addSubview:self.scrollLabelView];
}
@end
