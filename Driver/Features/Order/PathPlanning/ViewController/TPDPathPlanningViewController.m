//
//  TPDPathPlanningViewController.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDPathPlanningViewController.h"
#import "TPDPathPlanningBottomView.h"
#import "TPDPathPlanningDataManager.h"
#import "TPAMapLocationView.h"
#import "TPAlertView.h"
#import "TPPushSystemPage.h"
#import "TPAMapServices.h"
#import <MapKit/MapKit.h>
#import "TPCallCenter.h"

@interface TPDPathPlanningViewController () <MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong) UIView * topContentView;

@property (nonatomic,strong) UILabel * cityLable;

@property (nonatomic,strong) UITextField *searchTextField;

@property (nonatomic,strong) TPDPathPlanningBottomView * planningView;

@property (nonatomic,strong) TPAMapLocationView * mapView;

@property (nonatomic,strong) UIView *resultView;

@property (nonatomic,strong) UITableView * tableView;


@property (nonatomic,strong) TPDPathPlanningDataManager * dataManager;

@property (nonatomic,copy) NSString * goodsLatitude;

@property (nonatomic,copy) NSString * goodsLongitude;

@property (nonatomic,copy) NSString * mobile;

@property (nonatomic,copy) NSString * pickupStatus;

@end

@implementation TPDPathPlanningViewController
{
    BOOL flag_;
}
+ (void)load {
    [MGJRouter registerURLPattern:TPRouter_Order_PathPlanning toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDPathPlanningViewController * vc = [[TPDPathPlanningViewController alloc] init];
        vc.goodsLatitude = routerParameters[MGJRouterParameterUserInfo][@"latitude"];
        vc.goodsLongitude = routerParameters[MGJRouterParameterUserInfo][@"longitude"];
        vc.mobile = routerParameters[MGJRouterParameterUserInfo][@"mobile"];
        vc.pickupStatus = routerParameters[MGJRouterParameterUserInfo][@"pickupStatus"];
        return vc;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavBarApperance];
    
    flag_ = NO;
    
    self.dataManager.endLocation = CLLocationCoordinate2DMake(self.goodsLatitude.doubleValue, self.goodsLongitude.doubleValue);
    
    self.view.backgroundColor = TPBackgroundColor;
    
    [self layoutPageSubviews];
    
}

