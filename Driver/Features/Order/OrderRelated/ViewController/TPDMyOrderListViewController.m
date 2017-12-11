//
//  TPDMyOrderListViewController.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyOrderListViewController.h"
#import "TPOrderSortView.h"
#import "TPBaseTableView.h"
#import "TPDMyOrderListDataSource.h"
#import "TPDMyOrderListCell.h"
#import "TPDMyOrderListViewModel.h"
#import "TPDMyOrderListModel.h"
#import "TPDEnterCodeView.h"
#import "TPCallCenter.h"

@interface TPDMyOrderListViewController ()<TPBaseTableViewDelegate,TPOrderSortViewDelegate,TPDMyOrderListCellDelegate>
{
    NSString * _status;
}
@property (nonatomic, strong) TPOrderSortView * sortView;
@property (nonatomic, strong) TPBaseTableView * tableView;
@property (nonatomic, strong) TPDMyOrderListDataSource * dataSource;
@property (nonatomic,strong) NSArray <NSString *> * myOrderTitleArray;

@end

@implementation TPDMyOrderListViewController

- (void)viewDidLoad {
    self.navigationItem.title = @"我的订单";
    _status = @"0";
    [self ol_setupNavigationBar];
    [self ol_setupSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self addRegularActivity];
    [self.tableView triggerRefreshing];
}

#pragma mark - TPDMyOrderListCellDelegate
- (void)myOrderListCell:(TPDMyOrderListCell *)myOrderListCell didClickButtonWithButtonType:(TPDMyOrderListCellButtonType)buttonType {
    
    
    TPDMyOrderListItemViewModel * itemViewMode = (TPDMyOrderListItemViewModel *)myOrderListCell.object;
    TPDMyOrderListModel * model = itemViewMode.model;
    
    switch (buttonType) {
        case TPDMyOrderListCellButtonType_MapNavigation:
        {
            [self ol_mapNavigationWithModel:model];
        }
            break;
            
        case TPDMyOrderListCellButtonType_ConfirmSignUp:
        {
            [self ol_goodsSignInWithModel:model];
        }
            break;
            
        case TPDMyOrderListCellButtonType_CallShipper:
        {
            [[TPCallCenter shareInstance]recordWithCalledUserMobile:model.owner_mobile userName:model.owner_name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:model.goods_id goodsStatus:nil callUpRecordBlock:nil];
        }
            break;
            
        case TPDMyOrderListCellButtonType_ConfirmPickUp:
        {
            [self ol_confirmPickupInWithModel:model];
        }
            break;
            
        case TPDMyOrderListCellButtonType_GiveUpTake:
        {
            [self ol_cancelDealWithModel:model];
        }
            break;
            
        case TPDMyOrderListCellButtonType_ToTake:
        {
            [self ol_confirmDealWithModel:model];
        }
            break;
            
        case TPDMyOrderListCellButtonType_Evaluation:
        {
            [self ol_evaluationWithModel:model];
        }
            break;
            
        case TPDMyOrderListCellButtonType_ViewEvaluation:
        {
            [self ol_viewEvaluationWithModel:model];
        }
            break;
            
        case TPDMyOrderListCellButtonType_FriendsShare:
        {
            @TODO("好友分享");
        }
            break;
    }
}

#pragma mark - TPOrderSortViewDelegate
-(void)orderSortView:(TPOrderSortView *)orderSortView didSelectAtIndex:(NSInteger)index {
    _status = [NSString stringWithFormat:@"%@",@(index)];
    [self.tableView triggerRefreshing];
}

