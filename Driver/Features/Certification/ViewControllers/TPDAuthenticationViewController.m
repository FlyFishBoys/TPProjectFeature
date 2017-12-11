//
//  TPDAuthenticationViewController.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAuthenticationViewController.h"
#import "TPTipsView.h"
#import "TPProgressView.h"
#import "TPCertificationUploadImageView.h"
#import "TPNormalRefreshGifHeader.h"
#import "UIImage+Gradient.h"
#import "TPDModifyAuthenticationAPI.h"
#import "TPDAuthenticationModel.h"
#import "NSObject+CurrentController.h"
#import "TPDCertificationRouterEntry.h"
#import "TPDAuthenticationDataManager.h"

@interface TPDAuthenticationViewController ()
@property (nonatomic,strong) TPTipsView * tipsView;
@property (nonatomic,strong) TPProgressView * progressView;
@property (nonatomic,strong) UIScrollView * scrollView;
@property (strong,nonatomic  ) UIButton * submitButton;
@property (nonatomic, strong) TPCertificationUploadImageView * driverLicenseUploadImageView;
@property (nonatomic, strong) TPCertificationUploadImageView * operatingUploadImageView;
@property (nonatomic, strong) UIView * uploadImageBackgroundView;
@property (nonatomic, strong) TPDAuthenticationModel * authenticationModel;
@property (nonatomic, strong) TPDAuthenticationDataManager * dataManager;

@end

@implementation TPDAuthenticationViewController

+ (void)load {
    
    [TPDCertificationRouterEntry registerAuthentication];
}

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"身份认证";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = TPBackgroundColor;
//    if (@available(iOS 11.0, *)) {
//        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;

    [self au_setupNavigationItem];
    if (!self.isRegistered) {
        [self au_loadAuthentication];
    } else {
        [self au_addSubviews];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //开启右滑返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isRegistered) {
        //关闭右滑返回
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

#pragma mark - Events
- (void)au_pullDownToRefreshAction {
    
    [self.scrollView.mj_header endRefreshing];
}

- (void)au_submitButtonAction {
    
    [self.dataManager modifyAuthenticationWithModel:self.authenticationModel completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        if ( succeed && !error) {
            if (self.isRegistered) {
                //去车辆认证
                [TPRouterAnalytic openInteriorURL:TPRouter_VehicleCertification_Conteroller parameter:@{@"isRegistered":@"1"} type:PUSHCONTROLLERTYPE_PUSH];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)au_rightBarButtonItemAction {
    //去车辆认证
    [TPRouterAnalytic openInteriorURL:TPRouter_VehicleCertification_Conteroller parameter:@{@"isRegistered":@"1"} type:PUSHCONTROLLERTYPE_PUSH];

}

#pragma mark - Private
- (void)au_loadAuthentication {
    @weakify(self);
    [self.dataManager getAuthenticationWithCompleteBlock:^(BOOL succeed, TPBusinessError * _Nullable error, TPDAuthenticationModel * _Nullable model) {
        @strongify(self);
        if ( succeed && !error) {
            [self au_addSubviews];
            self.authenticationModel = model;
            self.tipsView.contentString = model.user_auth_remark;
            TPCertificationStatus certificationStatus = [self au_certificationStatusWithAuditStatus:model.user_auth_status];
            [self.driverLicenseUploadImageView setImageUrlString:model.driver_license_img_url key:model.driver_license_img_key auditStatus:certificationStatus];
            [self.operatingUploadImageView setImageUrlString:model.driver_operation_img_url key:model.driver_operation_img_key auditStatus:certificationStatus];
            [self.submitButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((certificationStatus == TPCertificationStatus_Success || certificationStatus == TPCertificationStatus_Processing) ? 0 : TPAdaptedHeight(44));
            }];
            [self.tipsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(self.tipsView.contentStringHight + TPAdaptedHeight(22));
            }];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (TPCertificationStatus)au_certificationStatusWithAuditStatus:(NSString *)auditStatus {
    switch (auditStatus.integerValue) {
        case 0:
            return TPCertificationStatus_NotCertified;
            break;
            
        case 1:
            return TPCertificationStatus_Processing;
            break;
            
        case 2:
            return TPCertificationStatus_Failure;
            break;
            
        case 3:
            return TPCertificationStatus_Success;
            break;
            
        default:
            return TPCertificationStatus_NotCertified;
            break;
    }
}

//设置导航条有无返回按钮，有无跳过按钮
- (void)au_setupNavigationItem {
    if (!self.isRegistered)  return;
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(au_rightBarButtonItemAction)];
}


- (void)au_addSubviews {
    self.view.backgroundColor = TPBackgroundColor;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.submitButton];
    [self.scrollView addSubview:self.tipsView];
    [self.scrollView addSubview:self.progressView];
    [self.scrollView addSubview:self.uploadImageBackgroundView];
    [self.uploadImageBackgroundView addSubview:self.driverLicenseUploadImageView];
    [self.uploadImageBackgroundView addSubview:self.operatingUploadImageView];
    
    [self au_setupConstraints];
}

- (void)au_setupConstraints {
    
    [self.submitButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
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
        make.height.mas_equalTo(self.isRegistered ? TPAdaptedHeight(75) : 0);
    }];
    
    [self.uploadImageBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.progressView.mas_bottom).offset(self.isRegistered ? TPAdaptedHeight(12) : 0);
        make.left.width.bottom.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(146));
    }];
    
    [self.driverLicenseUploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.uploadImageBackgroundView);
        make.left.equalTo(self.uploadImageBackgroundView.mas_left).offset(TPAdaptedWidth(12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];
    
    [self.operatingUploadImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.uploadImageBackgroundView);
        make.right.equalTo(self.uploadImageBackgroundView.mas_right).offset(TPAdaptedWidth(-12));
        make.width.mas_equalTo(TPAdaptedWidth(170));
        make.height.mas_equalTo(TPAdaptedHeight(114));
    }];
}

