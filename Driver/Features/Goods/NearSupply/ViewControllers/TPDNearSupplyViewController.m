//
//  TPDNearSupplyViewController.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/4.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearSupplyViewController.h"

#import "TPSearchNearSupplyViewController.h"
#import "TPAMapBaseDataView.h"
#import "TPDNearSupplyTabView.h"
#import "TPBaseTableView.h"
#import "TPDNearSupplyDataManager.h"
#import "TPAMapGoodsAnnotationManager.h"
#import "TPNearSupplyMapModel.h"
#import "TPDGoodsRouterEntry.h"

#import "TPDGoodsCell.h"

#import "TPDReceiveOrderView.h"

#import "TPCallCenter.h"

#import "TPDNearbyMapListView.h"

#import "TPDGoodsViewModel.h"
#import "TPDGoodsAdvertCell.h"
@interface TPDNearSupplyViewController ()<TPAMapBaseDataViewDelegate,TPNearSupplyTabViewDelegate,TPBaseTableViewDelegate,TPDGoodsCellDelegate,TPDGoodsAdvertCellDelegate>

@property (nonatomic, strong) TPDNearSupplyTabView *tabView;

@property (nonatomic, strong)  TPBaseTableView * tableView;

@property (nonatomic, strong) TPAMapBaseDataView *mapView;

@property (nonatomic,strong) TPDNearSupplyDataManager * dataManager;

@property (nonatomic,strong) TPAMapGoodsAnnotationManager * annotationManager;

@end

@implementation TPDNearSupplyViewController
{
    BOOL regionChangedFlag_;
}
#pragma mark -
+ (void)load {
    
    [TPDGoodsRouterEntry registerNearSupply];
}
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"附近货源";
    
    regionChangedFlag_ = NO;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self setNavigationItem];
    
    [self addSubViews];
    
    [self setFrame];
    
    [self fetchDefaultData];
    
}
#pragma mark - event
- (void)clickNavMapButton:(id)sender {
    [self setNavigationItemForMap];
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        [self.view exchangeSubviewAtIndex:2 withSubviewAtIndex:1];
    }];
    
}

- (void)clickNavSearchButton:(id)sender
{
    TPSearchNearSupplyViewController *controller = [[TPSearchNearSupplyViewController alloc] init];
    [self cyl_pushViewController:controller animated:YES];
    @weakify(self);
    controller.searchCompleted = ^(TPSearchResultModel *model) {
        @strongify(self);
        [self.mapView setMapCoordinate:model.location];
    };
}

- (void)clickNavListButton:(id)sender {
    [self setNavigationItem];
    
    [UIView animateWithDuration:0.5 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        [self.view exchangeSubviewAtIndex:1 withSubviewAtIndex:2];
    }];
    
}
#pragma mark - TPNearSupplyTabViewDelegate
- (void)chooseDestination:(NSString *)destination_city_ids {
    self.dataManager.requestParams[@"destination_city_ids"] = destination_city_ids;
    
    [self fetchMapViewData];
    [self.tableView triggerRefreshing];
}
- (void)chooseCarModel:(NSString *)lengthIds typeIds:(NSString *)typeIds {
    self.dataManager.requestParams[@"truck_type_id"] = typeIds;
    self.dataManager.requestParams[@"truck_length_id"] = lengthIds;
    
    [self fetchMapViewData];
    [self.tableView triggerRefreshing];
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
#pragma mark - TPAMapBaseDataViewDelegate
- (MAAnnotationView *)baseMapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        MAPinAnnotationView *poiAnnotationView = [[MAPinAnnotationView alloc] init];
        poiAnnotationView.canShowCallout = NO;
        return poiAnnotationView;
    }
    return [self.annotationManager mapView:mapView viewForAnnotation:annotation];
}

- (void)selectSigleAnnotation:(id)data {
    TPDGoodsModel *model = (TPDGoodsModel *)data;
    [TPRouterAnalytic openInteriorURL:TPRouter_GoodsDetail_Controller parameter:@{@"goodsId":model.goods_id} type:PUSHCONTROLLERTYPE_PUSH];
   
}
//展开列表数据
- (void)selectPolyAnnotion:(NSArray *)data {
    TPDNearbyMapListView *v = [[TPDNearbyMapListView alloc] initWithTarget:self];
    v.goodsArray = data;
    [v showOnView:self.view];
}
- (void)selectDistrictAnnotation:(id)data {
    TPDNearbyMapListView *v = [[TPDNearbyMapListView alloc] initWithTarget:self];
    v.requestParams = self.dataManager.requestParams.copy;
    [v showOnView:self.view];
}
- (void)refreshMapMaker:(MAMapView *)mapview regionDidChangeByBtnClick:(BOOL)wasBtnAction {
    if (regionChangedFlag_) {
        self.dataManager.requestParams[@"latitude"] = [@(mapview.centerCoordinate.latitude) stringValue];
        self.dataManager.requestParams[@"longitude"] = [@(mapview.centerCoordinate.longitude) stringValue];
        self.dataManager.requestParams[@"map_level"] = [@((int)roundf(mapview.zoomLevel)) stringValue];
        [self fetchMapViewData];
        [self.tableView triggerRefreshing];
    }
    regionChangedFlag_ = YES;
}
#pragma mark - TPBaseTableViewDelegate

