//
//  TPDFindGoodsController.m
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSmartFindsGoodsController.h"
#import "TPBaseTableView.h"
#import "TPDSmartFindGoodsHeadView.h"
#import "TPDSmartFindGoodsDataManager.h"
#import "TPNoResultView.h"
#import "TPLocationServices.h"
#import "TPDGoodsCell.h"
#import "TPDGoodsViewModel.h"
#import "TPDGoodsAdvertCell.h"
#import "TPDReceiveOrderView.h"
#import "TPCallCenter.h"
#import "TPDSmartFindGoodsFooterView.h"
@interface TPDSmartFindsGoodsController ()<TPBaseTableViewDelegate,TPDGoodsCellDelegate,TPDGoodsAdvertCellDelegate>
@property (nonatomic , strong) UIView *marqueeView;//跑马灯

@property (nonatomic , strong) TPDSmartFindGoodsHeadView *headerView;//tableView的HeaderView

@property (nonatomic , strong) TPDSmartFindGoodsFooterView *footerView;

@property (nonatomic,strong) TPNoResultView * noResultView;//无定位的空白view

@property (nonatomic , strong) TPBaseTableView *tableView;

@property (nonatomic , strong) TPDSmartFindGoodsDataManager *dataManager;//数据

@end

@implementation TPDSmartFindsGoodsController
-(void)dealloc
{
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addRegularActivity];
    [self fetchSubscibeGoodsCount];
    [self fetchDefaultGoods];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.headerView removeFilterView];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initData];
    [self addSubviews];
    [self setupConstraints];
   
}


