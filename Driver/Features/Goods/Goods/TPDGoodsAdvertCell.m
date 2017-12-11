//
//  TPDGoodsAdvertCell.m
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsAdvertCell.h"
@interface TPDGoodsAdvertCell()
@property (nonatomic , strong) UIImageView *advertImage;

@end

@implementation TPDGoodsAdvertCell
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    
    return TPAdaptedHeight(100);
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubviews];
        [self setFrame];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            
            if ([self.delegate respondsToSelector:@selector(didClickGoodsAdvertCell:)]) {
                [self.delegate didClickGoodsAdvertCell:(TPGoodsListAdvertItemViewModel *)self.object];
            }
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)addSubviews{
    
    [self addSubview:self.advertImage];
}
- (void)setFrame{
    
    [self.advertImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

- (UIImageView *)advertImage {
    
    if (!_advertImage) {
        _advertImage = [[UIImageView alloc]init];
        _advertImage.backgroundColor = TPUNEnbleColor_LineColor;
        _advertImage.userInteractionEnabled = YES;
        
    }
    return _advertImage;
}

- (void)setObject:(TPGoodsListAdvertItemViewModel *)object {
    
    [super setObject:object];
    [_advertImage tp_setOriginalImageWithURL:[NSURL URLWithString:object.model.picture_url] md5Key:object.model.picture_key placeholderImage:[UIImage imageNamed:@"smart_find_goods_ad_image"]];
    self.delegate = object.target;
    
}

@end
