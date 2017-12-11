//
//  TPDListenOrderController.m
//  TopjetPicking
//
//  Created by lish on 2017/11/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderController.h"
#import "TPNoResultView.h"
#import "TPAlertView.h"
#import "TPBaseTableView.h"
#import "TPDListenOrderHeaderView.h"
#import "TPDListenOrderSetView.h"
#import "TPDListenOrderDataManager.h"
#import "TPLocationServices.h"
#import "TPDGoodsCell.h"
#import "TPDListenOrderSetDestinationCell.h"
#import "TPDListenOrderSetDepartCell.h"
#import "TPCitySelectView.h"
#import "TPDReceiveOrderView.h"
#import "TPCallCenter.h"
#import "TPDGoodsViewModel.h"
typedef NS_ENUM(NSInteger,PopCitySelectViewType){
    
    PopCitySelectViewType_SetViewDepart, //设置的出发地按钮
    PopCitySelectViewType_SetViewOptional,//设置的自选城市按钮
    PopCitySelectViewType_HeaderViewDepart//headerView的出发地按钮
    
};
@interface TPDListenOrderController ()<TPBaseTableViewDelegate,ListenOrderSetPopLocationCellDelegate,ListenOrderSetPopCellTypeCellDelegate,TPDListenOrderHeaderViewDelegate,TPDGoodsCellDelegate,TPDListenOrderSetViewDelegate>

@property (nonatomic , strong) TPDListenOrderSetView *setView;//设置view

@property (nonatomic , strong) TPDListenOrderHeaderView *headerView;//头视图

@property (nonatomic , strong) UIButton *listenOrderSwitch;//听单开关

@property (nonatomic , strong) TPBaseTableView *tableView;//听单货源列表

@property (nonatomic,strong) TPNoResultView * noResultView;//无定位空白页

@property (nonatomic , strong) TPDListenOrderDataManager *dataManager;//列表的dataManager

@end

@implementation TPDListenOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPWhiteColor;
    [self setRightBarItem];
    [self addSubviews];
    [self setFrame];
    [self defaultRequestAPIs];

}

#pragma mark - request methods
- (void)defaultRequestAPIs{
    
    [self.dataManager fetchListenOrderGoods];
    [self fetchListenOrderGoods];
    [self fetchListenOrderSet];
    [self fetchListenOrderSwitchStatus];
    [self locationFail];
}

- (void)updateListenOrderSwitchStatus {
    [self.dataManager updateListenOrderSwitchStatus];
}

- (void)fetchListenOrderGoods {
    @weakify(self);
    self.dataManager.fetchGoodsComplete = ^{
        @strongify(self);
        [self.tableView reloadDataSource];
    };
}
- (void)fetchListenOrderSet {
    @weakify(self);
    
    self.dataManager.fetchListenOrderSetComplete = ^(NSString *depart, NSString *destination) {
        @strongify(self);
        [self.setView tableViewReload];
        self.headerView.departCity = depart;
        self.headerView.destinationCitys = destination;
    };
}
- (void)fetchListenOrderSwitchStatus {
    
    [self.dataManager fetchListenOrderSwitchStatus];
    @weakify(self);
    self.dataManager.listenOrderStausChanged = ^(ListenOrderSwicthStatus status) {
        @strongify(self);
        [self setNavigationTitle];
        if (status == ListenOrderSwicthStatus_On) {
            [self.dataManager clearAllListenOrderGoods];
        }
    };
}
- (void)locationFail {
    @weakify(self);
    self.dataManager .locationComplete = ^(BOOL isLocationSuccess) {
        @strongify(self);
        self.tableView.hidden = !isLocationSuccess;
        self.noResultView .hidden = isLocationSuccess;
    };
}
#pragma mark - Event Response
//点击开关
- (void)tapRightItem {
    
    if (self.dataManager.listenOrderStatus == ListenOrderSwicthStatus_On) {
        TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"为保证您能及时收到新货源，建议您打开听单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"暂停听单", nil];
        alertView.otherButtonAction = ^{
           [self updateListenOrderSwitchStatus];
            
        };
        [alertView show];
    }
    else{
        [self updateListenOrderSwitchStatus];
    }
}