#pragma mark - TPBaseTableViewDelegate
- (void)pullDownToRefreshAction {
    
    @weakify(self);
    [self.dataSource refreshMyOrderListWithStatus:_status completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
      
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
    [self.dataSource loadMoreMyOrderListWithStatus:_status completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, NSInteger listCount) {

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

- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath {
    TPDMyOrderListItemViewModel * itemViewMode = (TPDMyOrderListItemViewModel *)object;
    TPDMyOrderListModel * model = itemViewMode.model;
    [TPRouterAnalytic openInteriorURL:TPRouter_OrderDetail_Controller parameter:@{@"orderId":model.order_id ? : @""} type:PUSHCONTROLLERTYPE_PUSH];
}

#pragma mark - Events
/**
 我的报价
 */
- (void)ol_rightBarButtonItemAction {
    [TPRouterAnalytic openInteriorURL:TPRouter_QuotesList_Controller parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
  
}

#pragma mark - Privates
//确认签收
- (void)ol_goodsSignInWithModel:(TPDMyOrderListModel *)model {
    NSString * callTitle = model.receiver_info.mobile.isNotBlank ? @"呼叫收货人" : @"呼叫货主";
    NSString * mobile = model.receiver_info.mobile.isNotBlank ? model.receiver_info.mobile : model.owner_mobile;
    NSString * name = model.receiver_info.name.isNotBlank ? model.receiver_info.name : model.owner_name;
    TPDEnterCodeView * codeView = [[TPDEnterCodeView alloc]initWithCode:nil name:name moblie:mobile title:@"请输入签收码" callTitle:callTitle];
    @weakify(self);
    codeView.completeBlock = ^(TPDEnterCodeView *view, NSString *code) {
        @strongify(self);
        [self.dataSource goodsSignUpWithOrderId:model.order_id orderVersion:model.order_version unloadCode:code completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
            if (succeed) {
                self.sortView.selectedIndex = 3;
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };
    
    codeView.callBlock = ^{
        [[TPCallCenter shareInstance]recordWithCalledUserMobile:model.owner_mobile userName:model.owner_name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:model.goods_id goodsStatus:@"" callUpRecordBlock:nil];
    };
    [codeView show];
    
}

//确认提货
- (void)ol_confirmPickupInWithModel:(TPDMyOrderListModel *)model {
    NSString * callTitle = model.sender_info.mobile.isNotBlank ? @"呼叫发货人" : @"呼叫货主";
    NSString * mobile = model.sender_info.mobile.isNotBlank ? model.sender_info.mobile : model.owner_mobile;
    NSString * name = model.sender_info.name.isNotBlank ? model.sender_info.name : model.owner_name;
    TPDEnterCodeView * codeView = [[TPDEnterCodeView alloc]initWithCode:model.pickup_code  name:name moblie:mobile title:@"请输入提货码" callTitle:callTitle];
    @weakify(self);
    codeView.completeBlock = ^(TPDEnterCodeView *view, NSString *code) {
        @strongify(self);
        [self.dataSource confirmPickUpWithOrderId:model.order_id orderVersion:model.order_version pickupCode:code completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
            if (succeed) {
                [self pullDownToRefreshAction];
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };
    
    codeView.callBlock = ^{
        [[TPCallCenter shareInstance]recordWithCalledUserMobile:model.owner_mobile userName:model.owner_name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:model.goods_id goodsStatus:@"" callUpRecordBlock:nil];
    };
    [codeView show];
}

//确认承接
- (void)ol_confirmDealWithModel:(TPDMyOrderListModel *)model {
    @weakify(self);
    void(^tapAgree)(void)= ^{
        @strongify(self);
        [self.dataSource confirmDealWithOrderId:model.order_id orderVersion:model.order_version completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
            @strongify(self);
            if (succeed) {
                [self pullDownToRefreshAction];
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };

    [TPRouterAnalytic openInteriorURL:TPRouter_Contract_Controller parameter: @{@"viewType" : @"1",
                                                                               @"goodsId" : model.goods_id ? : @"",
                                                                               MGJRouterParameterCompletion:tapAgree
                                                                               
                                                                                } type:PUSHCONTROLLERTYPE_PUSH];
}

//放弃承接
- (void)ol_cancelDealWithModel:(TPDMyOrderListModel *)model {
    [self.dataSource cancelDealWithOrderId:model.order_id orderVersion:model.order_version completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        if (succeed) {
            [self pullDownToRefreshAction];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

//评价
- (void)ol_evaluationWithModel:(TPDMyOrderListModel *)model {
    UIViewController *vc = [TPRouterAnalytic interiorObjectForURL:TPRouter_Evaluate parameter:@{@"parameter":
                                                                                                    @{
                                                                                                        @"order_id":model.order_id.isNotBlank ? model.order_id : @"",
                                                                                                        @"version":model.order_version.isNotBlank ? model.order_version : @"",
                                                                                                        @"commented_user":model.owner_id.isNotBlank ? model.owner_id : @"",
                                                                                                        @"commented_name":model.owner_name.isNotBlank ? model.owner_name : @"",
                                                                                                        },
                                                                                                @"loadURL":TPWEB_URL_Evaluate
                                                                                                }];
    [self cyl_pushViewController:vc animated:YES];
    
}

//查看评价
- (void)ol_viewEvaluationWithModel:(TPDMyOrderListModel *)model {
    UIViewController *vc = [TPRouterAnalytic interiorObjectForURL:TPRouter_Evaluate parameter:@{@"parameter":
                                                                                                    @{
                                                                                                        @"order_id":model.order_id.isNotBlank ? model.order_id : @"",
                                                                                                        @"version":model.order_version.isNotBlank ? model.order_version : @"",
                                                                                                        },
                                                                                                }];
   
    [self cyl_pushViewController:vc animated:YES];
}
//添加定时红包
- (void)addRegularActivity {
    [TPRouterAnalytic openInteriorURL:TPRouter_RegularActivity parameter:@{
                                                                           @"presentController":self} completeBlock:nil];
}
//设置导航条
- (void)ol_setupNavigationBar {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的报价" style:UIBarButtonItemStylePlain target:self action:@selector(ol_rightBarButtonItemAction)];
}

//地图导航
- (void)ol_mapNavigationWithModel:(TPDMyOrderListModel *)model {
    //发货人地址信息
    NSString * pickupStatus = @"1";
    NSString * latitude = model.sender_info.latitude;
    NSString * longitude = model.sender_info.longitude;
    NSString * mobile = model.sender_info.mobile;
    if (model.order_status.integerValue > 5) {//收货人地址信息
        pickupStatus = @"2";
        latitude = model.receiver_info.latitude;
        longitude = model.receiver_info.longitude;
        mobile = model.receiver_info.mobile;
    }
    [TPRouterAnalytic openInteriorURL:TPRouter_Order_PathPlanning parameter:@{
                                                                              @"latitude":latitude ? : @"",
                                                                              @"longitude":longitude ? : @"",
                                                                              @"mobile":mobile ? : @"",
                                                                              @"pickupStatus":pickupStatus
                                                                              } type:PUSHCONTROLLERTYPE_PUSH];
}

- (void)ol_setupSubviews {
    
    [self.view addSubview:self.sortView];
    [self.view addSubview:self.tableView];

    [self ol_setupConstraints];
}

- (void)ol_setupConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.sortView.mas_bottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    [self.sortView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64);
        make.height.mas_equalTo(TPAdaptedHeight(40));
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

- (TPDMyOrderListDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TPDMyOrderListDataSource alloc] initWithTarget:self];
    }
    return _dataSource;
}

- (TPOrderSortView *)sortView {
    if (!_sortView) {
        _sortView = [[TPOrderSortView alloc]initWithTitlesArray:self.myOrderTitleArray];
        _sortView.delegate = self;
    }
    return _sortView;
}

- (NSArray<NSString *> *)myOrderTitleArray {
    if (!_myOrderTitleArray) {
        _myOrderTitleArray = @[@"全部",@"待承接",@"承运中",@"已签收"];
    }
    return _myOrderTitleArray;
}

@end