#pragma mark - event
- (void)callShipper {
    [[TPCallCenter shareInstance] callUpWithTel:self.mobile];
}
- (void)startNav {
    NSArray *maps = [self.dataManager fetchCanOpenMapSchemes];
    if (maps.count > 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择地图" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        for (NSDictionary *mapItem in maps) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:mapItem[@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                if ([mapItem[@"type"] isEqualToString:@"1"]) {
                    NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=交运配货&sid=BGVIS1&slat=%lf&slon=%lf&sname=起点&did=BGVIS2&dlat=%f&dlon=%f&dname=终点&dev=0&m=0&t=0",self.dataManager.startLocation.latitude, self.dataManager.startLocation.longitude,self.dataManager.endLocation.latitude, self.dataManager.endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
                
                if ([mapItem[@"type"] isEqualToString:@"2"]) {
                    CLLocationCoordinate2D from = [self.dataManager transformToBDMapWithAmapLocation:self.dataManager.startLocation];
                    CLLocationCoordinate2D end = [self.dataManager transformToBDMapWithAmapLocation:self.dataManager.endLocation];
                    //我的位置代表起点位置为当前位置，也可以输入其他位置作为起点位置，如天安门
                    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=%lf,%lf&destination=%f,%f&mode=driving&src=交运配货",from.latitude, from.longitude,end.latitude, end.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                    
                }
                
                if ([mapItem[@"type"] isEqualToString:@"3"]) {
                    MKMapItem *from = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.dataManager.startLocation addressDictionary:nil]];
                    from.name = @"起点";
                    MKMapItem *to = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.dataManager.endLocation addressDictionary:nil]];
                    to.name = @"终点";
                    [MKMapItem openMapsWithItems:@[from, to]
                                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
                }
                
            }];
            [alertController addAction:action];
        }
        
        [self presentViewController:alertController animated:YES completion:nil];
        
    } else {
        TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:@"提示" message:@"您未安装地图APP" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (void)searchTextFieldEditChanged:(UITextField *)searchTextField {
    @weakify(self);
    [self.dataManager fetchSearchResultWithText:searchTextField.text block:^(NSInteger count) {
        @strongify(self);
        if (count > 0) {
            self.resultView.hidden = NO;
        } else {
            self.resultView.hidden = YES;
        }
        [self.tableView reloadData];
    }];
}
- (void)fetchRoutePathWithLocation:(BOOL)location {
    @weakify(self);
    [self.mapView.mapView removeAnnotations:self.mapView.mapView.annotations];
    [self.dataManager clearRoute];
    
    [self.mapView.mapView addAnnotations:[self.dataManager fetchAnnotations]];
    [self.dataManager fetchRouteWithBlock:^(BOOL success, NSInteger time, NSString *distance) {
        @strongify(self);
        if (success) {
            [self _setAttributedStringWithTime:time distance:distance];
            
            [self.dataManager.naviRoute addToMapView:self.mapView.mapView];
            
            if (self->flag_ && location) {
                [self.mapView.mapView setCenterCoordinate:self.dataManager.startLocation animated:YES];
            } else {
                /* 缩放地图使其适应polylines的展示. */
                [self.mapView.mapView showOverlays:self.dataManager.naviRoute.routePolylines edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
                self->flag_ = YES;
            }
        }
    }];
    
    [self.dataManager fetchDestinationCityWithCallBack:^(NSString *cityName) {
        @strongify(self);
        self.cityLable.text = cityName;
    }];
}
#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    self.dataManager.startLocation = userLocation.location.coordinate;
    
    [self fetchRoutePathWithLocation:YES];
    [mapView setShowsUserLocation:NO];
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    if(error.code == kCLErrorDenied) {
        TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:@"无法获取定位" message:@"请在iPhone的“设置-隐私-定位”选项中，允许560发货版访问您的位置" delegate:self cancelButtonTitle:@"暂不" otherButtonTitles:@"去设置", nil];
        alertView.otherButtonAction = ^{
            [TPPushSystemPage pushSystemLocation];
        };
        [alertView show];
    } else {
        TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:@"无法获取定位" message:@"请检查您的位置服务，确保手机GPS信号正常" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    [mapView setShowsUserLocation:NO];
}
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay {
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 3;
        polylineRenderer.lineDashPattern = @[@5, @5];
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]]) {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 3;
        
        polylineRenderer.strokeColor = self.dataManager.naviRoute.routeColor;
        
        return polylineRenderer;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        
        if (poiAnnotationView == nil) {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = NO;
        poiAnnotationView.image = nil;
        
        /* 起点. */
        if ([[annotation title] isEqualToString:@"起点"])
        {
            poiAnnotationView.image = [UIImage imageNamed:@"order_nav_location"];
        }
        /* 终点. */
        else if([[annotation title] isEqualToString:@"终点"])
        {
            poiAnnotationView.image = [UIImage imageNamed:@"order_nav_placelocation"];
        }
        
        return poiAnnotationView;
    }
    
    return nil;
}
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TPAdaptedHeight(52.0);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    self.dataManager.endLocation = ((TPSearchResultModel *)[self.dataManager.searchData objectAtIndex:indexPath.row]).location;
    [self fetchRoutePathWithLocation:NO];
    [self.searchTextField endEditing:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataManager.searchData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TPSearchResultCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TPSearchResultCell"];
    }
    cell.textLabel.text = ((TPSearchResultModel *)[self.dataManager.searchData objectAtIndex:indexPath.row]).address;
    cell.imageView.image = [UIImage imageNamed:@"nav_icon_locate24"];
    
    return cell;
    
}
#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.resultView.hidden = YES;
    [self.dataManager cancelSearchRequests];
}
#pragma mark - UI
- (void)setupNavBarApperance {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    @weakify(self);
    [self.dataManager fetchViewDataWithMobile:self.mobile pickupStatus:self.pickupStatus block:^(NSString *title, NSString *rightNavItemText) {
        @strongify(self);
        self.navigationItem.title = title;
        if (rightNavItemText.isNotBlank) {
                 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:rightNavItemText style:UIBarButtonItemStylePlain target:self action:@selector(callShipper)];
        }
    }];
}