#pragma mark - Event Response
//我的报价
- (void)tapRightItem {
    
    [TPRouterAnalytic openInteriorURL:TPRouter_QuotesList_Controller parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
}
//附近货源
- (void)tapLeftItem {
      [TPRouterAnalytic openInteriorURL:TPRouter_NearSupply_Controller parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
  
}
//匹配中心/货运经济人
- (void)tapFooterViewRightRtn:(GoodsFooterViewRightBtnType)type{
   
    switch (type) {
        case GoodsFooterViewRightBtnType_MatchedCenter:
        {
            [[TPCallCenter shareInstance]callUpWithTel:TPServiceTel];
        }
            break;
            
        case GoodsFooterViewRightBtnType_FreightAgent:
        {
            [TPRouterAnalytic openInteriorURL:TPRouter_FreightAgentView parameter:@{
                                                                                    @"departCode":self.dataManager.requestDepartCityCode?self.dataManager.requestDepartCityCode:@"",
                                                                                    @"destinationCode":self.dataManager.requestDestinationCityCode?self.dataManager.requestDestinationCityCode:@"",
                                                                                    } completeBlock:nil];
        }
            
            break;
    }
}
//点击出发城市
- (void)tapDepartCityBtnBlock:(TPAddressModel *)selectModel {
   
    [self.dataManager fetchGoodsWithDepartCityCode:selectModel.adcode];
    [self fetchGoodsComplete];
}
//点击目的地城市
- (void)tapDestinationCityBtnBlock:(TPAddressModel *)selectModel {

    [self.dataManager fetchGoodsWithDestinationCityCode:selectModel.adcode];
    [self fetchGoodsComplete];
}
//点击车型车长
- (void)tapVehicleStandardBtnBlock:(TrucklengthModel *)trucklengthModel trucktype:(TrucktypeModel *) trucktypeModel {
    [self.dataManager fetchGoodsWithTruckTypeId:trucklengthModel.lengthId truckLengthId:trucktypeModel.typeId];
    [self fetchGoodsComplete];
}
//点击订阅btn
- (void)tapSubcribeBtn {
    [TPRouterAnalytic openInteriorURL:TPRouter_SubscribeRoute_Controller parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];

}

//加载更多请求
- (void)pullUpToRefreshAction {
    [self.dataManager pullUpGoods];
    [self fetchGoodsComplete];
}
//刷新数据
- (void)pullDownToRefreshAction {
    [self.dataManager pullDownGoods];
    [self fetchGoodsComplete];
}

//定位完成
- (void)locationComplete {
    
    @weakify(self);
    self.dataManager.locationHandler = ^(BOOL locationSuccess, NSString *locationAddress) {
        @strongify(self);
        if (locationAddress) {
            self.headerView.locationCityAddress = locationAddress;
        }else{
            [self.noResultView showWithType:TPNoResultViewTypeLocationAuthNull];
        }
        self.tableView.hidden = !locationAddress;
    };
    
}
//获取货源完成
- (void)fetchGoodsComplete {
    
    @weakify(self);
    self.dataManager.fetchHandler = ^{
        @strongify(self);
        [self.tableView reloadDataSource];
        [self.tableView stopRefreshingAnimation];
    };
}
//获取是否有货源经济人
- (void)fetchFreightAgentComplete {
    @weakify(self);
    self.dataManager.fetchFreightAgentComplete = ^(BOOL isHave) {
    @strongify(self);
        self.footerView.rightBtnType = isHave?GoodsFooterViewRightBtnType_FreightAgent:GoodsFooterViewRightBtnType_MatchedCenter;
   };
}

#pragma mark - request methods
//获取订阅路线的总货源数
- (void)fetchSubscibeGoodsCount {
     @weakify(self);
    [self.dataManager fetchSubscibeGoodsCountWithComplte:^(NSString *goodsCount) {
        @strongify(self);
        self.headerView.badgeNum = goodsCount;
    }];
}
//获取定位后的默认货源
- (void)fetchDefaultGoods {
    
    [self.dataManager fetchDefaultGoods];
    [self fetchGoodsComplete];
    [self locationComplete];
    [self fetchFreightAgentComplete];
}

#pragma mark - Custom Delegate
#pragma mark - GoodsCellDelegate
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

#pragma mark - tableView delegate
- (void)didSelectObject:(TPDGoodsItemViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    
    if (object != nil && [object.goodsModel.goods_id isNotBlank]) {
        //跳转到货源详情
        [TPRouterAnalytic openInteriorURL:TPRouter_GoodsDetail_Controller parameter:@{@"goodsId":object.goodsModel.goods_id?object.goodsModel.goods_id:@""} type:PUSHCONTROLLERTYPE_PUSH];

        
    }

}
- (CGFloat)footerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
    
    return TPAdaptedHeight(100);
}

- (UIView *)footerViewForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
    
    
    return self.footerView;
}
- (CGFloat)headerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}
#pragma mark - GoodsAdvertCellDelegate
- (void)didClickGoodsAdvertCell:(TPGoodsListAdvertItemViewModel *)viewModel {
    
    if ([viewModel.model.turn_url isNotBlank]) {

        [TPRouterAnalytic openInteriorURL:TPRouter_WebViewController_Common parameter:@{
                                                                                        @"loadURL":viewModel.model.turn_url?viewModel.model.turn_url:@"",
                                                                                        @"title":viewModel.model.web_title?viewModel.model.web_title:@""
                                                                                        
                                                                                        } type:PUSHCONTROLLERTYPE_PUSH];
    }
    
}
#pragma mark - kvo
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
     CGFloat contentOffsetY = _tableView.contentOffset.y;
    if (object == _tableView) {
        if (contentOffsetY < 0) {
            //显示筛选框
            [UIView animateWithDuration: 0 delay: 0 options: UIViewAnimationOptionTransitionFlipFromTop animations: ^{
                [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(TPAdaptedHeight(48));
                    [self.view layoutIfNeeded];
                }];
                _headerView.hidden = NO;
            } completion: nil];
            
        }else if (contentOffsetY > 0)
        {
            [UIView animateWithDuration: 0 delay: 0 options: UIViewAnimationOptionTransitionFlipFromBottom animations: ^{
                [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(0);
                    [self.view layoutIfNeeded];
                }];
                _headerView.hidden = YES;
            } completion: nil];
        }
        
    }
}