//点击设置
- (void)tapSetBtn {
    
    [self.dataManager refreshListenOrderSetDataSource];
    [self.setView showInView:self.view];
}
//点击出发地
- (void)tapDepartBtnWithType:(PopCitySelectViewType)type {
 
    [TPCitySelectView citySelectViewWithType:SELECTVIEW_Cloab_ALL_AREA block:^(TPAddressModel *selectCityModel) {
        
        TPDListenOrderSetModel *model = [[TPDListenOrderSetModel alloc]init];
        model.city_id = selectCityModel.adcode;
        model.city_name = selectCityModel.formatted_area;
        switch (type) {
            case PopCitySelectViewType_SetViewOptional:
                model.type = @"3";
                [self.dataManager.listenOrderSetDataSource blindOptionalModel:model];
                break;
            case PopCitySelectViewType_SetViewDepart:
                model.type = @"1";
                [self.dataManager.listenOrderSetDataSource blindDepartModel:model];
                break;
                
            
            case PopCitySelectViewType_HeaderViewDepart:
                model.type = @"1";
                [self.dataManager.listenOrderSetDataSource blindDepartModel:model];
                [self.dataManager updateListenOrderSet];
                break;
        }
        [self.setView tableViewReload];
        
    } dismissBlock:^{
        
    }];
}
//点击定位
- (void)tapLocationBtn {
    [self.dataManager obtainLocationInforWithComplete:^(TPDListenOrderSetModel *model) {
        [self.dataManager.listenOrderSetDataSource blindDepartModel:model];
        [self.setView tableViewReload];
    }];
}
//点击确认
- (void)tapConfirmBtn {
    [self.dataManager updateListenOrderSet];
}

#pragma mark - Custom Delegate
#pragma mark - TableView delegate
- (void)didSelectObject:(TPDGoodsItemViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    
    if (object != nil && [object.goodsModel.goods_id isNotBlank]) {
        
        [TPRouterAnalytic openInteriorURL:TPRouter_GoodsDetail_Controller parameter:@{@"goodsId":object.goodsModel.goods_id ? : @""} type:PUSHCONTROLLERTYPE_PUSH];
        [self.dataManager lookupWithGoodsId:object.goodsModel.goods_id];
    }
}

#pragma mark - GoodsCell delegate
- (void)didSelectGoodsCellBtn:(TPDGoodsCellBtnType)btnType itemViewModel:(TPDGoodsItemViewModel *)itemViewModel {
    switch (btnType) {
        case TPDGoodsCell_ReceiveOrder:{
            //接单
            TPDReceiveOrderViewModel *model = [[TPDReceiveOrderViewModel alloc]init];
            model.payViewType = WalletPayViewType_PayOffer;
            model.goods_id = itemViewModel.goodsModel.goods_id;
            model.goods_version = itemViewModel.goodsModel.goods_version;
            
            [TPDReceiveOrderView showViewWithModel:model fromController:self requestBlock:^(BOOL isQuotesSuccess, BOOL isRequestSuccess) {
                if (isQuotesSuccess) {
                    [self.dataManager removeGoodsWithGoodsId:itemViewModel.goodsModel.goods_id];
                }
            } payResultBlock:^(BOOL success, NSString *resultMessage) {
                //支付回调
                
            }];
        }
            
            break;
            
        case TPDGoodsCell_CallUp:
            
            [[TPCallCenter shareInstance]recordWithCalledUserMobile:itemViewModel.goodsModel.owner_info.owner_mobile userName:itemViewModel.name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:itemViewModel.goodsModel.goods_id goodsStatus:itemViewModel.goodsModel.goods_status callUpRecordBlock:^(BOOL recordSuccess) {
                
                if (recordSuccess) {
                    [self.dataManager callUpWithGoodsId:itemViewModel.goodsModel.goods_id];
                }
            }];
            break;
    }
}