- (CGFloat)headerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)footerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section
{
    return 0.01;

}

- (void)pullDownToRefreshAction {
    @weakify(self);
    [self.dataManager loadListDataWithCallback:^(BOOL success, TPBusinessError * _Nonnull error) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];
        if (success && !error) {
            [self.tableView reloadDataSource];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)pullUpToRefreshAction {
    @weakify(self);
    [self.dataManager loadNextPageDataWithCallback:^(BOOL success, TPBusinessError * _Nonnull error) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];
        if (success && !error) {
            [self.tableView reloadDataSource];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}
//获取货源广告完成
- (void)fetchGoodsAdvert {
    @weakify(self);
    self.dataManager.fetchAdvertHandler = ^{
         @strongify(self);
        [self.tableView reloadDataSource];
    };
}
- (void)fetchDefaultData {
    [self.dataManager fetchLocationCompletion:^(NSString * _Nonnull latitude, NSString * _Nonnull longitude) {
        [self.mapView.mapView setZoomLevel:9.5];
        [self.mapView setMapCoordinate:CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue)];
    }];
    [self fetchGoodsAdvert];
}

- (void)fetchMapViewData {
    @weakify(self);
    [self.dataManager requestNearSupplyMapWithCallback:^(BOOL success, TPNearSupplyMapModel * _Nullable model, TPBusinessError * _Nullable error) {
        @strongify(self);
        if (success && !error) {
            [self.annotationManager addGoodsAnnotationWithModel:model mapView:self.mapView.mapView];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}
#pragma mark -  TPDSmartFindGoodsCellDelegate <NSObject>
- (void)didSelectGoodsCellBtn:(TPDGoodsCellBtnType)btnType itemViewModel:(TPDGoodsItemViewModel *)itemViewModel {
    switch (btnType) {
        case TPDGoodsCell_ReceiveOrder:{
            TPDReceiveOrderViewModel *model = [[TPDReceiveOrderViewModel alloc] init];
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
            
        case TPDGoodsCell_CallUp:
            
            [[TPCallCenter shareInstance]recordWithCalledUserMobile:itemViewModel.goodsModel.owner_info.owner_mobile userName:itemViewModel.name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:itemViewModel.goodsModel.goods_id goodsStatus:itemViewModel.goodsModel.goods_status callUpRecordBlock:^(BOOL recordSuccess) {
                
                if (recordSuccess) {
                    itemViewModel.is_call = @"1";
                    [self.tableView reloadDataSource];
                }
            }];
            break;
    }
}

#pragma mark - UI
- (TPDNearSupplyTabView *)tabView {
    if (!_tabView) {
        _tabView = [[[NSBundle mainBundle] loadNibNamed:@"TPDNearSupplyTabView" owner:[TPDNearSupplyTabView class] options:nil] lastObject];
        _tabView.delegate = self;
    }
    return _tabView;
}

- (TPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] init];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.isNeedPullDownToRefreshAction = YES;
        _tableView.isNeedPullUpToRefreshAction = YES;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataManager.listDataSource;
    }
    return _tableView;
}

- (TPAMapBaseDataView *)mapView {
    if (!_mapView) {
        _mapView = [[TPAMapBaseDataView alloc] initWithFrame:CGRectZero];
        _mapView.shouldLocation = NO;
        _mapView.delegate = self;
    }
    return _mapView;
}
- (void)setNavigationItem
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_near_map"] style:UIBarButtonItemStylePlain target:self action:@selector(clickNavMapButton:)];
    [self.navigationItem setRightBarButtonItems:@[button] animated:YES];
    
}

- (void)setNavigationItemForMap
{
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_search44"] style:UIBarButtonItemStylePlain target:self action:@selector(clickNavSearchButton:)];
    
    UIBarButtonItem *listBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_list44"] style:UIBarButtonItemStylePlain target:self action:@selector(clickNavListButton:)];
    
    
    [self.navigationItem setRightBarButtonItems:@[listBtn,searchBtn] animated:YES];
}
- (void)addSubViews {
    [self.view addSubview:self.tabView];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.tableView];
}

- (void)setFrame {
    
    [self.tabView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(TPScreenWidth);
        make.height.mas_equalTo(@(40));
        make.left.equalTo(self.view);
    }];
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabView.mas_bottom);
        make.width.mas_equalTo(TPScreenWidth);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabView.mas_bottom);
        make.width.mas_equalTo(TPScreenWidth);
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (TPDNearSupplyDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDNearSupplyDataManager alloc] initWithTarget:self];
    }
    return _dataManager;
}
- (TPAMapGoodsAnnotationManager *)annotationManager {
    if (!_annotationManager) {
        _annotationManager = [[TPAMapGoodsAnnotationManager alloc] init];
    }
    return _annotationManager;
}
@end
