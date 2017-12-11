//
//  TPHomeMiddleCell.m
//  TopjetPicking
//
//  Created by leeshuangai on 2017/9/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeMiddleCell.h"
#define LEFTBTN_TITLE @"我的车队"
#define RIGHTBTN_TITLE @"积分商城"
@interface TPDHomeMiddleCell()

@property (nonatomic , strong) UIButton *leftBtn;
@property (nonatomic , strong) UIButton *rightBtn;

@end
@implementation TPDHomeMiddleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
          self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
        [self setFrame];
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [_leftBtn addGradientWithStartColor:UIColorHex(00c649) endColor:UIColorHex(71dc62)];
    [_rightBtn addGradientWithStartColor:UIColorHex(646fff) endColor:UIColorHex(729dff)];
    
}
- (void)setFrame {
  
    
    
    [_leftBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-10));
        make.height.mas_equalTo(TPAdaptedHeight(56));
        
    }];
    
    [_rightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.bottom.equalTo(self.leftBtn.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(56));
        
    }];

}
#pragma mark - Event Response
- (void)tapLeftBtn:(UIButton *)tapLeftBtn{
    
    if (self.tapLeftBtnCompleteBlock) {
        self.tapLeftBtnCompleteBlock(tapLeftBtn);
    }
    
}
- (void)tapRightBtn:(UIButton *)tapRightBtn{
    
    if (self.tapRightBtnCompleteBlock) {
        self.tapRightBtnCompleteBlock(tapRightBtn);
    }
    
}



- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn.layer setLayerShadow:UIColorHex(#5a66f6) offset:CGSizeMake(0, 2) radius:5];
        _rightBtn.layer.shadowOpacity = .5f;
        _rightBtn.layer.cornerRadius = 3;
        [_rightBtn addTarget:self action:@selector(tapRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn .titleLabel.font = TPAdaptedFontSize(20);
        [_rightBtn setTitle:RIGHTBTN_TITLE forState:0];
        [_rightBtn setTitleColor:UIColorHex(FFFFFF) forState:0];
        _rightBtn.layer.masksToBounds = YES;
        _rightBtn.layer.cornerRadius = 4;
    }
    return _rightBtn;
}

- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn addTarget:self action:@selector(tapLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_leftBtn.layer setLayerShadow:UIColorHex(05c74a) offset:CGSizeMake(0, 2) radius:5];
        _leftBtn.layer.shadowOpacity = .5f;
        _leftBtn.layer.cornerRadius = 3;
        _leftBtn.titleLabel.font = TPAdaptedFontSize(20);
        [_leftBtn setTitle:LEFTBTN_TITLE forState:0];
        [_leftBtn setTitleColor:UIColorHex(FFFFFF) forState:0];
        
        _leftBtn.layer.masksToBounds = YES;
        _leftBtn.layer.cornerRadius = 4;
    }
    return _leftBtn;
}

@end
