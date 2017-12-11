//
//  TPDListenOrderSetDestinationCell..m
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderSetDestinationCell.h"

@interface TPDListenOrderSetDestinationCell()

@property (nonatomic , strong) UIButton *selectBtn;
@property (nonatomic , strong) UILabel *address;
@property (nonatomic , strong) UIView *line;

@property (nonatomic , strong) UIImageView *arrow;
@end

@implementation TPDListenOrderSetDestinationCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
        [self setFrame];
        
    }
    return self;
}

- (void)addSubviews {
    
    [self addSubview:self.selectBtn];
    [self addSubview:self.address];
    [self addSubview:self.line];
    [self addSubview:self.arrow];
}
- (void)setFrame {
 
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.centerY.equalTo(self);
    }];
    
    [_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(46));
        make.centerY.equalTo(self);
    }];
    
    [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
    }];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(-12));
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.right.equalTo(self);
    }];
}

#pragma mark - System Delegate
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    return TPAdaptedHeight(48);
}

- (void)tapSelectBtn {
    
    if ([self.delegate respondsToSelector:@selector(ListenOrderSetPopCellTypeDidSelectBtn:cellViewModel:)]) {
        
        [self.delegate ListenOrderSetPopCellTypeDidSelectBtn:ListenOrderSetPopCell_SelectBtn cellViewModel:(TPDListenOrderSetDestinationViewModel *)self.object];
        
    }
    
}
#pragma mark - Getters and Setters

- (UILabel *)address {
    if (!_address) {
        _address = [[UILabel alloc]init];
        _address.textColor = TPTitleTextColor;
        _address.font = TPAdaptedFontSize(14);
        _address.text = @"上海 徐汇";
    }
    return _address;
}
- (UIView *)line {
    
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;
    
}

- (UIButton *)selectBtn {
    
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_normal"] forState:0];
        [_selectBtn addTarget:self action:@selector(tapSelectBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectBtn;
    
}
- (UIImageView *)arrow {
    if (!_arrow) {
        _arrow = [[UIImageView alloc]init];
        _arrow.image = [UIImage imageNamed:@"common_cell_arrow"];
    }
    return _arrow;
    
}


- (void)setObject:(TPDListenOrderSetDestinationViewModel *)object {
    [super setObject:object];
    
    self.address.text = object.cityName;
    object.isSelectCity ? [_selectBtn setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_selected"] forState:0]: [self.selectBtn setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_normal"] forState:0];
     _arrow.hidden = [object.model.type isEqualToString:@"3"] ? NO : YES;
    
    if ([object.cityName isEqualToString:@"手动选择城市"]) {
       self.delegate = nil;
    }else{
      self.delegate = object.target;
    }
    
}

@end
