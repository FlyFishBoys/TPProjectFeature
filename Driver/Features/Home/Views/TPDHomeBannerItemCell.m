//
//  TPHomeBannerViewCell.m
//  TopjetPicking
//
//  Created by lish on 2017/8/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeBannerItemCell.h"

@interface TPDHomeBannerItemCell ()
@property (nonatomic , strong) UIImageView *bannerImageView;
@end

@implementation TPDHomeBannerItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addBannerImg];
    }
    return self;
}

- (void)addBannerImg {
    
    self.bannerImageView = [[UIImageView alloc]init];
    self.bannerImageView .backgroundColor = TPPlaceholderColor;
    [self addSubview:self.bannerImageView ];
    
    
}
- (void)setModel:(TPAdvertModel *)model{
    _model = model;
    if ([_model.picture_url isEqualToString:@"homepage_banner"]) {
        self.bannerImageView.image = [UIImage imageNamed:@"homepage_banner"];
        return;
    }
    [self.bannerImageView tp_setOriginalImageWithURL:[NSURL URLWithString:_model.picture_url]  md5Key:_model.picture_key placeholderImage:[UIImage imageNamed:@"homepage_banner"]];
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.bannerImageView.frame = self.bounds;
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
    [self.layer setLayerShadow:TPTitleTextColor offset:CGSizeMake(0, 1.5) radius:10];
    self.layer.shadowOpacity = 0.2;
    
}
@end
