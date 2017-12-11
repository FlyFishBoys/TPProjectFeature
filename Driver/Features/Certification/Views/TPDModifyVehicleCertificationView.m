
//
//  TPDModifyVehicleCertificationView.m
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDModifyVehicleCertificationView.h"
#import "TPDNumberPlateView.h"
#import "TPDColorPlateView.h"
#import "TPDVehicleLengthView.h"
#import "TPCertificationUploadImageView.h"
#import "TPDVehicleCertificationModel.h"
#import "TPNormalRefreshGifHeader.h"
#import "TPTipsView.h"
#import "TPProgressView.h"
#import "UIImage+Gradient.h"
#import "NSString+Regular.h"
#import "TPDVehicleCertificationViewModel.h"

@interface TPDModifyVehicleCertificationView ()
{
    BOOL _isRegistered;
}
@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) TPTipsView * tipsView;
@property (nonatomic,strong) TPProgressView * progressView;
@property (strong,nonatomic  ) TPDNumberPlateView * numberPlateView;
@property (strong,nonatomic  ) TPDColorPlateView * colorPlateView;
@property (strong,nonatomic  ) TPDVehicleLengthView * vehicleLengthView;
@property (strong,nonatomic  ) UIButton * submitButton;
@property (nonatomic, strong) TPCertificationUploadImageView * headlightsUploadImageView;
@property (nonatomic, strong) TPCertificationUploadImageView * drivingLicenseUploadImageView;
@property (nonatomic, strong) UIView * uploadImageBackgroundView;
@property (nonatomic, strong) TPDVehicleCertificationModel * model;

@end

@implementation TPDModifyVehicleCertificationView

- (instancetype)initWithIsRegistered:(BOOL)isRegistered {
    if (self = [super init]) {
        _isRegistered = isRegistered;
        [self vc_addSubviews];
    }
    return self;
}

#pragma mark - Private
- (void)vc_addSubviews {
    self.backgroundColor = TPBackgroundColor;
    [self addSubview:self.scrollView];
    [self addSubview:self.submitButton];
    [self.scrollView addSubview:self.tipsView];
    [self.scrollView addSubview:self.progressView];
    [self.scrollView addSubview:self.numberPlateView];
    [self.scrollView addSubview:self.colorPlateView];
    [self.scrollView addSubview:self.vehicleLengthView];
    [self.scrollView addSubview:self.uploadImageBackgroundView];
    [self.uploadImageBackgroundView addSubview:self.headlightsUploadImageView];
    [self.uploadImageBackgroundView addSubview:self.drivingLicenseUploadImageView];
    
    [self vc_setupConstraints];
}

- (void)vc_setupConstraints {
    
    [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.submitButton.mas_top);
    }];
    
    [self.tipsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(self.tipsView.contentStringHight + TPAdaptedHeight(22));
    }];
    
    [self.progressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.tipsView.mas_bottom);
        make.height.mas_equalTo(_isRegistered ? TPAdaptedHeight(75) : 0);
    }];
    
    [self.numberPlateView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.progressView.mas_bottom).offset(_isRegistered ? TPAdaptedHeight(12) : 0);
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
        make.left.width.bottom.equalTo(self.scrollView);
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
}
- (void)vc_submitButtonSetupEnble {
    if (self.model.truck_head_img && self.model.driver_license_img) {
        self.submitButton.enabled = YES;
        self.submitButton.selected = YES;
    } else {
        self.submitButton.enabled = NO;
        self.submitButton.selected = NO;
    }
}

#pragma mark - Events
- (void)vc_pullDownToRefreshAction {
    [self.scrollView.mj_header endRefreshing];
}

- (void)vc_submitButtonAction {
    
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
    if (!self.model.truck_lengthId.isNotBlank || !self.model.truck_typeId.isNotBlank) {
        TPShowToast(@"请选择您的车型车长。");
        return;
    }
    
    if (!self.model.plate_color.isNotBlank) {
        self.model.plate_color = @"1";
    }
    
    if (self.modifyBlock) {
        self.modifyBlock(self.model);
    }
}

- (TPCertificationStatus)vc_certificationStatusWithAuditStatus:(NSString *)auditStatus {
    switch (auditStatus.integerValue) {
        case 0:
        case 1:
            return TPCertificationStatus_NotCertified;
            break;
            
        case 2:
            return TPCertificationStatus_Success;
            break;
            
        case 3:
            return TPCertificationStatus_Processing;
            break;
            
        case 4:
            return TPCertificationStatus_Failure;
            break;
            
        default:
            return TPCertificationStatus_NotCertified;
            break;
    }
}

