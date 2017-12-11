//
//  TPDQuotesListCell.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDQuotesListCell.h"
#import "TPDQuotesListViewModel.h"

@interface TPDQuotesListCell ()

@property (nonatomic, strong) UIView      * bottomSeparateView;
@property (nonatomic, strong) UIView      * separateLine;
@property (nonatomic, strong) UILabel     * departureLabel;
@property (nonatomic, strong) UIImageView * arrowImageView;
@property (nonatomic, strong) UILabel     * destinationLabel;
@property (nonatomic, strong) UILabel     * updateTimeLabel;
@property (nonatomic, strong) UILabel     * truckInfoLabel;
@property (nonatomic, strong) UIImageView * truckInfoIcon;
@property (nonatomic, strong) UILabel     * addressLabel;
@property (nonatomic, strong) UIImageView * addressIcon;
@property (nonatomic, strong) UIButton    * selectButton;
@property (nonatomic, strong) UILabel     * quotesLabel;
@property (nonatomic, strong) UILabel     * quotesTagLabel;
@property (nonatomic, strong) UILabel     * depositLabel;
@property (nonatomic, strong) UILabel     * depositTagLabel;
@property (nonatomic, strong) UIButton    * bottomButton;

@end

@implementation TPDQuotesListCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    return TPAdaptedHeight(186);
}

#pragma mark - LifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self qc_setupSubviews];
    }
    return self;
}


#pragma mark - Events
- (void)selectButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    if ([self.delegate respondsToSelector:@selector(quotesListCell:isSelected:itemViewModel:)]) {
        [self.delegate quotesListCell:self isSelected:button.selected itemViewModel:(TPDQuotesListItemViewModel *)self.object];
    }
}

- (void)bottomButtonEvent:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(didClickPayDepositWithQuotesListCell:)]) {
        [self.delegate didClickPayDepositWithQuotesListCell:self];
    }
}

#pragma mark - Privates
- (void)qc_setupSubviews {
    [self.contentView addSubview:self.bottomSeparateView];
    [self.contentView addSubview:self.separateLine];
    [self.contentView addSubview:self.departureLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.destinationLabel];
    [self.contentView addSubview:self.updateTimeLabel];
    [self.contentView addSubview:self.truckInfoLabel];
    [self.contentView addSubview:self.truckInfoIcon];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.addressIcon];
    [self.contentView addSubview:self.selectButton];
    [self.contentView addSubview:self.quotesLabel];
    [self.contentView addSubview:self.quotesTagLabel];
    [self.contentView addSubview:self.depositLabel];
    [self.contentView addSubview:self.depositTagLabel];
    [self.contentView addSubview:self.bottomButton];

    [self qc_setupConstraints];
}

- (void)qc_setupConstraints {
    
    [self.bottomSeparateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(TPAdaptedHeight(8));
    }];
    
    [self.separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(130));
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(53));
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.selectButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.bottomSeparateView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.width.mas_equalTo(TPAdaptedWidth(53));
    }];
    
    [self.departureLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(13));
        make.left.equalTo(self.separateLine.mas_left);
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
    
    [self.updateTimeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self.departureLabel.mas_centerY);
        make.width.mas_lessThanOrEqualTo(TPAdaptedWidth(100));
    }];
    
    [self.truckInfoIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_left);
        make.top.equalTo(self.departureLabel.mas_bottom).offset(TPAdaptedHeight(16));
        make.width.height.mas_equalTo(TPAdaptedWidth(4));
    }];
    
    [self.truckInfoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.truckInfoIcon.mas_centerY);
        make.left.equalTo(self.truckInfoIcon.mas_right).offset(TPAdaptedWidth(6));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
    }];
    
    [self.addressIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_left);
        make.top.equalTo(self.truckInfoIcon.mas_bottom).offset(TPAdaptedHeight(15));
        make.width.height.mas_equalTo(TPAdaptedWidth(4));
    }];
    
    [self.addressLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addressIcon.mas_centerY);
        make.left.equalTo(self.addressIcon.mas_right).offset(TPAdaptedWidth(6));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
    }];

    [self.quotesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_left);
        make.top.equalTo(self.addressIcon.mas_bottom).offset(TPAdaptedHeight(10));
        make.width.mas_equalTo(TPAdaptedWidth(150));
    }];
    
    [self.quotesTagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_left);
        make.top.equalTo(self.quotesLabel.mas_bottom);
    }];
    
    [self.depositLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-53));
        make.centerY.equalTo(self.quotesLabel.mas_centerY);
    }];
    
    [self.depositTagLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.depositLabel.mas_left);
        make.centerY.equalTo(self.quotesTagLabel.mas_centerY);
    }];
    
    [self.bottomButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
        make.top.equalTo(self.separateLine.mas_bottom).offset(TPAdaptedHeight(10));
    }];
    
}

