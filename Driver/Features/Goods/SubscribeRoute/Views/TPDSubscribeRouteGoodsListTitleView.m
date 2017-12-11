//
//  TPDSubscribeRouteGoodsListTitleView.m
//  TopjetPicking
//
//  Created by lish on 2017/9/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteGoodsListTitleView.h"

@interface TPDSubscribeRouteGoodsListTitleView()

@property (nonatomic , strong) UILabel *fromAddress;
@property (nonatomic , strong) UILabel *toAddress;
@property (nonatomic , strong) UIImageView *addressIcon;

@end

@implementation TPDSubscribeRouteGoodsListTitleView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
        [self setFrame];
    }
    return self;
}
- (void)addSubviews {
    [self addSubview:self.fromAddress];
    [self addSubview:self.toAddress];
    [self addSubview:self.addressIcon];
}
- (void)setFrame {
    
    [_addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    [_fromAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(_addressIcon.mas_left).offset(TPAdaptedWidth(-6));
        make.centerY.equalTo(self);
        
    }];
    
    [_toAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_addressIcon.mas_right).offset(TPAdaptedWidth(6));
        make.top.equalTo(_fromAddress.mas_top);
    
    }];
}

#pragma mark - Getters and Setters
- (UILabel *)fromAddress {
    if (!_fromAddress) {
        _fromAddress = [[UILabel alloc]init];
        _fromAddress.textColor = TPTitleTextColor;
        _fromAddress.font = TPBoldSystemFontSize(17);
        _fromAddress.preservesSuperviewLayoutMargins = YES;
        _fromAddress.text = @"出发";
    }
    return _fromAddress;
}
- (UILabel *)toAddress {
    if (!_toAddress) {
        _toAddress = [[UILabel alloc]init];
        _toAddress.textColor = TPTitleTextColor;
        _toAddress.font = TPBoldSystemFontSize(17);
        _toAddress.preservesSuperviewLayoutMargins = YES;
        _toAddress.text = @"到达";
        _toAddress.preservesSuperviewLayoutMargins = YES;
    }
    return _toAddress;
}
- (UIImageView *)addressIcon {
    
    if (!_addressIcon) {
        _addressIcon = [[UIImageView alloc]init];
        _addressIcon.image = [UIImage imageNamed:@"order_list_arrow"];
    }
    return _addressIcon;
    
}

- (void)setDepertCity:(NSString *)depertCity {
    
    _fromAddress.text = depertCity;
}

- (void)setDestinationCity:(NSString *)destinationCity {
    _toAddress.text = destinationCity;
}
@end
