//
//  TPDMyOrderListCell.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyOrderListCell.h"
#import "TPDMyOrderListViewModel.h"
#import "TPStartView.h"
#import "TPDOrderDefines.h"
#import "TPBottomButtonModel.h"

@interface TPDMyOrderListCell ()

@property (nonatomic, strong) UIView * topSeparateView;
@property (nonatomic, strong) UIView * separateLine;
@property (nonatomic, strong) UILabel * departureLabel;
@property (nonatomic, strong) UILabel * destinationLabel;
@property (nonatomic, strong) UILabel * statusLabel;
@property (nonatomic, strong) UILabel * pickupTimeLabel;
@property (nonatomic, strong) UILabel * updateTimeLabel;
@property (nonatomic, strong) UILabel * freightLabel;
@property (nonatomic, strong) UIImageView * pickupTimeIcon;
@property (nonatomic, strong) UIImageView * freightIcon;
@property (nonatomic, strong) UIImageView * arrowImageView;
@property (nonatomic, strong) UIImageView * statusBackgroundImageView;
@property (nonatomic, strong) UIButton * headButton;
@property (nonatomic, strong) UILabel  * nameLabel;
@property (nonatomic, strong) TPStartView   * starView;
@property (nonatomic, strong) NSMutableArray * buttons;

@end

@implementation TPDMyOrderListCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    return TPAdaptedHeight(186);
}

#pragma mark - LifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self oc_setupSubviews];
    }
    return self;
}

#pragma mark - Events
- (void)mo_buttonEvents:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(myOrderListCell:didClickButtonWithButtonType:)]) {
        [self.delegate myOrderListCell:self didClickButtonWithButtonType:button.tag];
    }
}

#pragma mark - Privates
- (void)mo_setupButtonsWithButtonModels:(NSArray<TPBottomButtonModel *> *)buttonModels {
    if (!buttonModels.count) return;
    @weakify(self);
    __block UIButton * lastButton;
    [buttonModels enumerateObjectsUsingBlock:^(TPBottomButtonModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        UIButton * button = [self mo_createButtonWithTitle:obj.title tag:obj.type];
        [self.contentView addSubview:button];
        [self.buttons addObject:button];
        
        if (lastButton) {
            [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(lastButton.mas_centerY);
                make.right.equalTo(lastButton.mas_left).offset(TPAdaptedWidth(-16));
                make.height.mas_equalTo(TPAdaptedHeight(30));
            }];
        } else {
            [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.contentView.mas_bottom).offset(TPAdaptedHeight(-10));
                make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
                make.height.mas_equalTo(TPAdaptedHeight(30));
            }];
        }
        lastButton = button;
    }];
}

- (UIButton *)mo_createButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TPTitleTextColor forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    button.titleLabel.preferredMaxLayoutWidth = YES;
    button.titleLabel.font = TPAdaptedFontSize(14);
    button.tag = tag;
    [button addTarget:self action:@selector(mo_buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat imageW = [title widthForFont:TPAdaptedFontSize(14)];
    UIImage * buttonBackgroundImage = [UIImage imageWithColor:TPWhiteColor size:CGSizeMake(imageW, TPAdaptedHeight(30))];
    buttonBackgroundImage = [buttonBackgroundImage imageByRoundCornerRadius:4 borderWidth:0.5 borderColor:TPMinorTextColor];
    [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    return button;
}

- (void)oc_setupSubviews {
    
    self.backgroundColor = TPWhiteColor;
    [self.contentView addSubview:self.departureLabel];
    [self.contentView addSubview:self.topSeparateView];
    [self.contentView addSubview:self.separateLine];
    [self.contentView addSubview:self.destinationLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.statusBackgroundImageView];
    [self.contentView addSubview:self.statusLabel];
    [self.contentView addSubview:self.pickupTimeLabel];
    [self.contentView addSubview:self.pickupTimeIcon];
    [self.contentView addSubview:self.freightLabel];
    [self.contentView addSubview:self.freightIcon];
    [self.contentView addSubview:self.headButton];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.starView];
    [self.contentView addSubview:self.updateTimeLabel];
    
    [self oc_setupConstraints];
}

- (void)oc_setupConstraints {
    [self.topSeparateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(TPAdaptedHeight(8));
    }];
    
    [self.separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(TPAdaptedHeight(-50));
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.departureLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(12));
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(14));
        make.width.mas_lessThanOrEqualTo(TPAdaptedWidth(100));
    }];
    
    [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_right).offset(TPAdaptedWidth(6));
        make.centerY.equalTo(self.departureLabel.mas_centerY);
    }];
    
    [self.destinationLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.arrowImageView.mas_right).offset(TPAdaptedWidth(6));
        make.centerY.equalTo(self.departureLabel.mas_centerY);
        make.width.mas_lessThanOrEqualTo(TPAdaptedWidth(100));
    }];
    
    [self.statusBackgroundImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
        make.top.equalTo(self.topSeparateView.mas_bottom);
    }];
    
    [self.statusLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.statusBackgroundImageView);
        make.top.equalTo(self.statusBackgroundImageView.mas_top).offset(TPAdaptedHeight(1));
    }];
    
    [self.pickupTimeIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_left);
        make.top.equalTo(self.departureLabel.mas_bottom).offset(TPAdaptedHeight(17));
        make.width.height.mas_equalTo(TPAdaptedWidth(4));
    }];
    
    [self.pickupTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pickupTimeIcon.mas_centerY);
        make.left.equalTo(self.pickupTimeIcon.mas_right).offset(TPAdaptedWidth(6));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
    }];
    
    [self.freightIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_left);
        make.top.equalTo(self.pickupTimeIcon.mas_bottom).offset(TPAdaptedHeight(16));
        make.width.height.mas_equalTo(TPAdaptedWidth(4));
    }];
    
    [self.freightLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self.freightIcon.mas_centerY);
        make.left.equalTo(self.freightIcon.mas_right).offset(TPAdaptedWidth(6));
    }];
    
    [self.updateTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topSeparateView.mas_bottom).offset(TPAdaptedHeight(44));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
    }];
    
    [self.headButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.freightLabel.mas_bottom).offset(TPAdaptedHeight(12));
        make.left.equalTo(self.departureLabel.mas_left);
        make.width.height.mas_equalTo(TPAdaptedWidth(35));
    }];
    
    [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headButton.mas_right).offset(TPAdaptedWidth(8));
        make.top.equalTo(self.headButton.mas_top);
        make.width.mas_lessThanOrEqualTo(TPAdaptedWidth(100));
    }];
    
    [self.starView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.bottom.equalTo(self.headButton.mas_bottom);
        make.width.mas_equalTo(TPAdaptedWidth(40));
        make.height.mas_equalTo(TPAdaptedHeight(10));
    }];
}