#pragma mark - getters and setters
- (void)setViewModel:(TPDVehicleCertificationViewModel *)viewModel {
    _viewModel = viewModel;
    self.model = viewModel.model;
    self.numberPlateView.plateCity = viewModel.plateCity;
    self.numberPlateView.plateNo = viewModel.plateNo;
    self.colorPlateView.plateColor = viewModel.model.plate_color;
    self.vehicleLengthView.truckTypeLength = viewModel.truckTypeLength;
    self.numberPlateView.isEnble = viewModel.isEnble;
    self.colorPlateView.isEnble = viewModel.isEnble;
    self.vehicleLengthView.isEnble = viewModel.isEnble;
    self.tipsView.contentString = viewModel.model.audit_status_remark;
    [self.headlightsUploadImageView setImageUrlString:viewModel.model.truck_head_img_url key:viewModel.model.truck_head_img_key auditStatus:[self vc_certificationStatusWithAuditStatus:viewModel.model.audit_status]];
    [self.drivingLicenseUploadImageView setImageUrlString:viewModel.model.driver_license_img_url key:viewModel.model.driver_license_img_key auditStatus:[self vc_certificationStatusWithAuditStatus:viewModel.model.audit_status]];
    [self.tipsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.tipsView.contentStringHight + TPAdaptedHeight(22));
    }];
}

- (TPCertificationUploadImageView *)headlightsUploadImageView {
    if (!_headlightsUploadImageView) {
        _headlightsUploadImageView = [[TPCertificationUploadImageView alloc]initWithTitle:@"上传车头照" selectImageTitle:@"车头像" exampleImage:[UIImage imageNamed:@"certification_vehiclecertification_headlights_example"] selectImageMessage:@"请按照示例提交真实照片，确保清晰，无遮挡。" isImageEdit:YES selectImageStyle:SelectImageView_Style_Camera];
        @weakify(self);
        _headlightsUploadImageView.imageSelectedCompleteBlock = ^(NSString *currentImageBase64) {
            @strongify(self);
            self.model.truck_head_img = currentImageBase64;
            self.model.truck_head_img_key = @"";
            [self vc_submitButtonSetupEnble];
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
            self.model.driver_license_img = currentImageBase64;
            self.model.driver_license_img_key = @"";
            [self vc_submitButtonSetupEnble];
        };
    }
    return _drivingLicenseUploadImageView;
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
            self.model.truck_typeId = truckTypeId;
            self.model.truck_lengthId = truckLengthId;
        };
    }
    return _vehicleLengthView;
}

- (TPDVehicleCertificationModel *)model {
    if (!_model) {
        _model = [[TPDVehicleCertificationModel alloc]init];
        _model.plate_color = @"2";
        _model.plate_no1 = @"h沪";
    }
    return _model;
}

- (TPTipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [[TPTipsView alloc]initWithContentString:@"认证可以提高信誉度，增快成交速度，享受平台优惠政策。"];
    }
    return _tipsView;
}

- (TPProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[TPProgressView alloc]initWithSelectedImageName:@"common_progress_selected" defaultImageName:@"common_progress_normal" highlightedImageName:nil isBottomLine:NO margin:TPAdaptedWidth(64)];
        _progressView.titleArray = @[@"实名认证",@"身份认证",@"车辆认证"];
        _progressView.highlightedIndex = 3;
        _progressView.backgroundColor = [UIColor whiteColor];
        _progressView.clipsToBounds = YES;
    }
    return _progressView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
//        _scrollView.mj_header = [TPNormalRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(vc_pullDownToRefreshAction)];
    }
    return _scrollView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.titleLabel.font = TPAdaptedFontSize(17);
        [_submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        _submitButton.backgroundColor = TPUNEnbleColor_LineColor;
        _submitButton.clipsToBounds = YES;
        _submitButton.enabled = NO;
        [_submitButton addTarget:self action:@selector(vc_submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
        UIImage * selectedBackgroundImage = [UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth, TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor];
        [_submitButton setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
        [_submitButton setBackgroundImage:nil forState:UIControlStateNormal];
    }
    return _submitButton;
}

@end


