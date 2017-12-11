//
//  TPDSubscribeRouteCell.m
//  TopjetPicking
//
//  Created by lish on 2017/8/29.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteCell.h"
@interface TPDSubscribeRouteCell()

@property (nonatomic , strong) UILabel *startAddress;//开始地址
@property (nonatomic , strong) UILabel *endAddress;//结束地址
@property (nonatomic , strong) UILabel *vehicleTypeLabel;//车型
@property (nonatomic , strong) UILabel *badgeLabel;//角标
@property (nonatomic , strong) UIImageView *arrowsIcon;//图标

@property (nonatomic , strong) UIButton *editBtn;
@property (nonatomic , strong) UIView *line;
@property (nonatomic , assign) BOOL isEdit;

@end

@implementation TPDSubscribeRouteCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        
    }
    return self;
    
}

- (void)addSubviews {
    
    [self addSubview:self.startAddress];
    [self addSubview:self.endAddress];
    [self addSubview:self.arrowsIcon];
    [self addSubview:self.vehicleTypeLabel];
    [self addSubview:self.badgeLabel];
    [self addSubview:self.line];
    [self addSubview:self.editBtn];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGFloat leftMargin;
    CGFloat edithWidth;
    if (_isEdit) {
        leftMargin = 52;
        edithWidth = 22;
    }else{
        leftMargin = 12;
        edithWidth = 0;
    }
    
    [_editBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(TPAdaptedWidth(15));
        make.centerY.equalTo(self);
    }];
    
    [_startAddress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(leftMargin));
        make.centerY.equalTo(self);
        
    }];
    
    [_arrowsIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_startAddress.mas_right).offset(TPAdaptedWidth(6));
        make.centerY.equalTo(self);

        
    }];
    [_endAddress mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.arrowsIcon.mas_right).offset(TPAdaptedWidth(6));
        make.centerY.equalTo(self);
        
    }];
    
    [_badgeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
        make.height.mas_greaterThanOrEqualTo(TPAdaptedHeight(16));
        if (_item.supply_of_goods_count.intValue > 9 ) {
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(24));
  
        }else {
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(16));

        }
    }];
    
    [_vehicleTypeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.endAddress.mas_right).offset(TPAdaptedWidth(6));
        make.centerY.equalTo(self);
    }];
    
    
    [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.startAddress.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(-0.5);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(self);
    }];
}

#pragma mark - Custom Delegate
+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    return TPAdaptedHeight(48);
}

#pragma mark - Getters and Setters
- (UILabel *)startAddress {
    if (!_startAddress) {
        _startAddress = [[UILabel alloc]init];
        _startAddress.textColor = TPTitleTextColor;
        _startAddress.font = TPSystemFontSize(15);
    }
    return _startAddress;
}

- (UILabel *)endAddress {
    if (!_endAddress) {
        _endAddress = [[UILabel alloc]init];
        _endAddress.textColor = TPTitleTextColor;
        _endAddress.font = TPSystemFontSize(15);
    }
    return _endAddress;
}

- (UILabel *)vehicleTypeLabel {
    if (!_vehicleTypeLabel) {
        _vehicleTypeLabel = [[UILabel alloc]init];
        _vehicleTypeLabel.textColor = TPTitleTextColor;
        _vehicleTypeLabel.font = TPSystemFontSize(15);
    }
    return _vehicleTypeLabel;
}

- (UILabel *)badgeLabel {
    
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.font = TPSystemFontSize(11);
        _badgeLabel.textColor = TPWhiteColor;
        _badgeLabel.backgroundColor = UIColorHex(#FF0000);
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.preservesSuperviewLayoutMargins = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}
- (UIImageView *)arrowsIcon {
    
    if (!_arrowsIcon) {
        _arrowsIcon = [[UIImageView alloc]init];
        _arrowsIcon.image = [UIImage imageNamed:@"order_list_arrow"];
        
        
    }
    return _arrowsIcon;
    
}
- (UIView *)line {
    
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;
    
}

- (UIButton *)editBtn {
    
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_normal"] forState:0];
         [_editBtn setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_selected"] forState:UIControlStateSelected];
        
    }
    return _editBtn;
    
}


- (void)setObject:(TPDSubscribeRouteCellViewModel *)item {
    
    [super setObject:item];
    _item = item;
    
    _startAddress.text = _item.depart_city;
    _endAddress.text = _item.destination_city;
    _badgeLabel.text = _item.supply_of_goods_count;
    if (_item.supply_of_goods_count.intValue > 9 ) {
        [_badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(24));
        }];
       _badgeLabel.layer .cornerRadius = TPAdaptedHeight(8);
    }else {
        [_badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
             make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(16));
        }];
       _badgeLabel.layer .cornerRadius = TPAdaptedWidth(14)/2;
    }
   
    _vehicleTypeLabel.text = _item.truck_detail;
    self.isEdit = _item.is_edit;
    _editBtn.selected = _item.is_select;
    if (_item.supply_of_goods_count.intValue == 0) {
        _badgeLabel.hidden = YES;
    }
    
}
- (void)setIsEdit:(BOOL)isEdit {
    
    _isEdit = isEdit;
    _editBtn.hidden = !_isEdit;
    _badgeLabel.hidden = _isEdit;
}
@end
