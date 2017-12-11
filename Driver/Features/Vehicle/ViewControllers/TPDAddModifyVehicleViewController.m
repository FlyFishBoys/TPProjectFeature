//
//  TPDAddModifyVehicleViewController.m
//  Driver
//
//  Created by Mr.mao on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddModifyVehicleViewController.h"
#import "TPDVehicleRouterEntry.h"
#import "TPDNumberPlateView.h"
#import "TPDColorPlateView.h"
#import "TPDVehicleLengthView.h"
#import "TPCertificationUploadImageView.h"
#import "UIImage+Gradient.h"
#import "TPNormalRefreshGifHeader.h"
#import "TPDVehicleRemarkView.h"
#import "TPDAddModifyVehicleModel.h"
#import "NSString+Regular.h"
#import "TPDAddModifyVehicleDataManager.h"
#import "TPDModifyVehicleViewModel.h"

@interface TPDAddModifyVehicleViewController ()
@property (nonatomic, strong) UIScrollView * scrollView;
@property (strong,nonatomic  ) TPDNumberPlateView * numberPlateView;
@property (strong,nonatomic  ) TPDColorPlateView * colorPlateView;
@property (strong,nonatomic  ) TPDVehicleLengthView * vehicleLengthView;
@property (strong,nonatomic  ) UIButton * submitButton;
@property (nonatomic, strong) TPCertificationUploadImageView * headlightsUploadImageView;
@property (nonatomic, strong) TPCertificationUploadImageView * drivingLicenseUploadImageView;
@property (nonatomic, strong) UILabel * vehicleInfoTitleLabel;
@property (nonatomic, strong) UILabel * remarkTitleLabel;
@property (nonatomic, strong) UIView * uploadImageBackgroundView;
@property (nonatomic, strong) TPDVehicleRemarkView * driverNameView;
@property (nonatomic, strong) TPDVehicleRemarkView * driverMobileView;
@property (nonatomic, strong) TPDAddModifyVehicleDataManager * dataManager;

@end

@implementation TPDAddModifyVehicleViewController

