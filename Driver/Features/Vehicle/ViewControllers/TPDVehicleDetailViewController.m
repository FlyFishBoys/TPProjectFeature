//
//  TPDVehicleDetailViewController.m
//  Driver
//
//  Created by Mr.mao on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleDetailViewController.h"
#import "TPDVehicleRouterEntry.h"
#import "TPDVehicleDetailView.h"
#import "UIImage+Gradient.h"
#import "TPDVehicleDetailDataManager.h"
#import "TPDVehicleDetailViewModel.h"
#import "TPDVehicleDetailModel.h"
#import "TPAlertView.h"
#import "TPNormalRefreshGifHeader.h"
#import "TPTipsView.h"

@interface TPDVehicleDetailViewController ()
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) TPTipsView * tipsView;
@property (nonatomic, strong) TPDVehicleDetailView * plateNumberView;
@property (nonatomic, strong) TPDVehicleDetailView * plateColorView;
@property (nonatomic, strong) TPDVehicleDetailView * vehicleLengthView;
@property (nonatomic, strong) TPDVehicleDetailView * driverNameView;
@property (nonatomic, strong) TPDVehicleDetailView * driverMobileView;
@property (nonatomic, strong) UILabel * vehicleInfoTitleLabel;
@property (nonatomic, strong) UILabel * remarkTitleLabel;
@property (nonatomic, strong) UIImageView * headlightsImageView;
@property (nonatomic, strong) UIImageView * drivingLicenseImageView;
@property (nonatomic, strong) UIView * imageBackgroundView;
@property (nonatomic, strong) TPDVehicleDetailDataManager * dataManager;
@property (nonatomic, strong) TPDVehicleDetailViewModel * viewModel;
@property (nonatomic, strong) UIButton * modifyButton;
@property (nonatomic, strong) UIButton * deleteButton;
@property (nonatomic, assign) BOOL isAddSubviews;

@end

@implementation TPDVehicleDetailViewController

+ (void)load {
    [TPDVehicleRouterEntry registerVehicleDetail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车辆详情";
    self.view.backgroundColor = TPBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self vd_loadDetail];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scrollView.mj_header beginRefreshing];
}
#pragma mark - Events
- (void)vd_modifyButtonAction {
    [TPRouterAnalytic openInteriorURL:TPRouter_Vehicle_Add_Modify parameter:@{@"mdifyVehicleModel" : [self.viewModel.model yy_modelToJSONObject]} type:PUSHCONTROLLERTYPE_PUSH];

}