#pragma mark - Private Methods
- (void)marqueeViewDissappear {
    [_headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(64);
    }];
    [self.view layoutIfNeeded];
}
- (void)marqueeViewShow {
    
    if (![self.view.subviews containsObject:self.marqueeView]) {
        [self.marqueeView removeFromSuperview];
        [self.view addSubview:self.marqueeView];
        [self setupConstraints];
    }
}
#pragma mark - Getters and Setters
- (UIView *)marqueeView {
    if (!_marqueeView) {
        @weakify(self);
        void(^dissapeaHandler)() = ^{
            @strongify(self);
            [self marqueeViewDissappear];
        };
        void(^fetchHandler)(BOOL show) = ^(BOOL show){
             @strongify(self);
            [self marqueeViewShow];
        };
       
        _marqueeView =  [TPRouterAnalytic interiorObjectForURL:TPRouter_Marquee parameter:@{@"type":@"2",
                                                                                            MGJRouterParameterCompletion:dissapeaHandler,
                                                                                            @"fetchHandler":fetchHandler
                                                                                            }];
        
    }
    return _marqueeView;
}
- (TPBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.isNeedPullDownToRefreshAction = YES;
        _tableView.isNeedPullUpToRefreshAction = YES;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataManager.dataSource;
        [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return _tableView;
}
- (TPDSmartFindGoodsFooterView *)footerView {
    
    if (!_footerView) {
        _footerView  = [[TPDSmartFindGoodsFooterView alloc]init];
        _footerView.rightBtnType = GoodsFooterViewRightBtnType_MatchedCenter;
           @weakify(self);
        _footerView.tapRightBtnBlcok = ^(GoodsFooterViewRightBtnType type) {
            @strongify(self);
            [self tapFooterViewRightRtn:type];
        };
     
        _footerView.tapLeftBtnBlock = ^{
            @strongify(self);
            [self tapLeftItem];
        };
    }
    return _footerView;
}

- (TPDSmartFindGoodsHeadView *)headerView {
    
    if (!_headerView) {
        _headerView = [[TPDSmartFindGoodsHeadView alloc]init];
        @weakify(self);
        //点击出发地
        _headerView.tapFromAdressBtnBlock = ^(TPAddressModel *selectModel) {
            @strongify(self);
            [self tapDepartCityBtnBlock:selectModel];
        };
        
        //点击目的地
        _headerView.tapReceiveAdressBtnBlock = ^(TPAddressModel *selectModel) {
            @strongify(self);
            [self tapDestinationCityBtnBlock:selectModel];
            
        };
        //点击车型车长
        _headerView.tapVehicleStandardBtnBlock = ^(NSArray<TrucklengthModel *> *trucklength, NSArray<TrucktypeModel *> *Trucktype) {
            @strongify(self);
            [self tapVehicleStandardBtnBlock:trucklength[0] trucktype:Trucktype[0]];
            
        };
        //点击订阅路线
        _headerView.tapSubscribeBtnBlock = ^{
            @strongify(self);
            [self tapSubcribeBtn];
        };
    }
    
    return _headerView;
}
- (TPNoResultView *)noResultView {
    if (!_noResultView) {
        _noResultView = [[TPNoResultView alloc] init];
        _noResultView.actionHandler = ^{
            [TPLocationServices openLocationSetting];
        };
    }
    return _noResultView;
}

- (TPDSmartFindGoodsDataManager *)dataManager {
    
    if (!_dataManager) {
        _dataManager = [[TPDSmartFindGoodsDataManager alloc]initWithTarget:self];
    }
    return _dataManager;
}

#pragma mark - custom UI
//添加定时红包
- (void)addRegularActivity {
    [TPRouterAnalytic openInteriorURL:TPRouter_RegularActivity parameter:@{
                                                                           @"presentController":self} completeBlock:nil];

}
- (void)setNavigationItem {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"附近货源" style:UIBarButtonItemStylePlain target:self action:@selector(tapLeftItem)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"我的报价" style:UIBarButtonItemStylePlain target:self action:@selector(tapRightItem)];
    
}
- (void)setupConstraints {
    
        [_marqueeView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(64);
            make.width.mas_equalTo(TPScreenWidth);
            make.height.mas_equalTo(TPAdaptedHeight(40));
            make.left.equalTo(self);
        }];
        [_headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_marqueeView.mas_bottom);
            make.height.mas_equalTo(TPAdaptedHeight(48));
            make.width.mas_equalTo(TPScreenWidth);
            make.left.equalTo(self);
        }];
        [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headerView.mas_bottom);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self).offset(TPAdaptedHeight(-49));
        }];
        
        [_noResultView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.tableView);
        }];

}

- (void)addSubviews {
    
    [self.view addSubview:self.marqueeView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.noResultView];
    [self setNavigationItem];
    
}

- (void)initData {
    
    self.view.backgroundColor = UIColorHex(#F3F5F9);
    self.navigationItem.title = @"智能找货";
}

@end