+ (void)load {
    [TPDVehicleRouterEntry registerAddMOdifyVehicle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPBackgroundColor;
    [self vm_addSubviews];
    [self vm_juadeAddOrModify];
}

#pragma mark - Events
- (void)vm_submitButtonAction {
    
    //判断有没有车牌号
    if (!self.model.plate_no2.isNotBlank) {
        TPShowToast(@"请输入您的车牌号。");
        return;
    }
    
    //判断车牌号是否正确
    NSString * plateNo = [self.model.plate_no2 stringByAppendingString:self.model.plate_no3];
    BOOL isValidateNumberPlate = [plateNo checkNumberPlate];
    if (!isValidateNumberPlate) {
        TPShowToast(@"请输入正确的车牌号!");
        return;
    }
    
    //判断有无车型车长
    if (!self.model.truck_length_id.isNotBlank || !self.model.truck_type_id.isNotBlank) {
        TPShowToast(@"请选择您的车型车长。");
        return;
    }
    
    if (!self.model.plate_color.isNotBlank) {
        self.model.plate_color = @"1";
    }
    
    if (self.model.driver_truck_version.isNotBlank) { //修改车辆
        [self vm_modifyVehicleRequest];
    } else {//添加车辆
        [self vm_addVehicleRequest];
    }
}

#pragma mark - Private
- (void)vm_addVehicleRequest {
    @weakify(self);
    [self.dataManager addVehicleWithModel:self.model completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        if ( succeed && !error) {
            [TPHUD showAlertViewWithText:@"车辆信息提交成功。" handler:^{
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)vm_modifyVehicleRequest {
    @weakify(self);
    [self.dataManager modifyVehicleWithModel:self.model completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        if ( succeed && !error) {
            [TPHUD showAlertViewWithText:@"车辆信息修改成功。" handler:^{
                @strongify(self);
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)vm_juadeAddOrModify {
    if (self.model) {
        self.navigationItem.title = @"修改车辆信息";
        self.submitButton.enabled = YES;
        self.submitButton.selected = YES;
        TPDModifyVehicleViewModel * viewModel = [[TPDModifyVehicleViewModel alloc] initWithModel:self.model];
        self.colorPlateView.plateColor = viewModel.plateColor;
        self.numberPlateView.plateNo = viewModel.plateNo;
        self.numberPlateView.plateCity = viewModel.plateCity;
        self.vehicleLengthView.truckTypeLength = viewModel.truckTypeLength;
        self.driverNameView.content = viewModel.name;
        self.driverMobileView.content = viewModel.mobile;
        [self.headlightsUploadImageView setImageUrlString:self.model.truck_icon_url key:self.model.truck_icon_key auditStatus:TPCertificationStatus_NotCertified];
        [self.drivingLicenseUploadImageView setImageUrlString:self.model.truck_license_url key:self.model.truck_license_key auditStatus:TPCertificationStatus_NotCertified];
    } else {
        self.navigationItem.title = @"添加车辆";
        self.model = [[TPDAddModifyVehicleModel alloc]init];
        self.model.plate_no1 = @"沪";
        self.model.plate_color = @"2";
        self.submitButton.enabled = NO;
        self.submitButton.selected = NO;
    }
}

- (void)vm_addSubviews {
    self.view.backgroundColor = TPBackgroundColor;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.submitButton];
    [self.scrollView addSubview:self.numberPlateView];
    [self.scrollView addSubview:self.vehicleInfoTitleLabel];
    [self.scrollView addSubview:self.remarkTitleLabel];
    [self.scrollView addSubview:self.colorPlateView];
    [self.scrollView addSubview:self.vehicleLengthView];
    [self.scrollView addSubview:self.uploadImageBackgroundView];
    [self.scrollView addSubview:self.driverNameView];
    [self.scrollView addSubview:self.driverMobileView];
    [self.uploadImageBackgroundView addSubview:self.headlightsUploadImageView];
    [self.uploadImageBackgroundView addSubview:self.drivingLicenseUploadImageView];
    
    [self vm_setupConstraints];
}

- (void)vm_setupConstraints {
    
    [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.submitButton.mas_top);
    }];
    
    [self.vehicleInfoTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView.mas_left).offset(TPAdaptedWidth(12));
        make.height.mas_equalTo(TPAdaptedHeight(36));
    }];
    
    [self.numberPlateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vehicleInfoTitleLabel.mas_bottom);
        make.left.width.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(54));
    }];
    
    [self.colorPlateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.numberPlateView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(54));
    }];
    
    [self.vehicleLengthView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.colorPlateView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(54));
    }];
    
    [self.uploadImageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.vehicleLengthView.mas_bottom).offset(TPAdaptedHeight(12));
        make.left.right.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(146));
    }];
    
    [self.headlightsUploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.uploadImageBackgroundView);
        make.left.equalTo(self.uploadImageBackgroundView.mas_left).offset(TPAdaptedWidth(12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];
    
    [self.drivingLicenseUploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.uploadImageBackgroundView);
        make.right.equalTo(self.uploadImageBackgroundView.mas_right).offset(TPAdaptedWidth(-12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];
    
    [self.remarkTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView.mas_left).offset(TPAdaptedWidth(12));
        make.top.equalTo(self.uploadImageBackgroundView.mas_bottom);
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

- (void)vm_submitButtonSetupEnble {
    if (self.model.truck_type_id && self.model.truck_length_id && self.model.plate_no2) {
        self.submitButton.enabled = YES;
        self.submitButton.selected = YES;
    } else {
        self.submitButton.enabled = NO;
        self.submitButton.selected = NO;
    }
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (TPCertificationUploadImageView *)headlightsUploadImageView {
    if (!_headlightsUploadImageView) {
        _headlightsUploadImageView = [[TPCertificationUploadImageView alloc]initWithTitle:@"上传车头照" selectImageTitle:@"车头像" exampleImage:[UIImage imageNamed:@"certification_vehiclecertification_headlights_example"] selectImageMessage:@"请按照示例提交真实照片，确保清晰，无遮挡。" isImageEdit:YES selectImageStyle:SelectImageView_Style_Camera];
        @weakify(self);
        _headlightsUploadImageView.imageSelectedCompleteBlock = ^(NSString *currentImageBase64) {
            @strongify(self);
            self.model.truck_icon_img = currentImageBase64;
            self.model.truck_icon_key = nil;
            self.model.truck_icon_url = nil;
        };
        
    }
    return _headlightsUploadImageView;
}

- (TPCertificationUploadImageView *)drivingLicenseUploadImageView {
    if (!_drivingLicenseUploadImageView) {
        _drivingLicenseUploadImageView = [[TPCertificationUploadImageView alloc]initWithTitle:@"上传行驶证" selectImageTitle:@"行驶证" exampleImage:[UIImage imageNamed:@"certification_vehiclecertification_vehiclelicense_example"] selectImageMessage:@"请按照示例提交真实照片，确保清晰，无遮挡。" isImageEdit:YES selectImageStyle:SelectImageView_Style_Camera];
        @weakify(self);
        _drivingLicenseUploadImageView.imageSelectedCompleteBlock = ^(NSString *currentImageBase64) {
            @strongify(self);
            self.model.truck_license_img = currentImageBase64;
            self.model.truck_license_key = nil;
            self.model.truck_license_url = nil;
        };
    }
    return _drivingLicenseUploadImageView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.titleLabel.font = TPAdaptedFontSize(17);
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.backgroundColor = TPUNEnbleColor_LineColor;
        _submitButton.enabled = NO;
        [_submitButton addTarget:self action:@selector(vm_submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        UIImage * selectedBackgroundImage = [UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth, TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor];
        [_submitButton setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
        [_submitButton setBackgroundImage:nil forState:UIControlStateNormal];
    }
    return _submitButton;
}

- (UIView *)uploadImageBackgroundView {
    if (!_uploadImageBackgroundView) {
        _uploadImageBackgroundView = [[UIView alloc]init];
        _uploadImageBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _uploadImageBackgroundView;
}

- (TPDNumberPlateView *)numberPlateView {
    if (!_numberPlateView) {
        _numberPlateView = [[TPDNumberPlateView alloc]init];
        _numberPlateView.backgroundColor = [UIColor whiteColor];
        @weakify(self);
        _numberPlateView.addressPlateCompleteBlock = ^(NSString *plateNo1) {
            @strongify(self);
            self.model.plate_no1 = plateNo1;
        };
        _numberPlateView.numberPlateCompleteBlock = ^(NSString *plateNo2, NSString *plateNo3) {
            @strongify(self);
            self.model.plate_no2 = plateNo2;
            self.model.plate_no3 = plateNo3;
            [self vm_submitButtonSetupEnble];
        };
    }
    return _numberPlateView;
}

- (TPDColorPlateView *)colorPlateView {
    if (!_colorPlateView) {
        _colorPlateView = [[TPDColorPlateView alloc]init];
        _colorPlateView.backgroundColor = [UIColor whiteColor];
        @weakify(self);
        _colorPlateView.colorPlateCompleteBlock = ^(NSString *plateColor) {
            @strongify(self);
            self.model.plate_color = plateColor;
        };
    }
    return _colorPlateView;
}

- (TPDVehicleLengthView *)vehicleLengthView {
    if (!_vehicleLengthView) {
        _vehicleLengthView = [[TPDVehicleLengthView alloc]init];
        _vehicleLengthView.backgroundColor = [UIColor whiteColor];
        @weakify(self);
        _vehicleLengthView.vehicleLengCompleteBlock = ^(NSString *truckLengthId, NSString *truckTypeId) {
            @strongify(self);
            self.model.truck_type_id = truckTypeId;
            self.model.truck_length_id = truckLengthId;
            [self vm_submitButtonSetupEnble];
        };
    }
    return _vehicleLengthView;
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

- (TPDVehicleRemarkView *)driverNameView {
    if (!_driverNameView) {
        _driverNameView = [[TPDVehicleRemarkView alloc] initWithType:TPDVehicleRemarkViewType_Name];
        @weakify(self);
        _driverNameView.completeBlock = ^(NSString *text) {
            @strongify(self);
            self.model.driver_name = text;
        };
    }
    return _driverNameView;
}

- (TPDVehicleRemarkView *)driverMobileView {
    if (!_driverMobileView) {
        _driverMobileView = [[TPDVehicleRemarkView alloc] initWithType:TPDVehicleRemarkViewType_Mobile];
        @weakify(self);
        _driverMobileView.completeBlock = ^(NSString *text) {
            @strongify(self);
            self.model.driver_mobile = text;
        };
    }
    return _driverMobileView;
}

- (TPDAddModifyVehicleDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDAddModifyVehicleDataManager alloc]init];
    }
    return _dataManager;
}

@end
