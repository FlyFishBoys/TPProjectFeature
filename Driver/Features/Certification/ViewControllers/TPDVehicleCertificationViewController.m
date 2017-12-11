//
//  TPDVehicleCertificationViewController.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleCertificationViewController.h"
#import "TPDCertificationRouterEntry.h"
#import "TPDVehicleCertificationDataManager.h"
#import "TPDVehicleCertificationModel.h"
#import "TPDVehicleCertificationViewModel.h"
#import "TPDModifyVehicleCertificationView.h"
#import "TPDPreviewVehicleCertificationView.h"

@interface TPDVehicleCertificationViewController ()
@property (nonatomic, strong) TPDVehicleCertificationDataManager * dataManager;
@property (nonatomic, strong) TPDModifyVehicleCertificationView * modifyView;
@property (nonatomic, strong) TPDPreviewVehicleCertificationView * unModifyView;

@end

@implementation TPDVehicleCertificationViewController

+ (void)load {
    
    [TPDCertificationRouterEntry registerVehicleCertification];
}

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"车辆认证";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = TPBackgroundColor;
    [self vc_setupNavigationItem];
    
    if (!self.isRegistered) {
        [self vc_loadCertification];
    } else {
        [self.view addSubview:self.modifyView];
        self.modifyView.frame = self.view.frame;
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
- (void)vc_rightBarButtonItemAction {
    //去首页
    [TPRouterAnalytic openInteriorURL:TPRouter_MainTabBar parameter:@{} completeBlock:nil];
   
}

#pragma mark - Private
- (void)vc_loadCertification {
    @weakify(self);
    [self.dataManager getVehicleCertificationWithCompleteBlock:^(BOOL succeed, TPBusinessError * _Nullable error, TPDVehicleCertificationViewModel *  _Nullable viewModel) {
        @strongify(self);
        if ( succeed && !error) {
            if ([viewModel.model.audit_status isEqualToString:@"2"] || [viewModel.model.audit_status isEqualToString:@"3"]) {
                [self.view addSubview:self.unModifyView];
                self.unModifyView.frame = self.view.frame;
                self.unModifyView.viewModel = viewModel;
            } else {
                [self.view addSubview:self.modifyView];
                self.modifyView.frame = self.view.frame;
                self.modifyView.viewModel = viewModel;
            }
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)vc_modifyCertificationWithModel:(TPDVehicleCertificationModel *)model {
    @weakify(self);
    [self.dataManager modifyVehicleCertificationWithModel:model completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        @strongify(self);
        if ( succeed && !error) {
            [TPHUD showAlertViewWithText:@"提交成功，您的资料正在进行审核，请耐心等待。" handler:^{
                @strongify(self);
                if (self.isRegistered) {
                    //去首页
          [TPRouterAnalytic openInteriorURL:TPRouter_MainTabBar parameter:@{} completeBlock:nil];
                } else {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
            
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

//设置导航条有无返回按钮，有无跳过按钮
- (void)vc_setupNavigationItem {
    if (!self.isRegistered)  return;
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setHidesBackButton:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(vc_rightBarButtonItemAction)];
}

#pragma mark - getters and setters
- (TPDVehicleCertificationDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDVehicleCertificationDataManager alloc] init];
    }
    return _dataManager;
}

- (TPDModifyVehicleCertificationView *)modifyView {
    if (!_modifyView) {
        _modifyView = [[TPDModifyVehicleCertificationView alloc] initWithIsRegistered:self.isRegistered];
        @weakify(self);
        _modifyView.modifyBlock = ^(TPDVehicleCertificationModel *model) {
            @strongify(self);
            [self vc_modifyCertificationWithModel:model];
        };
    }
    return _modifyView;
}

- (TPDPreviewVehicleCertificationView *)unModifyView {
    if (!_unModifyView) {
        _unModifyView = [[TPDPreviewVehicleCertificationView alloc] init];
    }
    return _unModifyView;
}

@end