#pragma mark - Setters and Getters
- (void)setObject:(TPDMyOrderListItemViewModel *)object {
    [super setObject:object];
    self.delegate = object.target;
    self.departureLabel.text = object.departCity;
    self.destinationLabel.text = object.destinationCity;
    self.pickupTimeLabel.text = object.pickupTime;
    self.updateTimeLabel.text = object.updateTime;
    self.freightLabel.text = object.fee;
    self.nameLabel.text = object.name;
    self.statusLabel.text = object.status;
    self.statusBackgroundImageView.image = object.statusImage;
    self.starView.score = object.starScore;
    [self.headButton setImage:object.icon forState:UIControlStateNormal];
    
    [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.buttons removeAllObjects];
    
    [self mo_setupButtonsWithButtonModels:object.buttonModels];
}

- (UILabel *)departureLabel {
    if (!_departureLabel) {
        _departureLabel = [[UILabel alloc]init];
        _departureLabel.font = TPAdaptedBoldFontSize(17);
        _departureLabel.textColor = TPTitleTextColor;
        _departureLabel.text = @"";
        _departureLabel.preferredMaxLayoutWidth = YES;
    }
    return _departureLabel;
}

- (UILabel *)destinationLabel {
    if (!_destinationLabel) {
        _destinationLabel = [[UILabel alloc]init];
        _destinationLabel.font = TPAdaptedBoldFontSize(17);
        _destinationLabel.textColor = TPTitleTextColor;
        _destinationLabel.text = @"";
        _destinationLabel.preferredMaxLayoutWidth = YES;
    }
    return _destinationLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_list_arrow"]];
    }
    return _arrowImageView;
}

- (UIImageView *)statusBackgroundImageView {
    if (!_statusBackgroundImageView) {
        _statusBackgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_list_statusbackground_blue"]];
    }
    return _statusBackgroundImageView;
}

- (UIImageView *)pickupTimeIcon {
    if (!_pickupTimeIcon) {
        _pickupTimeIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_list_point"]];
    }
    return _pickupTimeIcon;
}


- (UIImageView *)freightIcon {
    if (!_freightIcon) {
        _freightIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_list_point"]];
    }
    return _freightIcon;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.font = TPAdaptedFontSize(12);
        _statusLabel.textColor = TPWhiteColor;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.text = @"";
    }
    return _statusLabel;
}

- (UILabel *)pickupTimeLabel {
    if (!_pickupTimeLabel) {
        _pickupTimeLabel = [[UILabel alloc]init];
        _pickupTimeLabel.font = TPAdaptedFontSize(13);
        _pickupTimeLabel.textColor = TPMainTextColor;
        _pickupTimeLabel.text = @"";
        _pickupTimeLabel.preferredMaxLayoutWidth = YES;
        
    }
    return _pickupTimeLabel;
}

- (UILabel *)updateTimeLabel {
    if (!_updateTimeLabel) {
        _updateTimeLabel = [[UILabel alloc]init];
        _updateTimeLabel.font = TPAdaptedFontSize(13);
        _updateTimeLabel.textColor = TPMainTextColor;
        _updateTimeLabel.text = @"";
        _updateTimeLabel.preferredMaxLayoutWidth = YES;
        
    }
    return _updateTimeLabel;
}

- (UILabel *)freightLabel {
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc]init];
        _freightLabel.font = TPAdaptedFontSize(13);
        _freightLabel.textColor = TPMainTextColor;
        _freightLabel.text = @"";
        _freightLabel.preferredMaxLayoutWidth = YES;
    }
    return _freightLabel;
}

- (UIView *)topSeparateView {
    if (!_topSeparateView) {
        _topSeparateView = [[UIView alloc]init];
        _topSeparateView.backgroundColor = TPBackgroundColor;
    }
    return _topSeparateView;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _separateLine;
}

- (UIButton *)headButton {
    if (!_headButton) {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.contentMode = UIViewContentModeScaleAspectFill;
        _headButton.clipsToBounds = YES;
        _headButton.backgroundColor = [UIColor greenColor];
    }
    return _headButton;
}

- (TPStartView *)starView {
    if (!_starView) {
        _starView = [[TPStartView alloc]init];
    }
    return _starView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = TPAdaptedFontSize(13);
        _nameLabel.textColor = TPTitleTextColor;
        _nameLabel.text = @"";
        _nameLabel.preferredMaxLayoutWidth = YES;
    }
    return _nameLabel;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc]init];
    }
    return _buttons;
}

@end
