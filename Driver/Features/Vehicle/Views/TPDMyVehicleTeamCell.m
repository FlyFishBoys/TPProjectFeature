//
//  TPDMyVehicleTeamCell.m
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyVehicleTeamCell.h"
#import "TPDMyVehicleTeamViewModel.h"
#import "TPDMyVehicleTeamModel.h"

@interface TPDMyVehicleTeamCell ()
@property (nonatomic, strong) UIImageView * headerImageView;
@property (nonatomic, strong) UIImageView * auditStatusImageView;
@property (nonatomic, strong) UILabel  * plateLabel;
@property (nonatomic, strong) UIImageView * plateBackgroundView;
@property (nonatomic, strong) UILabel  * truckInfoLabel;
@property (nonatomic, strong) UILabel  * remarkInfoLabel;
@property (nonatomic, strong) UIButton * swatchSeekingGoodsButton;
@property (nonatomic, strong) UIView   * bottomSeparateLine;
@end

@implementation TPDMyVehicleTeamCell

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    return TPAdaptedHeight(88);
}

#pragma mark - LifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = TPWhiteColor;
        [self vc_setupSubviews];
    }
    return self;
}

#pragma mark - Events
- (void)vc_swatchSeekingGoodsButtonEvent:(UIButton *)button {
    TPDMyVehicleTeamItemViewModel * itemViewModel = (TPDMyVehicleTeamItemViewModel *)self.object;
    TPDMyVehicleTeamModel * model = itemViewModel.model;
    if ([self.delegate respondsToSelector:@selector(myVehicleTeamCell:driverTruckId:truckStatus:button:)]) {
        [self.delegate myVehicleTeamCell:self driverTruckId:model.driver_truck_id truckStatus:model.truck_status button:button];
    }
}

#pragma mark - Privates
- (void)vc_setupSubviews {
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.truckInfoLabel];
    [self.contentView addSubview:self.plateBackgroundView];
    [self.plateBackgroundView addSubview:self.plateLabel];
    [self.contentView addSubview:self.remarkInfoLabel];
    [self.contentView addSubview:self.auditStatusImageView];
    [self.contentView addSubview:self.bottomSeparateLine];
    [self.contentView addSubview:self.swatchSeekingGoodsButton];
    [self vc_setupConstraints];
}

- (void)vc_setupConstraints {
    [self.headerImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(12));
        make.width.height.mas_equalTo(TPScale(60));
    }];
    
    [self.plateBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(14));
        make.left.equalTo(self.headerImageView.mas_right).offset(TPAdaptedWidth(8));
        make.width.mas_equalTo(TPAdaptedWidth(58));
        make.height.mas_equalTo(TPAdaptedHeight(16));
    }];
    
    [self.plateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.plateBackgroundView.mas_centerY);
        make.centerX.equalTo(self.plateBackgroundView.mas_centerX);
    }];
    
    [self.auditStatusImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(14));
        make.left.equalTo(self.plateBackgroundView.mas_right).offset(TPAdaptedWidth(6));
//        make.width.mas_equalTo(TPAdaptedWidth(42));
//        make.height.mas_equalTo(TPAdaptedHeight(16));
    }];
    
    [self.truckInfoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.plateBackgroundView.mas_bottom).offset(TPAdaptedHeight(5));
        make.left.equalTo(self.headerImageView.mas_right).offset(TPAdaptedWidth(8));
    }];
    
    [self.remarkInfoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.truckInfoLabel.mas_bottom).offset(TPAdaptedHeight(5));
        make.left.equalTo(self.headerImageView.mas_right).offset(TPAdaptedWidth(8));
    }];
    
    [self.bottomSeparateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(12));
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.swatchSeekingGoodsButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
//        make.width.mas_equalTo(TPAdaptedWidth(62));
//        make.height.mas_equalTo(TPAdaptedHeight(22));
    }];
}

#pragma mark - Setters and Getters
- (void)setObject:(TPDMyVehicleTeamItemViewModel *)object {
    [super setObject:object];
    self.delegate = object.target;
    self.plateLabel.text = object.plate;
    self.plateBackgroundView.image = object.plateBackgroundImage;
    self.truckInfoLabel.text = object.truckTypeLength;
    self.remarkInfoLabel.text = object.remark;
    self.auditStatusImageView.hidden = !object.isAudit;
    self.swatchSeekingGoodsButton.selected = object.isSeekingGoods;
    [self.headerImageView tp_setSizeToFitImageWithURL:[NSURL URLWithString:object.model.truck_icon_url] md5Key:object.model.truck_icon_key roundCornerRadius:4];
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc]init];
        _headerImageView.backgroundColor = TPImageViewBackgroundColor;
    }
    return _headerImageView;
}

- (UILabel *)truckInfoLabel {
    if (!_truckInfoLabel) {
        _truckInfoLabel = [[UILabel alloc]init];
        _truckInfoLabel.font = TPAdaptedFontSize(15);
        _truckInfoLabel.textColor = TPTitleTextColor;
        _truckInfoLabel.text = @"";
        _truckInfoLabel.preferredMaxLayoutWidth = YES;
    }
    return _truckInfoLabel;
}

- (UILabel *)plateLabel {
    if (!_plateLabel) {
        _plateLabel = [[UILabel alloc]init];
        _plateLabel.font = TPAdaptedFontSize(10);
        _plateLabel.textColor = TPWhiteColor;
        _plateLabel.text = @"";
        _plateLabel.preferredMaxLayoutWidth = YES;
    }
    return _plateLabel;
}

- (UIImageView *)plateBackgroundView {
    if (!_plateBackgroundView) {
        _plateBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    }
    return _plateBackgroundView;
}

- (UIImageView *)auditStatusImageView {
    if (!_auditStatusImageView) {
        _auditStatusImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"vehicle_team_audit_succeed"]];
        _auditStatusImageView.clipsToBounds = YES;
        _auditStatusImageView.hidden = YES;
    }
    return _auditStatusImageView;
}

- (UILabel *)remarkInfoLabel {
    if (!_remarkInfoLabel) {
        _remarkInfoLabel = [[UILabel alloc]init];
        _remarkInfoLabel.font = TPAdaptedFontSize(13);
        _remarkInfoLabel.textColor = TPMainTextColor;
        _remarkInfoLabel.text = @"";
        _remarkInfoLabel.preferredMaxLayoutWidth = YES;
    }
    return _remarkInfoLabel;
}

- (UIButton *)swatchSeekingGoodsButton {
    if (!_swatchSeekingGoodsButton) {
        _swatchSeekingGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_swatchSeekingGoodsButton setBackgroundImage:[UIImage imageNamed:@"vehicle_team_status_rest"] forState:UIControlStateNormal];
        [_swatchSeekingGoodsButton setBackgroundImage:[UIImage imageNamed:@"vehicle_team_status_seekgoods"] forState:UIControlStateSelected];
        [_swatchSeekingGoodsButton addTarget:self action:@selector(vc_swatchSeekingGoodsButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        _swatchSeekingGoodsButton.adjustsImageWhenHighlighted = NO;
    }
    return _swatchSeekingGoodsButton;
}

- (UIView *)bottomSeparateLine {
    if (!_bottomSeparateLine) {
        _bottomSeparateLine = [[UIView alloc]init];
        _bottomSeparateLine.backgroundColor = TPUNEnbleColor_LineColor;
        _bottomSeparateLine.clipsToBounds = YES;
    }
    return _bottomSeparateLine;
}

@end
