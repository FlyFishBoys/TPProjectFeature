//
//  TPDGoodsFontContentView.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/9/27.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsFontContentView.h"
#import "TPDGoodsConst.h"

@interface TPDGoodsFontContentView ()

@property (nonatomic,strong) UILabel * departLable;

@property (nonatomic,strong) UIImageView * arrowImageView;

@property (nonatomic,strong) UILabel * destinationLable;

@property (nonatomic,strong) UILabel * timeLable;

@property (nonatomic,strong) UILabel * goodsInfoLable;

@property (nonatomic,strong) UIImageView * iconImageView;

@property (nonatomic,strong) UILabel * nameLable;

@property (nonatomic,strong) UIImageView * starImageView;

@property (nonatomic,strong) UIImageView * bookImageView;

@property (nonatomic,strong) UIImageView * callImageView;

@end

@implementation TPDGoodsFontContentView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}
- (void)addSubviews {
    [self addSubview:self.departLable];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.destinationLable];
    [self addSubview:self.timeLable];
    [self addSubview:self.goodsInfoLable];
    [self addSubview:self.iconImageView];
    [self addSubview:self.nameLable];
    [self addSubview:self.starImageView];
    [self addSubview:self.bookImageView];
    [self addSubview:self.callImageView];
}
- (void)addConstraints {
    [self.departLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(TPAdaptedWidth(12));
        make.top.equalTo(self.mas_top).with.offset(TPAdaptedHeight(10));
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.departLable);
        make.left.equalTo(self.departLable.mas_right).with.offset(TPAdaptedWidth(4));
    }];
    
    [self.destinationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.arrowImageView.mas_right).with.offset(TPAdaptedWidth(4));
        make.centerY.equalTo(self.departLable);
    }];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-TPAdaptedWidth(12));
        make.centerY.equalTo(self.departLable);
    }];
    
    [self.goodsInfoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.departLable.mas_bottom).with.offset(TPAdaptedHeight(4));
        make.left.equalTo(self.departLable);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-TPAdaptedHeight(8));
        make.left.equalTo(self.departLable);
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).with.offset(TPAdaptedWidth(8));
        make.top.equalTo(self.iconImageView);
    }];
    
    [self.starImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLable);
        make.bottom.equalTo(self.iconImageView);
    }];
    
    [self.callImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.timeLable);
        make.bottom.equalTo(self.iconImageView);
    }];
    
    [self.bookImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.callImageView.mas_left).with.offset(-TPAdaptedWidth(16));
        make.bottom.equalTo(self.iconImageView);
    }];
}
- (void)refresh {
    _departLable.font = TPBoldSystemFontSize(GoodsAddressFontSize);
    _destinationLable.font = TPBoldSystemFontSize(GoodsAddressFontSize);
    _timeLable.font = TPAdaptedFontSize(GoodsTimeFontSize);
    _goodsInfoLable.font = TPAdaptedFontSize(GoodsGoodsInfoFontSize);
}
#pragma mark - getter
- (UILabel *)departLable {
    if (!_departLable) {
        _departLable = [[UILabel alloc] init];
        _departLable.text = @"上海 徐汇区";
        _departLable.textColor = TPTitleTextColor;
        _departLable.font = TPBoldSystemFontSize(GoodsAddressFontSize);
    }
    return _departLable;
}
- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"order_list_arrow"];
    }
    return _arrowImageView;
}
- (UILabel *)destinationLable {
    if (!_destinationLable) {
        _destinationLable = [[UILabel alloc] init];
        _destinationLable.text = @"南京 鼓楼区";
        _destinationLable.textColor = TPTitleTextColor;
        _destinationLable.font = TPBoldSystemFontSize(GoodsAddressFontSize);
    }
    return _destinationLable;
}
- (UILabel *)timeLable {
    if (!_timeLable) {
        _timeLable = [[UILabel alloc] init];
        _timeLable.text = @"4分钟前";
        _timeLable.textColor = TPMainTextColor;
        _timeLable.font = TPAdaptedFontSize(GoodsTimeFontSize);
    }
    return _timeLable;
}
- (UILabel *)goodsInfoLable {
    if (!_goodsInfoLable) {
        _goodsInfoLable = [[UILabel alloc] init];
        _goodsInfoLable.text = @"普货30-50平方 10-18米高栏车";
        _goodsInfoLable.textColor = TPMainTextColor;
        _goodsInfoLable.font = TPAdaptedFontSize(GoodsGoodsInfoFontSize);
    }
    return _goodsInfoLable;
}
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"goods_icon_car"];
    }
    return _iconImageView;
}
- (UILabel *)nameLable {
    if (!_nameLable) {
        _nameLable = [[UILabel alloc] init];
        _nameLable.text = @"王蒙飞";
        _nameLable.textColor = TPTitleTextColor;
        _nameLable.font = TPAdaptedFontSize(13);
    }
    return _nameLable;
}
- (UIImageView *)starImageView {
    if (!_starImageView) {
        _starImageView = [[UIImageView alloc] init];
        _starImageView.image = [UIImage imageNamed:@"icon_star_yellow_8"];
    }
    return _starImageView;
}
- (UIImageView *)bookImageView {
    if (!_bookImageView) {
        _bookImageView = [[UIImageView alloc] init];
        _bookImageView.image = [UIImage imageNamed:@"goods_icon_jie_nor"];
    }
    return _bookImageView;
}
- (UIImageView *)callImageView {
    if (!_callImageView) {
        _callImageView = [[UIImageView alloc] init];
        _callImageView.image = [UIImage imageNamed:@"order_icon_call"];
    }
    return _callImageView;
}
@end