//设置底部按钮的点击状态
- (void)au_submitButtonSetupEnble {
    if (self.authenticationModel.driver_license_img || self.authenticationModel.driver_operation_img) {
        self.submitButton.enabled = YES;
        self.submitButton.selected = YES;
    } else {
        self.submitButton.enabled = NO;
        self.submitButton.selected = NO;
    }
}

#pragma mark - getters and setters
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
        _progressView.highlightedIndex = 2;
        _progressView.backgroundColor = [UIColor whiteColor];
        _progressView.clipsToBounds = YES;
    }
    return _progressView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
//        _scrollView.mj_header = [TPNormalRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(au_pullDownToRefreshAction)];
    }
    return _scrollView;
}

- (TPCertificationUploadImageView *)driverLicenseUploadImageView {
    if (!_driverLicenseUploadImageView) {
        _driverLicenseUploadImageView = [[TPCertificationUploadImageView alloc]initWithTitle:@"上传驾驶证" selectImageTitle:@"驾驶证" exampleImage:[UIImage imageNamed:@"certification_authentication_driverlicense_example"] selectImageMessage:@"请按照示例提交真实照片，确保清晰，无遮挡。" isImageEdit:YES selectImageStyle:SelectImageView_Style_Camera];
        _driverLicenseUploadImageView.remarks = @"（个体司机必填）";
        @weakify(self);
        _driverLicenseUploadImageView.imageSelectedCompleteBlock = ^(NSString *currentImageBase64) {
            @strongify(self);
            self.authenticationModel.driver_license_img = currentImageBase64;
            self.authenticationModel.driver_license_img_key = @"";
            [self au_submitButtonSetupEnble];
        };
    }
    return _driverLicenseUploadImageView;
}

- (TPCertificationUploadImageView *)operatingUploadImageView {
    if (!_operatingUploadImageView) {
        _operatingUploadImageView = [[TPCertificationUploadImageView alloc]initWithTitle:@"上传营运证" selectImageTitle:@"营运证" exampleImage:[UIImage imageNamed:@"certification_authentication_operating_example"] selectImageMessage:@"请按照示例提交真实照片，确保清晰，无遮挡。" isImageEdit:YES selectImageStyle:SelectImageView_Style_Camera];
        _operatingUploadImageView.remarks = @"（企业用户必填）";
        @weakify(self);
        _operatingUploadImageView.imageSelectedCompleteBlock = ^(NSString *currentImageBase64) {
            @strongify(self);
            self.authenticationModel.driver_operation_img = currentImageBase64;
            self.authenticationModel.driver_operation_img_key = @"";
            [self au_submitButtonSetupEnble];
        };
    }
    return _operatingUploadImageView;
}

- (UIButton *)submitButton {
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.titleLabel.font = TPAdaptedFontSize(17);
        [_submitButton setTitle:@"提交审核" forState:UIControlStateNormal];
        _submitButton.backgroundColor = TPUNEnbleColor_LineColor;
        _submitButton.clipsToBounds = YES;
        _submitButton.enabled = NO;
        [_submitButton addTarget:self action:@selector(au_submitButtonAction) forControlEvents:UIControlEventTouchUpInside];
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

- (TPDAuthenticationModel *)authenticationModel {
    if (!_authenticationModel) {
        _authenticationModel = [[TPDAuthenticationModel alloc]init];
        _authenticationModel.version = @"1";
    }
    return _authenticationModel;
}

- (TPDAuthenticationDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDAuthenticationDataManager alloc] init];
    }
    return _dataManager;
}

@end
