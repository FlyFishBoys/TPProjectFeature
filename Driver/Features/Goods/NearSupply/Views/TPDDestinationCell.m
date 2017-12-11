//
//  TPDDestinationCell.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDDestinationCell.h"

#import "TPDConstantCityModel.h"

#import "TPDDestinationViewModel.h"

@interface TPDDestinationCell ()

@property (nonatomic, strong) UIButton *iconImageBtn;

@property (nonatomic, strong) UILabel *cityLabel;

@end

@implementation TPDDestinationCell


- (UIButton *)iconImageBtn
{
    if (!_iconImageBtn) {
        _iconImageBtn = [UIButton buttonWithType:0];
        [_iconImageBtn setImage:[UIImage imageNamed:@"neargoods_icon_uncheck_nor"] forState:UIControlStateNormal];
        [_iconImageBtn setImage:[UIImage imageNamed:@"neargoods_icon_uncheck_sel_blue"] forState:UIControlStateSelected];
        [_iconImageBtn addTarget:self action:@selector(selectIconBtn:) forControlEvents:UIControlEventTouchUpInside];
        //        [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"neargoods_icon_uncheck_nor"] highlightedImage:[UIImage imageNamed:@"neargoods_icon_uncheck_sel_blue"]];
    }
    return _iconImageBtn;
}

- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] init];
        _cityLabel.font = [UIFont systemFontOfSize:15.0];
        _cityLabel.textColor = UIColorHex(222222);
    }
    return _cityLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubviews];
        [self setFrame];

        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)addSubviews
{
    [self.contentView addSubview:self.iconImageBtn];
    [self.contentView addSubview:self.cityLabel];

}

- (void)setFrame
{
    [self.iconImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(22));
        make.left.equalTo(@(12));
        make.top.equalTo(@(13));
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(18));
        make.left.equalTo(@(46));
        make.top.equalTo(@(14));
    }];
}


- (void)selectIconBtn:(id)sender
{
    self.iconImageBtn.selected = !self.iconImageBtn.selected;
    if ([self.delegate respondsToSelector:@selector(selectIconBtn:)]) {
        [self.delegate selectIconBtn:self.object];
    }
}

- (void)setObject:(TPDestinationItemViewModel *)object {
    
    [super setObject:object];
    self.delegate = object.target;

    self.cityLabel.text = object.business_line_city;
    self.iconImageBtn.selected = object.isSelectCell;
    
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    
    return 48.0;
}
@end
