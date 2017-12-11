//
//  TPDListenOrderHeaderView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderHeaderView.h"
#import "UIButton+ResetContent.h"
#import "TPDArrowsButton.h"

static NSString * const TPDSmartFindGoodsHeadView_Button_Image = @"smart_find_goods_arrows_down_nor";
static NSString * const TPDSmartFindGoodsHeadView_Button_Image_Selsected = @"smart_find_goods_arrows_up_highlight";
@interface TPDListenOrderHeaderView()

@property (nonatomic , strong) TPDArrowsButton *startAddressBtn;

@property (nonatomic , strong) UIImageView *addressIcon;

@property (nonatomic , strong) UIButton *endAddressBtn;

@property (nonatomic , strong) UIButton *setBtn;//设置btn

@property (nonatomic , strong) UIView *line;

@end


@implementation TPDListenOrderHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    [self addSubview:self.startAddressBtn];
    [self addSubview:self.endAddressBtn];
    [self addSubview:self.addressIcon];
    [self addSubview:self.setBtn];
    [self addSubview:self.line];
}
- (void)layoutSubviews {
    
    [super layoutSubviews];

    [_startAddressBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.top.equalTo(self).offset(TPAdaptedHeight(11));
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-13));
        make.width.mas_equalTo([_startAddressBtn.titleLabel.text widthForFont:TPAdaptedFontSize(14)]+TPAdaptedWidth(20));
    }];
    
    [_addressIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.startAddressBtn.mas_right).offset(TPAdaptedWidth(6));
        make.top.equalTo(self).offset(TPAdaptedHeight(17));
    }];
    
    [_setBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(TPAdaptedWidth(48));
        make.height.mas_equalTo(TPAdaptedHeight(24));
    }];
    
    
    CGFloat endBtnWidth = [_destinationCitys isNotBlank] ? [_destinationCitys widthForFont:TPAdaptedFontSize(15)] :[@"到达"  widthForFont:TPAdaptedFontSize(15)];
    [_endAddressBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressIcon.mas_right).offset(6);
        make.right.lessThanOrEqualTo(_setBtn.mas_left).with.offset(-5);
        make.top.equalTo(self).offset(TPAdaptedHeight(11));
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-13));
        make.width.mas_equalTo(endBtnWidth);
    }];
    
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_offset(0.5);
        make.width.mas_equalTo(TPScreenWidth);
    }];
    
    
    [_startAddressBtn horizontalCenterTitleAndImage];
}


- (void)tapSetBtn:(UIButton *)tapSetBtn {
  
    if (self.tapSetBtnBlock) {
        self.tapSetBtnBlock();
    }
}

#pragma mark - Getters and Setters
- (UIButton *)startAddressBtn {
    
    if (!_startAddressBtn) {
        _startAddressBtn = [[TPDArrowsButton alloc]init];
         [_startAddressBtn setTitle:@"无法获取" forState:0];
        _startAddressBtn.titleLabel.font = TPAdaptedFontSize(14);
        @weakify(self);
       _startAddressBtn.tapBlock = ^(UIButton *btn) {
           @strongify(self);
           btn.selected = NO;
           if (self.tapDepartBtnBlock) {
               self.tapDepartBtnBlock();
           }
       };

    }
    return _startAddressBtn;
    
}
- (UIButton *)endAddressBtn {
    
    if (!_endAddressBtn) {
        _endAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endAddressBtn setTitle:@"到达" forState:0];
        _endAddressBtn.preservesSuperviewLayoutMargins = YES;
        [_endAddressBtn setTitleColor:UIColorHex(#666666) forState:0];
        _endAddressBtn.titleLabel.font = TPAdaptedFontSize(14);
        _endAddressBtn.titleLabel.textAlignment = NSTextAlignmentLeft;

    }
    return _endAddressBtn;
}

- (UIButton *)setBtn {
    
    if (!_setBtn) {
        _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
         [_setBtn addTarget:self action:@selector(tapSetBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_setBtn setTitle:@"设置" forState:0];
        [_setBtn setTitleColor:TPMainColor forState:0];
        _setBtn.layer.masksToBounds = YES;
        _setBtn.layer.cornerRadius = 5;
        _setBtn.layer.borderColor = TPMainColor.CGColor;
        _setBtn.layer.borderWidth = 1;
        _setBtn.titleLabel.font = TPAdaptedFontSize(14);
    }
    return _setBtn;
}
- (UIImageView *)addressIcon {
    
    if (!_addressIcon) {
        _addressIcon = [[UIImageView alloc]init];
        _addressIcon.image = [UIImage imageNamed:@"order_list_arrow"];
    }
    return _addressIcon;
}
- (UIView *)line {
    
    if (!_line ) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;
}

- (void)setDepartCity:(NSString *)departCity {
    
    _departCity = departCity;
 
    if ([_departCity isNotBlank]) {
        [_startAddressBtn setTitle:_departCity forState:0];
    }else {
        [_startAddressBtn setTitle:@"无法获取" forState:0];
      
    }
    [_startAddressBtn setTitleColor:TPTitleTextColor forState:0];
    [_startAddressBtn horizontalCenterTitleAndImage];
    CGFloat startBtnWidth = [_departCity isNotBlank] ? [_departCity widthForFont:TPAdaptedFontSize(14)]+TPAdaptedWidth(20) :[@"无法获取"  widthForFont:TPAdaptedFontSize(14)]+TPAdaptedWidth(20);
    [_startAddressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(startBtnWidth);
    }];
    
}
- (void)setDestinationCitys:(NSString *)destinationCitys {
    
    if ([destinationCitys isNotBlank]) {
        _destinationCitys = destinationCitys;
        [_endAddressBtn setTitle:_destinationCitys forState:0];
        [_endAddressBtn setTitleColor:TPTitleTextColor forState:0];
         CGFloat endBtnWidth = [_destinationCitys isNotBlank] ? [_destinationCitys widthForFont:TPAdaptedFontSize(15)] :[@"到达"  widthForFont:TPAdaptedFontSize(15)];
        [_endAddressBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(endBtnWidth);
        }];
    }else{
        [_endAddressBtn setTitle:@"到达" forState:0];

    }
}

@end