#pragma mark - DestinationCell delegate
- (void)ListenOrderSetPopCellTypeDidSelectBtn:(ListenOrderSetPopCellType)btnType cellViewModel:(TPDListenOrderSetDestinationViewModel *)cellViewModel {
    
    switch (btnType) {
        case ListenOrderSetPopCell_SelectBtn:
            
            cellViewModel.isSelectCity = !cellViewModel.isSelectCity;
            [self.setView tableViewReload];
            
            break;
    }
}

#pragma mark - OptionalCell delegate
- (void)didSelectOptionalCityWithObject:(TPDListenOrderSetDestinationViewModel *)object  {
    
    [self tapDepartBtnWithType:PopCitySelectViewType_SetViewOptional];
}

#pragma mark - Departcell delegate
- (void)listenOrderSetPopLocationCellDidSelectBtn:(ListenOrderSetPopLocationCellBtnType)btnType cellViewModel:(TPDListenOrderSetDepartViewModel *)cellViewModel {
    
    
    switch (btnType) {
        case ListenOrderSetPopLocationCell_LocationBtn:{
            //点击定位按钮
            [self tapLocationBtn];
        }
            break;
            
        case ListenOrderSetPopLocationCell_DepartCityBtn:
            //弹出省市区弹框
            [self tapDepartBtnWithType:PopCitySelectViewType_SetViewDepart];
            break;
    }
}

#pragma mark - Getters and Setters
- (TPNoResultView *)noResultView {
    if (!_noResultView) {
        _noResultView = [[TPNoResultView alloc] init];
        _noResultView.actionHandler = ^{
            [TPLocationServices openLocationSetting];
        };
    }
    return _noResultView;
}
- (TPBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc]init];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataManager.goodsDataSource;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
- (TPDListenOrderHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[TPDListenOrderHeaderView alloc]init];
        _headerView.delegate = self;
        @weakify(self);
        _headerView.tapDepartBtnBlock = ^(UIButton *btn) {
            @strongify(self);
            [self tapDepartBtnWithType:PopCitySelectViewType_HeaderViewDepart];
            
        };
        _headerView.tapSetBtnBlock = ^{
            @strongify(self);
            [self tapSetBtn];
        };
    }
    return _headerView;
}

- (TPDListenOrderSetView *)setView {
    
    if (!_setView) {
        _setView = [[TPDListenOrderSetView alloc]initWithDataSource:self.dataManager.listenOrderSetDataSource];
        _setView.delegate = self;
        @weakify(self);
        _setView.tapConfirmBtn = ^{
            @strongify(self);
            [self tapConfirmBtn];
            
        };
    }
    return _setView;
}

- (TPDListenOrderDataManager *)dataManager {
    
    if (!_dataManager) {
        _dataManager = [TPDListenOrderDataManager sharedInstance];
        _dataManager.target = self;
    }
    return _dataManager;
    
}
#pragma mark - custom UI
- (void)setRightBarItem {
    
    _listenOrderSwitch = [UIButton buttonWithType:UIButtonTypeCustom];
   // UIImage *on = [UIImage imageNamed:@"listen_order_nav_switch_on"];
    _listenOrderSwitch.frame = CGRectMake(TPAdaptedWidth(324), 32,TPAdaptedWidth(40), TPAdaptedHeight(24));
    
    [_listenOrderSwitch addTarget:self action:@selector(tapRightItem) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_listenOrderSwitch];
    
}

- (void)setNavigationTitle {
    
    if (self.dataManager.listenOrderStatus == ListenOrderSwicthStatus_On) {
        self.navigationItem.title = @"听单已开启";
        [_listenOrderSwitch setBackgroundImage:[UIImage imageNamed:@"listen_order_nav_switch_on"] forState:UIControlStateNormal];
    }else{
        self.navigationItem.title = @"听单已关闭";
        [_listenOrderSwitch setBackgroundImage:[UIImage imageNamed:@"listen_order_nav_switch_off"] forState:UIControlStateNormal];
    }
}

- (void)addSubviews {
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noResultView];
}

- (void)setFrame {
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(64);
        make.height.mas_equalTo(TPAdaptedHeight(40));
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headerView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(-44);
    }];

    [_noResultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView);
    }];
}

@end
