//
//  TPFuctionCollectionCell.m
//  TopjetPicking
//
//  Created by lish on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeFuctionCollectionCell.h"
#import "UIImage+Gradient.h"
@interface TPDHomeFuctionCollectionCell()

@property (nonatomic , strong) UIImageView *fuctionImage;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UILabel *detailsLabel;
@property (nonatomic , strong) UIView *rightLine;//右面线
@property (nonatomic , strong) UIView *bottomLine;//下面线

@end

@implementation TPDHomeFuctionCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = TPWhiteColor;
        [self addSubview:self.fuctionImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailsLabel];
        [self addSubview:self.rightLine];
        [self addSubview:self.bottomLine];
        
    }
    return self;
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
 
    [_fuctionImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(15));
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(TPScale(45));        
    }];
    

    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_fuctionImage.mas_right).offset(TPAdaptedWidth(12));
        make.top.equalTo(self.mas_top).offset(TPAdaptedHeight(18));
        make.right.mas_lessThanOrEqualTo(self.mas_right).offset(-12);
    }];
    
    [_detailsLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleLabel.mas_bottom).offset(TPAdaptedHeight(10));
        make.left.equalTo(_titleLabel.mas_left);
        make.right.mas_lessThanOrEqualTo(self.mas_right).offset(-12);
    }];
    
}

#pragma mark - Getters and Setters
- (UILabel *)detailsLabel
{
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] init];
        _detailsLabel.textColor = UIColorHex(999999);
        _detailsLabel.font =TPSystemFontSize(12);
        _detailsLabel.textAlignment = NSTextAlignmentLeft;
       // _detailsLabel.text = @"熟车建议更靠谱";
        _detailsLabel.preservesSuperviewLayoutMargins = YES;
    }
    return _detailsLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TPTitleTextColor;
        _titleLabel.font =TPSystemFontSize(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        //_titleLabel.text = @"我的熟车";
        _titleLabel.preservesSuperviewLayoutMargins = YES;
    }
    return _titleLabel;
}

- (UIImageView *)fuctionImage
{
    if (!_fuctionImage) {
        _fuctionImage = [[UIImageView alloc] init];
        //_fuctionImage.backgroundColor = TPPlaceholderColor;
    }
    return _fuctionImage;
}

- (UIView *)rightLine {
    
    if (!_rightLine) {
        
        _rightLine = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-1, 0, 0.3,self.frame.size.height - 0.3)];
        _rightLine.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _rightLine;
}

- (UIView *)bottomLine {
    
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height- 0.3, self.frame.size.width,0.3)];
        _bottomLine.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _bottomLine;
}

- (void)setModel:(TPDHomeFuctionItemModel *)model {
    
    if (_model != model) {
        _model = model;
    }
    
    _titleLabel.text = _model.title;
    _detailsLabel.text = _model.content;
    if ([model.icon_url isNotBlank]) {
      [_fuctionImage tp_setOriginalImageWithURL:[NSURL URLWithString:_model.icon_url] md5Key:_model.icon_key placeholderImage:[UIImage createGradientImageWithSize:CGSizeMake(TPScale(45), TPScale(45)) startColor:TPPlaceholderColor endColor:TPPlaceholderColor]];
    }else {
        _fuctionImage.image = [UIImage imageNamed:_model.icon_image];
    }
    
}
@end



