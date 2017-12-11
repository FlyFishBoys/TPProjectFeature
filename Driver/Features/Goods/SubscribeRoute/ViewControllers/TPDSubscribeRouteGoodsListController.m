//
//  TPDSubscribeRouteGoodsListController.m
//  TopjetPicking
//
//  Created by lish on 2017/8/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//订阅路线详情列表

#import "TPDSubscribeRouteGoodsListController.h"
#import "TPBaseTableView.h"
#import "TPBaseTableView.h"
#import "TPDSubscribeRouteDataManager.h"
#import "TPDSubscribeRouteGoodsListTitleView.h"

#import "TPDGoodsCell.h"
#import "TPCallCenter.h"
#import "TPDReceiveOrderView.h"
#import "TPDSubscribeRouteEntry.h"
#import "TPDGoodsViewModel.h"
#import "TPDSubscribeRouteGoodsDataManager.h"
@interface TPDSubscribeRouteGoodsListController ()<TPBaseTableViewDelegate,TPDGoodsCellDelegate>

@property (nonatomic , strong) TPBaseTableView *tableView;

@property (nonatomic , strong) TPDSubscribeRouteGoodsListTitleView *titelView;

@property (nonatomic , strong) NSMutableArray *dataArr;

@property (nonatomic , strong) TPDSubscribeRouteGoodsDataManager *dataManager;


@end

@implementation TPDSubscribeRouteGoodsListController
+ (void)load {

    [TPDSubscribeRouteEntry registerSubscribeRouteGoodsList];
}
#pragma mark - Life Cycle
- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self requestModifySubcribrRouteQueryTimeAPI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPWhiteColor;
    [self addSubviews];
    [self setFrame];
    [self creatNavigationCustomTitleView];
  
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self fetchGoods];
}
#pragma mark - request methods
//请求 更改 - 订阅路线请求时间
- (void)requestModifySubcribrRouteQueryTimeAPI {

    [self.dataManager requestModifySubscribeRouteQueryTimeAPIWithSubscribeRouteId:self.subscribeRouteId];
}

- (void)fetchGoodsWithSubscribeRouteId {
    [self.dataManager requestPullDownSubscribeRouteGoodsWithSubscribeRouteId:self.subscribeRouteId];
}

- (void)fetchAllGoods {
    [self.dataManager requestPullDownAllSubscribeRouteGoods];
}
- (void)fetchGoods {
    
    if (![self.subscribeRouteId isEqualToString:@"0"]) {
        [self fetchGoodsWithSubscribeRouteId];
    }else{
        [self fetchAllGoods];
    }
    [self fetchGoodsComplte];
}

//加载更多
- (void)pullUpToRefreshAction {

    [self.dataManager pullUpGoods];
}

//刷新
- (void)pullDownToRefreshAction {

    [self.dataManager pullDownGoods];
}
//空白页面点击btn
- (void)noResultViewActionHandler {
  [self pullDownToRefreshAction];
}
- (void)fetchGoodsComplte {
    @weakify(self);
    self.dataManager.fetchGoodsComplete = ^{
        @strongify(self);
        [self.tableView reloadDataSource];
        [self.tableView stopRefreshingAnimation];
    };
}
#pragma mark - Custom Delegate
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
                   [self pullDownToRefreshAction];
                }
            } payResultBlock:^(BOOL success, NSString *resultMessage) {
                //支付回调
            }];
        }
            break;
            
        case TPDGoodsCell_CallUp://打电话
            [[TPCallCenter shareInstance]recordWithCalledUserMobile:itemViewModel.goodsModel.owner_info.owner_mobile userName:itemViewModel.name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:itemViewModel.goodsModel.goods_id goodsStatus:itemViewModel.goodsModel.goods_status callUpRecordBlock:^(BOOL recordSuccess) {
                
                if (recordSuccess) {
                    [self pullDownToRefreshAction];
                }
            }];
            
            break;
            
    }
}

- (void)didSelectObject:(TPDGoodsItemViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    if (object != nil && [object.goodsModel.goods_id isNotBlank]) {

        [TPRouterAnalytic openInteriorURL:TPRouter_GoodsDetail_Controller parameter:@{@"goodsId":object.goodsModel.goods_id ? : @""} type:PUSHCONTROLLERTYPE_PUSH];
            }
}

#pragma mark - Getters and Setters
- (TPBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc]init];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataManager.dataSource;
        _tableView.isNeedPullUpToRefreshAction = YES;
        _tableView.isNeedPullDownToRefreshAction = YES;
        _tableView.tableFooterView = [[UIView alloc]init];
    }
    return _tableView;
}
- (TPDSubscribeRouteGoodsListTitleView *)titelView {
    
    if (!_titelView) {
        _titelView = [[TPDSubscribeRouteGoodsListTitleView alloc]initWithFrame:CGRectMake(0,0,100,44)];
    }
    return _titelView;
}

- (TPDSubscribeRouteGoodsDataManager *)dataManager {
    
    if (!_dataManager) {
        _dataManager = [[TPDSubscribeRouteGoodsDataManager alloc]initWithTarget:self];
    }
    return _dataManager;
}

#pragma mark - custom UI
- (void)creatNavigationCustomTitleView {
    
    if (![self.subscribeRouteId isEqualToString:@"0"]) {
        self.navigationItem.titleView = self.titelView;
        self.titelView.depertCity = self.depart;
        self.titelView.destinationCity = self.destination;
    }else{
        self.navigationItem.title = @"全部订阅路线";
    }
}
- (void)addSubviews {
    [self.view addSubview:self.tableView];
}
- (void)setFrame {
    
    [_titelView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(44);
        make.left.equalTo(self).offset(TPAdaptedWidth(40));
        make.right.equalTo(self).offset(TPAdaptedWidth(-40));
        make.top.equalTo(self).offset(-44);
        
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.edges.equalTo(self);
    }];
    
}

@end
