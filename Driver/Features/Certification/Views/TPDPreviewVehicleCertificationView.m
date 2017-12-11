//
//  TPDPreviewVehicleCertificationView.m
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDPreviewVehicleCertificationView.h"
#import "TPDVehicleRouterEntry.h"
#import "TPDVehicleDetailView.h"
#import "TPTipsView.h"
#import "TPCertificationUploadImageView.h"
#import "TPDVehicleCertificationViewModel.h"
#import "TPDVehicleCertificationModel.h"

@interface TPDPreviewVehicleCertificationView ()
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) TPDVehicleDetailView * plateNumberView;
@property (nonatomic, strong) TPDVehicleDetailView * plateColorView;
@property (nonatomic, strong) TPDVehicleDetailView * vehicleLengthView;
@property (nonatomic, strong) TPCertificationUploadImageView * headlightsUploadImageView;
@property (nonatomic, strong) TPCertificationUploadImageView * drivingLicenseUploadImageView;
@property (nonatomic, strong) UIView * imageBackgroundView;
@property (nonatomic,strong) TPTipsView * tipsView;

@end

@implementation TPDPreviewVehicleCertificationView

- (instancetype)init {
    if (self = [super init]) {
        [self vd_addSubviews];
    }
    return self;
}

#pragma mark - Private
- (void)vd_addSubviews {
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.plateNumberView];
    [self.scrollView addSubview:self.tipsView];
    [self.scrollView addSubview:self.plateColorView];
    [self.scrollView addSubview:self.vehicleLengthView];
    [self.scrollView addSubview:self.imageBackgroundView];
    [self.imageBackgroundView addSubview:self.headlightsUploadImageView];
    [self.imageBackgroundView addSubview:self.drivingLicenseUploadImageView];
    [self vd_setupConstraints];
}

- (void)vd_setupConstraints {
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.tipsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(self.tipsView.contentStringHight + TPAdaptedHeight(22));
    }];
    
    [self.plateNumberView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsView.mas_bottom);
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
        make.left.width.bottom.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(146));
    }];
    
    [self.headlightsUploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageBackgroundView);
        make.left.equalTo(self.imageBackgroundView.mas_left).offset(TPAdaptedWidth(12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];
    
    [self.drivingLicenseUploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imageBackgroundView);
        make.right.equalTo(self.imageBackgroundView.mas_right).offset(TPAdaptedWidth(-12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];
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
    self.plateNumberView.content = viewModel.plate;
    self.plateColorView.content = viewModel.plateColor;
    self.vehicleLengthView.content = viewModel.truckTypeLength;
    self.tipsView.contentString = viewModel.model.audit_status_remark;
    [self.headlightsUploadImageView setImageUrlString:viewModel.model.truck_head_img_url key:viewModel.model.truck_head_img_key auditStatus:[self vc_certificationStatusWithAuditStatus:viewModel.model.audit_status]];
    [self.drivingLicenseUploadImageView setImageUrlString:viewModel.model.driver_license_img_url key:viewModel.model.driver_license_img_key auditStatus:[self vc_certificationStatusWithAuditStatus:viewModel.model.audit_status]];
    [self.tipsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.tipsView.contentStringHight + TPAdaptedHeight(22));
    }];
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

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

- (UIView *)imageBackgroundView {
    if (!_imageBackgroundView) {
        _imageBackgroundView = [[UIView alloc]init];
        _imageBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _imageBackgroundView;
}

- (TPCertificationUploadImageView *)headlightsUploadImageView {
    if (!_headlightsUploadImageView) {
        _headlightsUploadImageView = [[TPCertificationUploadImageView alloc]initWithTitle:@"上传车头照" selectImageTitle:@"车头像" exampleImage:[UIImage imageNamed:@"certification_vehiclecertification_headlights_example"] selectImageMessage:@"请按照示例提交真实照片，确保清晰，无遮挡。" isImageEdit:YES selectImageStyle:SelectImageView_Style_Camera];
    }
    return _headlightsUploadImageView;
}

- (TPCertificationUploadImageView *)drivingLicenseUploadImageView {
    if (!_drivingLicenseUploadImageView) {
        _drivingLicenseUploadImageView = [[TPCertificationUploadImageView alloc]initWithTitle:@"上传行驶证" selectImageTitle:@"行驶证" exampleImage:[UIImage imageNamed:@"certification_vehiclecertification_vehiclelicense_example"] selectImageMessage:@"请按照示例提交真实照片，确保清晰，无遮挡。" isImageEdit:YES selectImageStyle:SelectImageView_Style_Camera];
    }
    return _drivingLicenseUploadImageView;
}

- (TPTipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [[TPTipsView alloc]initWithContentString:@"认证可以提高信誉度，增快成交速度，享受平台优惠政策。"];
    }
    return _tipsView;
}

@end