#pragma mark - Setters and Getters
- (void)setObject:(TPDQuotesListItemViewModel *)object {
    [super setObject:object];
    
    self.delegate = object.target;
    self.departureLabel.text = object.departCity;
    self.destinationLabel.text = object.destinationCity;
    self.truckInfoLabel.text = object.truckInfo;
    self.addressLabel.text = object.address;
    self.quotesLabel.text = object.quotes;
    self.depositLabel.text = object.deposit;
    self.updateTimeLabel.text = object.updateTime;
    self.depositTagLabel.hidden = object.isHideDepositTag;
    self.selectButton.selected = object.isSelected;
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

- (UILabel *)updateTimeLabel {
    if (!_updateTimeLabel) {
        _updateTimeLabel = [[UILabel alloc]init];
        _updateTimeLabel.font = TPAdaptedFontSize(12);
        _updateTimeLabel.textColor = TPMainTextColor;
        _updateTimeLabel.text = @"";
        _updateTimeLabel.preferredMaxLayoutWidth = YES;
    }
    return _updateTimeLabel;
}

- (UIImageView *)truckInfoIcon {
    if (!_truckInfoIcon) {
        _truckInfoIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_list_point"]];
    }
    return _truckInfoIcon;
}

- (UILabel *)truckInfoLabel {
    if (!_truckInfoLabel) {
        _truckInfoLabel = [[UILabel alloc]init];
        _truckInfoLabel.font = TPAdaptedFontSize(13);
        _truckInfoLabel.textColor = TPMainTextColor;
        _truckInfoLabel.text = @"";
        _truckInfoLabel.preferredMaxLayoutWidth = YES;
    }
    return _truckInfoLabel;
}



- (UIImageView *)addressIcon {
    if (!_addressIcon) {
        _addressIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_list_point"]];
    }
    return _addressIcon;
}

- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        _addressLabel.font = TPAdaptedFontSize(13);
        _addressLabel.textColor = TPMainTextColor;
        _addressLabel.text = @"";
        _addressLabel.preferredMaxLayoutWidth = YES;
    }
    return _addressLabel;
}

- (UILabel *)quotesTagLabel {
    if (!_quotesTagLabel) {
        _quotesTagLabel = [[UILabel alloc]init];
        _quotesTagLabel.font = TPAdaptedFontSize(12);
        _quotesTagLabel.textColor = TPMainColor;
        _quotesTagLabel.text = @"报价￥";
        _quotesTagLabel.preferredMaxLayoutWidth = YES;
    }
    return _quotesTagLabel;
}

- (UILabel *)quotesLabel {
    if (!_quotesLabel) {
        _quotesLabel = [[UILabel alloc]init];
        _quotesLabel.font = TPAdaptedBoldFontSize(22);
        _quotesLabel.textColor = TPMainColor;
        _quotesLabel.text = @"";
        _quotesLabel.preferredMaxLayoutWidth = YES;
    }
    return _quotesLabel;
}

- (UILabel *)depositLabel {
    if (!_depositLabel) {
        _depositLabel = [[UILabel alloc]init];
        _depositLabel.font = TPAdaptedBoldFontSize(22);
        _depositLabel.textColor = UIColorHex(FFB000);
        _depositLabel.text = @"";
        _depositLabel.textAlignment = NSTextAlignmentRight;
        _depositLabel.preferredMaxLayoutWidth = YES;
    }
    return _depositLabel;
}

- (UILabel *)depositTagLabel {
    if (!_depositTagLabel) {
        _depositTagLabel = [[UILabel alloc]init];
        _depositTagLabel.font = TPAdaptedFontSize(12);
        _depositTagLabel.textColor = UIColorHex(FFB000);
        _depositTagLabel.text = @"定金￥";
        _depositTagLabel.textAlignment = NSTextAlignmentRight;
        _depositTagLabel.preferredMaxLayoutWidth = YES;
    }
    return _depositTagLabel;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomButton setTitle:@"  修改/付定金  " forState:UIControlStateNormal];
        [_bottomButton setTitleColor:TPTitleTextColor forState:UIControlStateNormal];
        _bottomButton.clipsToBounds = YES;
        _bottomButton.titleLabel.font = TPSystemFontSize(14);
        CGFloat imageW = [_bottomButton.currentTitle widthForFont:TPAdaptedFontSize(14)];
        UIImage * buttonBackgroundImage = [UIImage imageWithColor:TPWhiteColor size:CGSizeMake(imageW, TPAdaptedHeight(30))];
        buttonBackgroundImage = [buttonBackgroundImage imageByRoundCornerRadius:4 borderWidth:0.5 borderColor:TPMinorTextColor];
        [_bottomButton setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(bottomButtonEvent:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _bottomButton;
}

- (UIView *)bottomSeparateView {
    if (!_bottomSeparateView) {
        _bottomSeparateView = [[UIView alloc]init];
        _bottomSeparateView.backgroundColor = TPBackgroundColor;
    }
    return _bottomSeparateView;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _separateLine;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_normal"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_selected"] forState:UIControlStateSelected];
        _selectButton.adjustsImageWhenHighlighted = NO;
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

@end