- (void)vd_deleteButtonAction {
    TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"删除车辆后，无法找回\n您确定要删除当前的这辆车吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    @weakify(self);
    alertView.otherButtonAction = ^{
        @strongify(self);
        [self.dataManager deleteVehicleWithDriverTruckId:self.viewModel.model.driver_truck_id driverTruckVersion:self.viewModel.model.driver_truck_version completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
            @strongify(self);
            if (succeed && error == nil) {
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };
    [alertView show];
}

- (void)vd_pullDownToRefreshAction {
    @weakify(self);
    [self.dataManager getVehicleDetailWithDriverTruckId:self.driverTruckId completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, id  _Nullable viewModel) {
        @strongify(self);
        [self.scrollView.mj_header endRefreshing];
        if (succeed && viewModel) {
            self.viewModel = viewModel;
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

#pragma mark - Private
- (void)vd_loadDetail {
    TPShowLoading;
    @weakify(self);
    [self.dataManager getVehicleDetailWithDriverTruckId:self.driverTruckId completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, id  _Nullable viewModel) {
        TPHiddenLoading;
        @strongify(self);
        if (succeed && viewModel) {
            [self vd_addSubviews];
            self.viewModel = viewModel;
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)vd_addSubviews {
    if (self.isAddSubviews) return;
    self.view.backgroundColor = TPBackgroundColor;
    [self.view addSubview:self.tipsView];
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.modifyButton];
    [self.view addSubview:self.deleteButton];
    [self.scrollView addSubview:self.plateNumberView];
    [self.scrollView addSubview:self.plateColorView];
    [self.scrollView addSubview:self.vehicleInfoTitleLabel];
    [self.scrollView addSubview:self.vehicleLengthView];
    [self.scrollView addSubview:self.imageBackgroundView];
    [self.imageBackgroundView addSubview:self.headlightsImageView];
    [self.imageBackgroundView addSubview:self.drivingLicenseImageView];
    [self.scrollView addSubview:self.remarkTitleLabel];
    [self.scrollView addSubview:self.driverNameView];
    [self.scrollView addSubview:self.driverMobileView];
    
    self.isAddSubviews = YES;
    [self vd_setupConstraints];
}

- (void)vd_setupConstraints {
    
    [self.modifyButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
        make.width.equalTo(self.view.mas_width).multipliedBy(1/2.0);
    }];
    
    [self.deleteButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
        make.width.equalTo(self.view.mas_width).multipliedBy(1/2.0);
    }];
    
    [self.tipsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.mas_equalTo(0);
    }];

    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.tipsView.mas_bottom);
        make.bottom.equalTo(self.modifyButton.mas_top);
    }];

    [self.vehicleInfoTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView.mas_left).offset(TPAdaptedWidth(12));
        make.height.mas_equalTo(TPAdaptedHeight(36));
    }];

    [self.plateNumberView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vehicleInfoTitleLabel.mas_bottom);
        make.left.width.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(54));
    }];

    [self.plateColorView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.plateNumberView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(54));
    }];

    [self.vehicleLengthView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.plateColorView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(54));
    }];

    [self.imageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vehicleLengthView.mas_bottom).offset(TPAdaptedHeight(12));
        make.left.right.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(146));
    }];

    [self.headlightsImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageBackgroundView);
        make.left.equalTo(self.imageBackgroundView.mas_left).offset(TPAdaptedWidth(12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];

    [self.drivingLicenseImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageBackgroundView);
        make.right.equalTo(self.imageBackgroundView.mas_right).offset(TPAdaptedWidth(-12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];

    [self.remarkTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView.mas_left).offset(TPAdaptedWidth(12));
        make.top.equalTo(self.imageBackgroundView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(36));
    }];

    [self.driverNameView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView);
        make.top.equalTo(self.remarkTitleLabel.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(48));
    }];

    [self.driverMobileView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scrollView);
        make.top.equalTo(self.driverNameView.mas_bottom);
        make.bottom.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(48));
    }];
}

#pragma mark - getters and setters
- (void)setViewModel:(TPDVehicleDetailViewModel *)viewModel {
    _viewModel = viewModel;
    self.plateNumberView.content = viewModel.plate;
    self.plateColorView.content = viewModel.plateColor;
    self.vehicleLengthView.content = viewModel.truckTypeLength;
    self.driverNameView.content = viewModel.name;
    self.driverMobileView.content = viewModel.mobile;
    TPDVehicleDetailModel * model = viewModel.model;
    [self.headlightsImageView tp_setOriginalImageWithURL:[NSURL URLWithString:model.truck_icon_url] md5Key:model.truck_icon_key roundCornerRadius:5];
    [self.drivingLicenseImageView tp_setOriginalImageWithURL:[NSURL URLWithString:model.truck_license_url] md5Key:model.truck_license_key roundCornerRadius:5];
    [self.remarkTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.remarkHeight);
    }];
    [self.driverNameView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.nameHeight);
    }];
    [self.driverMobileView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.mobileHeight);
    }];
    [self.deleteButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.bottomButtonHeight);
    }];
    [self.modifyButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.bottomButtonHeight);
    }];
    [self.tipsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.tipsViewHeight);
    }];
}

- (TPTipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [[TPTipsView alloc] initWithContentString:@"客服正在审核中，请稍等片刻。"];
        _tipsView.clipsToBounds = YES;
    }
    return _tipsView;
}

- (TPDVehicleDetailView *)plateNumberView {
    if (!_plateNumberView) {
        _plateNumberView = [[TPDVehicleDetailView alloc] initWithTitle:@"车牌照" content:@"车牌照" layoutType:TPDVehicleDetailViewLayoutType_Right isHasSeprate:YES];
    }
    return _plateNumberView;
}

- (TPDVehicleDetailView *)plateColorView {
    if (!_plateColorView) {
        _plateColorView = [[TPDVehicleDetailView alloc] initWithTitle:@"车牌颜色" content:@"车牌颜色" layoutType:TPDVehicleDetailViewLayoutType_Right isHasSeprate:YES];
    }
    return _plateColorView;
}

