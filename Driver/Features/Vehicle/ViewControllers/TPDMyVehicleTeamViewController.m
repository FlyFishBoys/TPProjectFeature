//
//  TPDMyVehicleTeamViewController.m
//  Driver
//
//  Created by Mr.mao on 2017/10/18.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyVehicleTeamViewController.h"
#import "TPBaseTableView.h"
#import "TPDMyVehicleTeamDataSource.h"
#import "TPDVehicleRouterEntry.h"
#import "TPDMyVehicleTeamViewModel.h"
#import "TPDMyVehicleTeamCell.h"
#import "TPDMyVehicleTeamBottomView.h"
#import "TPDMyVehicleTeamModel.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPAlertView.h"

@interface TPDMyVehicleTeamViewController ()<TPBaseTableViewDelegate,TPDMyVehicleTeamCellDelegate>
@property (nonatomic, strong) TPBaseTableView * tableView;
@property (nonatomic,strong) TPDMyVehicleTeamBottomView * bottomView;
@property (nonatomic, strong) TPDMyVehicleTeamDataSource * dataSource;

@end

@implementation TPDMyVehicleTeamViewController

+ (void)load {
    [TPDVehicleRouterEntry registerVehicleMyVehicleTeam];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的车队";
    self.view.backgroundColor = TPBackgroundColor;
    [self vt_setupSubviews];
    [self vt_addRightItem];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView triggerRefreshing];

}

#pragma mark TPBaseTableViewDelegate
- (void)didSelectObject:(TPDMyVehicleTeamItemViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    //第一辆车去车辆认证，其他的进入车辆详情
    if (indexPath.row == 0) {
        [TPRouterAnalytic openInteriorURL:TPRouter_VehicleCertification_Conteroller parameter:nil type:PUSHCONTROLLERTYPE_PUSH];
       
    } else {
        TPDMyVehicleTeamModel * model = object.model;
        [TPRouterAnalytic openInteriorURL:TPRouter_Vehicle_Detail parameter:@{@"driverTruckId" : model.driver_truck_id ? : @""} type:PUSHCONTROLLERTYPE_PUSH];
    }
}

- (void)pullDownToRefreshAction {
    @weakify(self);
    [self.dataSource refreshMyVehicleTeamWithCompleteBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];

        if (error == nil && succeed) {
            [self.tableView reloadDataSource];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)pullUpToRefreshAction {
    
    @weakify(self);
    [self.dataSource loadMoreMyVehicleTeamWithCompleteBlock:^(BOOL succeed, TPBusinessError * _Nullable error, NSInteger listCount) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];
        
        if (error == nil && succeed) {
            if (listCount) {
                [self.tableView reloadDataSource];
            } else {
                TPShowToast(@"已加载全部数据！");
            }
            
        } else {
            TPShowToast(error.business_msg);
        }
    }];
    
}

#pragma mark - TPDMyVehicleTeamCellDelegate
//求货/休息状态切换
- (void)myVehicleTeamCell:(TPDMyVehicleTeamCell *)myVehicleTeamCell driverTruckId:(NSString *)driverTruckId truckStatus:(NSString *)truckStatus button:(UIButton *)button {
    truckStatus = [truckStatus isEqualToString:@"1"] ? @"2" : @"1";
    [self.dataSource switchSeekGoodsStatusWithDriverTruckId:driverTruckId truckStatus:truckStatus completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        if (error == nil && succeed) {
            button.selected = !button.selected;
            TPShowToast(@"状态设置成功");
        } else {
            TPShowToast(error.business_msg);
        }
    }];

}

//去添加车辆
- (void)vt_pushToAddVehicle {
    
    TPBaseTableViewSectionObject * section = self.dataSource.sections.firstObject;
    TPDMyVehicleTeamItemViewModel * item = section.items.firstObject;
    TPDMyVehicleTeamModel * model = item.model;
     if ([model.audit_status isEqualToString:@"3"]) {//认证中弹出提示
        TPShowToast(@"您的车辆认证信息还在认证中，无法进行此操作，请耐心等待认证结果！");
    } else if ([model.audit_status isEqualToString:@"4"]) {//认证失败时，点击“添加车辆”弹出弹框,点击【稍后再说】关闭弹框，点击【重新认证】跳转至车辆认证页面，
        TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"对不起，您的车辆认证审核未通过，暂无法使用该功能，请重新提交审核。" delegate:self cancelButtonTitle:@"稍后再说" otherButtonTitles:@"重新认证", nil];
        alertView.otherButtonAction = ^{
            [TPRouterAnalytic openInteriorURL:TPRouter_VehicleCertification_Conteroller parameter:nil type:PUSHCONTROLLERTYPE_PUSH];
           
        };
        [alertView show];
    } else if ([model.audit_status isEqualToString:@"2"]) {//已认证：添加车辆
        [TPRouterAnalytic openInteriorURL:TPRouter_Vehicle_Add_Modify parameter:nil type:PUSHCONTROLLERTYPE_PUSH];
       
    } else {//没有车，或未认证，进入车辆认证
        [TPRouterAnalytic openInteriorURL:TPRouter_VehicleCertification_Conteroller parameter:nil type:PUSHCONTROLLERTYPE_PUSH];
      
    }
}

#pragma mark - Privates
- (void)vt_addRightItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加车辆" style:UIBarButtonItemStylePlain target:self action:@selector(vt_pushToAddVehicle)];
}

- (void)vt_setupSubviews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self vt_setupConstraints];
}

- (void)vt_setupConstraints {
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
}

#pragma mark - Setters and Getters
- (TPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] init];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.isNeedPullDownToRefreshAction = YES;
        _tableView.isNeedPullUpToRefreshAction = YES;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
    }
    return _tableView;
}

- (TPDMyVehicleTeamBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[TPDMyVehicleTeamBottomView alloc]init];
        @weakify(self);
        _bottomView.swithAllStatusBlock = ^(NSString *truckStatus) {
            @strongify(self);
            [self.dataSource switchSeekGoodsStatusAllWithTruckStatus:truckStatus completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
                if (succeed && error == nil) {
                    NSString * alert;
                    if ([truckStatus isEqualToString:@"1"]) {
                        alert = @"全部求货设置成功";
                    } else {
                        alert = @"全部休息设置成功";
                    }
                    [TPHUD showAlertViewWithText:alert handler:^{
                        @strongify(self);
                        [self.tableView triggerRefreshing];
                    }];
                } else {
                    TPShowToast(error.business_msg);
                }
            }];
        };

    }
    return _bottomView;
}

- (TPDMyVehicleTeamDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TPDMyVehicleTeamDataSource alloc] initWithTarget:self];
    }
    return _dataSource;
}

@end
