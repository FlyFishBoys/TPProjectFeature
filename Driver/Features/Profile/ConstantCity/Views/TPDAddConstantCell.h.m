//
//  TPDAddConstantCell.m
//  TopjetPicking
//
//  Created by lish on 2017/8/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddConstantCell.h"
@interface TPDAddConstantCell()

@property (nonatomic , strong) UIImageView *locationIcon;

@property (nonatomic , strong) UILabel *adressLabel;

@property (nonatomic , strong) UIImageView *rightBtn;

@property (nonatomic , strong) UIImageView *deleteBtn;

@property (nonatomic , strong) UIView *line;

@end


@implementation TPDAddConstantCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.backgroundColor = TPWhiteColor;
        [self addSubview:self.locationIcon];
        [self addSubview:self.adressLabel];
        [self addSubview:self.rightBtn];
        [self addSubview:self.deleteBtn];
        [self addSubview:self.line];
        [self setFrame];
    }
    return self;
    
}

- (void)setFrame {
  
    [_locationIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(14));
        make.centerY.equalTo(self);
    }];
    
   
    [_rightBtn  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
    }];
    
    [_deleteBtn  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-16));
        make.centerY.equalTo(self);
    }];
    
    [_adressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_locationIcon.mas_right).offset(TPAdaptedWidth(12));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(TPAdaptedWidth(232));
        make.height.mas_equalTo(TPAdaptedHeight(20));
    }];
    
      [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
          make.height.mas_equalTo(0.5);
          make.left.equalTo(self.adressLabel.mas_left);
          make.right.equalTo(self);
          make.bottom.equalTo(self.mas_bottom).offset(-0.5);
    }];
    
}

#pragma mark - Getters and Setters
- (UIImageView *)locationIcon {
    
    if (!_locationIcon) {
        _locationIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"constant_city_location_hight"]];
    }
    return _locationIcon;
}

- (UILabel *)adressLabel {
    
    if (!_adressLabel) {
        _adressLabel = [[UILabel alloc]init];
        _adressLabel.font = TPSystemFontSize(15);
        _adressLabel.textColor =TPTitleTextColor;
        _adressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _adressLabel;
}


- (UIImageView *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"constant_cIty_enter_nor"]];
    }
    return _rightBtn;
}
- (UIView *)line {
    
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;
}

- (UIImageView *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"constant_city_delete_nor"]];
        @ weakify(self);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.AddConstantCellTapArrowHandler) {
                self.AddConstantCellTapArrowHandler();
            }
        }];
        _deleteBtn.userInteractionEnabled = YES;
        [_deleteBtn addGestureRecognizer:tap];

    }
    return _deleteBtn;
}

- (void)setRight_btn_type:(RIGHT_BTN_TYPE)right_btn_type {
    
    _right_btn_type = right_btn_type;
    switch (_right_btn_type) {
        case RIGHT_BTN_ARROWS:
            _deleteBtn.hidden = YES;
            _rightBtn.hidden = NO;
            break;
            
        case RIGHT_BTN_DELETE:
            _rightBtn.hidden= YES;
            _deleteBtn.hidden = NO;
            break;
    }
    
}

- (void)setModel:(TPAddressModel *)model {
    
    if (_model != model) {
        _model = model;
    }
    _adressLabel.text = model.formatted_area;
    
}

- (void)setHideLocationIcon:(BOOL)hideLocationIcon {
    _hideLocationIcon = hideLocationIcon;
    if (_hideLocationIcon) {
        [_locationIcon mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(0);
            
        }];
        [self layoutIfNeeded];
    }
    
}

@end