- (TPDVehicleDetailView *)vehicleLengthView {
    if (!_vehicleLengthView) {
        _vehicleLengthView = [[TPDVehicleDetailView alloc] initWithTitle:@"车型车长" content:@"车型车长" layoutType:TPDVehicleDetailViewLayoutType_Right isHasSeprate:NO];
    }
    return _vehicleLengthView;
}

- (TPDVehicleDetailView *)driverNameView {
    if (!_driverNameView) {
        _driverNameView = [[TPDVehicleDetailView alloc] initWithTitle:@"开车司机" content:@"开车司机" layoutType:TPDVehicleDetailViewLayoutType_Left isHasSeprate:YES];
    }
    return _driverNameView;
}

- (TPDVehicleDetailView *)driverMobileView {
    if (!_driverMobileView) {
        _driverMobileView = [[TPDVehicleDetailView alloc] initWithTitle:@"联系电话" content:@"联系电话" layoutType:TPDVehicleDetailViewLayoutType_Left isHasSeprate:NO];
    }
    return _driverMobileView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.mj_header = [TPNormalRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(vd_pullDownToRefreshAction)];

    }
    return _scrollView;
}

- (UIButton *)modifyButton {
    if (!_modifyButton) {
        _modifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _modifyButton.clipsToBounds = YES;
        _modifyButton.layer.borderColor = TPUNEnbleColor_LineColor.CGColor;
        _modifyButton.layer.borderWidth = 0.5;
        _modifyButton.titleLabel.font = TPAdaptedFontSize(17);
        [_modifyButton setTitle:@"修改信息" forState:UIControlStateNormal];
        [_modifyButton setTitleColor:TPMainColor forState:UIControlStateNormal];
        [_modifyButton addTarget:self action:@selector(vd_modifyButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _modifyButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.titleLabel.font = TPAdaptedFontSize(17);
        [_deleteButton setTitle:@"删除车辆" forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(vd_deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        UIImage * selectedBackgroundImage = [UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth / 2.0, TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor];
        [_deleteButton setBackgroundImage:selectedBackgroundImage forState:UIControlStateNormal];\
        _deleteButton.adjustsImageWhenHighlighted = YES;
        _deleteButton.clipsToBounds = YES;
    }
    return _deleteButton;
}

- (UIView *)imageBackgroundView {
    if (!_imageBackgroundView) {
        _imageBackgroundView = [[UIView alloc]init];
        _imageBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _imageBackgroundView;
}

- (UIImageView *)headlightsImageView {
    if (!_headlightsImageView) {
        _headlightsImageView = [[UIImageView alloc]init];
        _headlightsImageView.backgroundColor = TPImageViewBackgroundColor;
        _headlightsImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _headlightsImageView;
}

- (UIImageView *)drivingLicenseImageView {
    if (!_drivingLicenseImageView) {
        _drivingLicenseImageView = [[UIImageView alloc]init];
        _drivingLicenseImageView.backgroundColor = TPImageViewBackgroundColor;
        _drivingLicenseImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _drivingLicenseImageView;
}

- (UILabel *)vehicleInfoTitleLabel {
    if (!_vehicleInfoTitleLabel) {
        _vehicleInfoTitleLabel = [[UILabel alloc]init];
        _vehicleInfoTitleLabel.text = @"车辆信息";
        _vehicleInfoTitleLabel.font = TPAdaptedFontSize(13);
        _vehicleInfoTitleLabel.textColor = TPMainTextColor;
    }
    return _vehicleInfoTitleLabel;
}

- (UILabel *)remarkTitleLabel {
    if (!_remarkTitleLabel) {
        _remarkTitleLabel = [[UILabel alloc]init];
        _remarkTitleLabel.text = @"备注信息（选填）";
        _remarkTitleLabel.font = TPAdaptedFontSize(13);
        _remarkTitleLabel.textColor = TPMainTextColor;
    }
    return _remarkTitleLabel;
}

- (TPDVehicleDetailDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDVehicleDetailDataManager alloc]init];
    }
    return _dataManager;
}

@end
