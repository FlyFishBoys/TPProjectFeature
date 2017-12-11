//
//  TPDCallRecordsCell.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCallRecordsCell.h"
#import "TPStartView.h"
#import "TPDCallRecordsViewModel.h"

@interface TPDCallRecordsCell ()

@property (nonatomic , strong) UILabel *departLable;

@property (nonatomic , strong) UILabel *destinationLable;

@property (nonatomic , strong) UIImageView *addressIconView;

@property (nonatomic , strong) UILabel *detailLable;

@property (nonatomic , strong) UIImageView *headerIconView;

@property (nonatomic , strong) UILabel *nameLabel;

@property (nonatomic , strong) TPStartView *starView;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) UIButton *receiveButton;

@property (nonatomic , strong) UIButton *callButton;

@end

@implementation TPDCallRecordsCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubviews];
        [self addConstraints];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    
    return TPAdaptedHeight(100);
}
- (void)setObject:(TPDCallRecordsItemViewModel *)object {
    [super setObject:object];
    self.departLable.text = object.depart;
    self.destinationLable.text = object.destination;
    self.timeLabel.text = object.timeString;
    self.detailLable.text = object.goodsTruckInfoString;
    self.nameLabel.text = object.name;
    self.starView.score = object.grade;
    if (object.iconImageName.isNotBlank) {
        self.headerIconView.image = [UIImage imageNamed:object.iconImageName];
    } else {
        [self.headerIconView tp_setSizeToFitImageWithURL:[NSURL URLWithString:object.iconUrl]
                                                  md5Key:object.iconKey
                                        placeholderImage:[UIImage imageNamed:@"common_placeholder70*70"]
                                       roundCornerRadius:4];
    }

}
#pragma mark - Event
- (void)tapCallBtn:(UIButton *)tapCallBtn {
    if ([self.object.target respondsToSelector:@selector(didClickCallOnCell:)]) {
        [self.object.target didClickCallOnCell:self];
    }
}
- (void)tapReceiveBtn:(UIButton *)tapReceiveBtn {
    if ([self.object.target respondsToSelector:@selector(didClickChatOnCell:)]) {
        [self.object.target didClickChatOnCell:self];
    }
}
- (void)addSubviews {
    [self addSubview:self.departLable];
    [self addSubview:self.addressIconView];
    [self addSubview:self.destinationLable];
    [self addSubview:self.detailLable];
    [self addSubview:self.headerIconView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.starView];
    [self addSubview:self.timeLabel];
    [self addSubview:self.receiveButton];
    [self addSubview:self.callButton];
    
}
- (void)addConstraints {
    
    [_departLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(10));
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
    }];
    
    [_addressIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_departLable.mas_right).offset(TPAdaptedWidth(6));
        make.centerY.equalTo(_departLable);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(11));
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(50));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedHeight(10));
    }];
    
    [_destinationLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_addressIconView.mas_right).offset(TPAdaptedWidth(6));
        make.top.equalTo(_departLable.mas_top);
        make.right.lessThanOrEqualTo(_timeLabel.mas_left).offset(TPAdaptedWidth(5));
    }];
    
    [_detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.top.equalTo(self.mas_top).offset(TPAdaptedHeight(33));
        make.width.mas_lessThanOrEqualTo(TPScreenWidth - TPAdaptedWidth(24));
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(200));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedHeight(10));
        
    }];
    
    [_headerIconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_detailLable.mas_left);
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-8));
        make.width.mas_equalTo(TPAdaptedWidth(35));
        make.height.mas_equalTo(TPAdaptedWidth(35));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(55));
        make.top.equalTo(_headerIconView.mas_top);
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedWidth(10));
    }];
    
    UIImage *yellow = [UIImage imageNamed:@"star_view_yellow_all"];
    [_starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-8));
        make.left.equalTo(self).offset(TPAdaptedWidth(55));
        make.height.mas_equalTo(TPAdaptedHeight(8));
        make.width.mas_equalTo(yellow.size.width);
        
    }];
    
    [_callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-9));
        make.width.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
        make.height.mas_greaterThanOrEqualTo(TPAdaptedWidth(40));
    }];
    
    [_receiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_callButton);
        make.height.equalTo(_callButton);
        make.bottom.equalTo(_callButton.mas_bottom);
        make.right.equalTo(_callButton.mas_left).offset(TPAdaptedWidth(-16));
    }];
 
}
#pragma mark - Getters and Setters
- (UILabel *)departLable {
    if (!_departLable) {
        _departLable = [[UILabel alloc]init];
        _departLable.textColor = TPTitleTextColor;
        _departLable.font = TPAdaptedBoldFontSize(17);
        _departLable.preservesSuperviewLayoutMargins = YES;
        _departLable.text = @"上海 ";
    }
    return _departLable;
}
- (UILabel *)destinationLable {
    if (!_destinationLable) {
        _destinationLable = [[UILabel alloc]init];
        _destinationLable.textColor = TPTitleTextColor;
        _destinationLable.font = TPAdaptedBoldFontSize(17);
        _destinationLable.preservesSuperviewLayoutMargins = YES;
        _destinationLable.text = @"上海 ";
        _destinationLable.preservesSuperviewLayoutMargins = YES;
    }
    return _destinationLable;
}
- (UIImageView *)addressIconView {
    
    if (!_addressIconView) {
        _addressIconView = [[UIImageView alloc]init];
        _addressIconView.image = [UIImage imageNamed:@"order_list_arrow"];
    }
    return _addressIconView;
    
}
- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.textColor = TPMainTextColor;
        _timeLabel.font =TPAdaptedFontSize(12);
        _timeLabel.preservesSuperviewLayoutMargins = YES;
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UILabel *)detailLable {
    if (!_detailLable) {
        _detailLable = [[UILabel alloc]init];
        _detailLable.font = TPAdaptedFontSize(13);
        _detailLable.textColor = TPMainTextColor;
        _detailLable.preservesSuperviewLayoutMargins = YES;
        _detailLable.preservesSuperviewLayoutMargins = YES;
    }
    
    return _detailLable;
}
- (UIImageView *)headerIconView {
    if (!_headerIconView) {
        _headerIconView = [[UIImageView alloc]
                           initWithFrame:CGRectMake(0, 0, TPAdaptedWidth(35), TPAdaptedWidth(35))];
        _headerIconView.preservesSuperviewLayoutMargins = YES;
        
    }
    return _headerIconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = TPTitleTextColor;
        _nameLabel.font = TPSystemFontSize(13);
        _nameLabel.preservesSuperviewLayoutMargins = YES;
        _nameLabel.text = @"";
        
    }
    return _nameLabel;
}

- (TPStartView *)starView {
    if (!_starView) {
        _starView = [[TPStartView alloc]init];
        _starView.score = 1.5;
        _starView.preservesSuperviewLayoutMargins = YES;
        
    }
    return _starView;
}
- (UIButton *)receiveButton {
    if (!_receiveButton) {
        _receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _receiveButton.titleLabel.textColor = TPWhiteColor;
        _receiveButton.titleLabel.font = TPSystemFontSize(20);
        [_receiveButton addTarget:self action:@selector(tapReceiveBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_receiveButton setBackgroundImage:[UIImage imageNamed:@"smart_find_goods_message_white"] forState:0];
        _receiveButton.preservesSuperviewLayoutMargins = YES;
    }
    return _receiveButton;
}
- (UIButton *)callButton {
    if (!_callButton) {
        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callButton setBackgroundImage:[UIImage imageNamed:@"smart_find_goods_call_nor"] forState:0];
        [_callButton addTarget:self action:@selector(tapCallBtn:) forControlEvents:UIControlEventTouchUpInside];
        _callButton.preservesSuperviewLayoutMargins = YES;
        
    }
    return _callButton;
}
@end