- (void)layoutPageSubviews {
    [self.view addSubview:self.topContentView];
    [self.topContentView addSubview:self.cityLable];
    [self.topContentView addSubview:self.searchTextField];
    [self.view addSubview:self.planningView];
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.resultView];
    [self.resultView addSubview:self.tableView];
    
    [self.topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.cityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topContentView.mas_left).with.offset(TPAdaptedWidth(12));
        make.centerY.equalTo(self.topContentView);
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topContentView.mas_right).with.offset(-TPAdaptedWidth(12));
        make.centerY.equalTo(self.topContentView);
        make.height.mas_equalTo(TPAdaptedHeight(28));
        make.left.equalTo(self.cityLable.mas_right).with.offset(TPAdaptedWidth(10));
    }];
    
    [self.resultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.topContentView.mas_bottom);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.resultView);
        make.height.mas_equalTo(TPAdaptedHeight(208));
    }];
    
    [self.planningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(64));
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.topContentView.mas_bottom);
        make.bottom.equalTo(self.planningView.mas_top);
    }];
}
- (UIView *)topContentView {
    if (!_topContentView) {
        _topContentView = [[UIView alloc] init];
        _topContentView.backgroundColor = TPWhiteColor;
    }
    return _topContentView;
}
- (UILabel *)cityLable {
    if (!_cityLable) {
        _cityLable = [[UILabel alloc] init];
        _cityLable.textColor = TPMainTextColor;
        _cityLable.font = TPAdaptedFontSize(14);
        _cityLable.text = @"上海";
        [_cityLable setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _cityLable;
}
- (UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.backgroundColor = TPBackgroundColor;
        _searchTextField.placeholder = @"请输入详细提货地址";
        _searchTextField.textColor = TPTitleTextColor;
        _searchTextField.font = TPAdaptedFontSize(13);
        _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchTextField.layer.cornerRadius = 4;
        [_searchTextField addTarget:self action:@selector(searchTextFieldEditChanged:) forControlEvents:UIControlEventEditingChanged];
        _searchTextField.delegate = self;
    }
    return _searchTextField;
}
- (TPDPathPlanningBottomView *)planningView {
    if (!_planningView) {
        _planningView = [[TPDPathPlanningBottomView alloc] init];
        [_planningView.navButton addTarget:self action:@selector(startNav) forControlEvents:UIControlEventTouchUpInside];
    }
    return _planningView;
}
- (TPAMapLocationView *)mapView {
    if (!_mapView) {
        _mapView = [[TPAMapLocationView alloc] init];
        _mapView.mapView.delegate = self;
    }
    return _mapView;
}
- (TPDPathPlanningDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDPathPlanningDataManager alloc] init];
    }
    return _dataManager;
}
- (UIView *)resultView {
    if (!_resultView) {
        _resultView = [[UIView alloc] init];
        _resultView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _resultView.hidden = YES;
    }
    return _resultView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)_setAttributedStringWithTime:(NSInteger)time distance:(NSString *)distance {
    NSString *hour = [@(time / 3600) stringValue];
    NSString *minute = [@((time % 3600) / 60) stringValue];
    
    NSString *string = [NSString stringWithFormat:@"全程%@公里，预计%@小时%@分钟到达",distance,hour,minute];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttributes:@{NSForegroundColorAttributeName : TPMainColor} range:NSMakeRange(2, distance.length)];
    [attString addAttributes:@{NSForegroundColorAttributeName : UIColorHex(16CA4E)} range:NSMakeRange(7 + distance.length, hour.length)];
    [attString addAttributes:@{NSForegroundColorAttributeName : UIColorHex(16CA4E)} range:NSMakeRange(9 + distance.length + hour.length, minute.length)];
    
    self.planningView.planningLable.attributedText = attString;
}

@end
