//
//  TPDIntegrityInquiryGoodsCell.m
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryGoodsCell.h"
#import "TPDIntegrityInquiryGoodsListViewModel.h"
#import "TPBottomButtonModel.h"

@interface TPDIntegrityInquiryGoodsCell ()

@property (nonatomic, strong) UIView * bottomView;
@property (nonatomic, strong) UIView * separateLine;
@property (nonatomic, strong) UILabel * departureLabel;
@property (nonatomic, strong) UILabel * destinationLabel;
@property (nonatomic, strong) UILabel * createTimeLabel;
@property (nonatomic, strong) UILabel  * goodsInfoLabel;
@property (nonatomic, strong) UIImageView * goodsInfoIcon;
@property (nonatomic, strong) UIImageView * arrowImageView;
@property (nonatomic, strong) NSMutableArray * buttons;

@end

@implementation TPDIntegrityInquiryGoodsCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    return TPAdaptedHeight(135);
}

#pragma mark - LifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self ic_setupSubviews];
    }
    return self;
}

#pragma mark - Events
- (void)ic_buttonEvents:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(integrityInquiryResultCell:didClickButtonWithButtonType:)]) {
        [self.delegate integrityInquiryResultCell:self didClickButtonWithButtonType:button.tag];
    }
}

#pragma mark - Privates
- (void)ic_setupButtonsWithButtonModels:(NSArray<TPBottomButtonModel *> *)buttonModels {
    if (!buttonModels.count) return;
    @weakify(self);
    __block UIButton * lastButton;
    [buttonModels enumerateObjectsUsingBlock:^(TPBottomButtonModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        UIButton * button = [self ic_createButtonWithTitle:obj.title tag:obj.type];
        [self.contentView addSubview:button];
        [self.buttons addObject:button];
        
        if (lastButton) {
            [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(lastButton.mas_centerY);
                make.right.equalTo(lastButton.mas_left).offset(TPAdaptedWidth(-16));
                make.height.mas_equalTo(TPAdaptedHeight(30));
                make.width.mas_equalTo(TPAdaptedWidth(80));
            }];
        } else {
            [button mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.contentView.mas_bottom).offset(TPAdaptedHeight(-18));
                make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
                make.height.mas_equalTo(TPAdaptedHeight(30));
                make.width.mas_equalTo(TPAdaptedWidth(80));
            }];
        }
        lastButton = button;
    }];
}

- (UIButton *)ic_createButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:TPTitleTextColor forState:UIControlStateNormal];
    button.clipsToBounds = YES;
    button.titleLabel.preferredMaxLayoutWidth = YES;
    button.titleLabel.font = TPAdaptedFontSize(14);
    button.tag = tag;
    [button addTarget:self action:@selector(ic_buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    UIImage * buttonBackgroundImage = [UIImage imageWithColor:TPWhiteColor size:CGSizeMake(TPAdaptedWidth(80), TPAdaptedHeight(30))];
    buttonBackgroundImage = [buttonBackgroundImage imageByRoundCornerRadius:4 borderWidth:0.5 borderColor:TPMinorTextColor];
    [button setBackgroundImage:buttonBackgroundImage forState:UIControlStateNormal];
    return button;
}

- (void)ic_setupSubviews {
    [self.contentView addSubview:self.departureLabel];
    [self.contentView addSubview:self.destinationLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.goodsInfoIcon];
    [self.contentView addSubview:self.goodsInfoLabel];
    [self.contentView addSubview:self.createTimeLabel];
    [self.contentView addSubview:self.separateLine];
    [self.contentView addSubview:self.bottomView];

    [self ic_setupConstraints];
}

- (void)ic_setupConstraints {
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(TPAdaptedHeight(8));
    }];
    
    [self.separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(69));
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
    
    [self.goodsInfoIcon mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.departureLabel.mas_left);
        make.top.equalTo(self.departureLabel.mas_bottom).offset(TPAdaptedHeight(5));
        make.width.height.mas_equalTo(TPAdaptedWidth(4));
    }];
    
    [self.goodsInfoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.goodsInfoIcon.mas_centerY);
        make.left.equalTo(self.goodsInfoIcon.mas_right).offset(TPAdaptedWidth(6));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
    }];
}

#pragma mark - Setters and Getters
- (void)setObject:(TPDIntegrityInquiryGoodsListItem *)object {
    [super setObject:object];
    self.delegate = object.target;
    self.departureLabel.text = object.departCity;
    self.destinationLabel.text = object.destinationCity;
    self.createTimeLabel.text = object.time;

    [self.buttons enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.buttons removeAllObjects];
    
    [self ic_setupButtonsWithButtonModels:object.buttonModels];
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

- (UIImageView *)goodsInfoIcon {
    if (!_goodsInfoIcon) {
        _goodsInfoIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_list_point"]];
    }
    return _goodsInfoIcon;
}

- (UILabel *)goodsInfoLabel {
    if (!_goodsInfoLabel) {
        _goodsInfoLabel = [[UILabel alloc]init];
        _goodsInfoLabel.font = TPAdaptedFontSize(13);
        _goodsInfoLabel.textColor = TPMainTextColor;
        _goodsInfoLabel.text = @"";
        _goodsInfoLabel.preferredMaxLayoutWidth = YES;
    }
    return _goodsInfoLabel;
}

- (UILabel *)createTimeLabel {
    if (!_createTimeLabel) {
        _createTimeLabel = [[UILabel alloc]init];
        _createTimeLabel.font = TPAdaptedFontSize(12);
        _createTimeLabel.textColor = TPMinorTextColor;
        _createTimeLabel.text = @"";
        _createTimeLabel.preferredMaxLayoutWidth = YES;
    }
    return _createTimeLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = TPBackgroundColor;
    }
    return _bottomView;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _separateLine;
}


- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc]init];
    }
    return _buttons;
}
@end
