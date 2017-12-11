//
//  TPDCheckPathViewController.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCheckPathViewController.h"
#import "TPDCheckPathDataManager.h"
#import "TPAMapLocationView.h"
#import "TPAlertView.h"
#import "TPPushSystemPage.h"
#import "TPDCheckPathView.h"

@interface TPDCheckPathViewController () <MAMapViewDelegate>

@property (nonatomic,strong) TPAMapLocationView * mapView;

@property (nonatomic,strong) TPDCheckPathView * planningView;

@property (nonatomic,strong) TPDCheckPathDataManager * dataManager;

@property (nonatomic,copy) NSString * startLatitude;

@property (nonatomic,copy) NSString * startLongitude;

@property (nonatomic,copy) NSString * endLatitude;

@property (nonatomic,copy) NSString * endLongitude;

@end

@implementation TPDCheckPathViewController
{
    BOOL flag_;
}
+ (void)load {
    [MGJRouter registerURLPattern:TPRouter_Order_CheckPath toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDCheckPathViewController * vc = [[TPDCheckPathViewController alloc] init];
        vc.startLatitude = routerParameters[MGJRouterParameterUserInfo][@"startLatitude"];
        vc.startLongitude = routerParameters[MGJRouterParameterUserInfo][@"startLongitude"];
        vc.endLatitude = routerParameters[MGJRouterParameterUserInfo][@"endLatitude"];
        vc.endLongitude = routerParameters[MGJRouterParameterUserInfo][@"endLongitude"];
        return vc;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavBarApperance];
    
    flag_ = NO;

    if (self.startLatitude.isNotBlank && self.startLongitude.isNotBlank) {
     self.dataManager.startLocation = CLLocationCoordinate2DMake(self.startLatitude.doubleValue, self.startLongitude.doubleValue);
    } else {
        self.dataManager.startLocation = kCLLocationCoordinate2DInvalid;
    }
    if (self.endLatitude.isNotBlank && self.endLongitude.isNotBlank) {
        self.dataManager.endLocation = CLLocationCoordinate2DMake(self.endLatitude.doubleValue, self.endLongitude.doubleValue);
    } else {
        self.dataManager.startLocation = kCLLocationCoordinate2DInvalid;
    }
    
    self.view.backgroundColor = TPBackgroundColor;
    
    [self layoutPageSubviews];
    
}

#pragma mark - event

- (void)fetchRoutePathWithLocation:(BOOL)location {
    @weakify(self);
    [self.mapView.mapView removeAnnotations:self.mapView.mapView.annotations];
    [self.dataManager clearRoute];
    
    [self.mapView.mapView addAnnotations:[self.dataManager fetchAnnotations]];
    
    if (!CLLocationCoordinate2DIsValid(self.dataManager.startLocation) || !CLLocationCoordinate2DIsValid(self.dataManager.endLocation)) {
        return;
    }
    
    [self.dataManager fetchRouteWithSuccessLocation:location Block:^(BOOL success, NSString *distance) {
        @strongify(self);
        if (success) {
            [self _setAttributedStringWithDistance:distance];
            
            [self.dataManager.naviRoute addToMapView:self.mapView.mapView];
            
            if (self->flag_ && location) {
                [self.mapView.mapView setCenterCoordinate:self.dataManager.myLocation animated:YES];
            } else {
                /* 缩放地图使其适应polylines的展示. */
                [self.mapView.mapView showOverlays:self.dataManager.naviRoute.routePolylines edgePadding:UIEdgeInsetsMake(20, 20, 20, 20) animated:YES];
                self->flag_ = YES;
            }
        }
    }];
    
}
#pragma mark - MAMapViewDelegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    
    self.dataManager.myLocation = userLocation.location.coordinate;
    
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
    
    self.dataManager.myLocation = kCLLocationCoordinate2DInvalid;
    
    [self fetchRoutePathWithLocation:NO];
    
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
        
        /* 我的位置. */
        if ([[annotation title] isEqualToString:@"我的位置"])
        {
            poiAnnotationView.image = [UIImage imageNamed:@"order_nav_location"];
        }
        
        /* 起点. */
        if ([[annotation title] isEqualToString:@"起点"])
        {
            poiAnnotationView.image = [UIImage imageNamed:@"order_nav_start"];
        }
        /* 终点. */
        else if([[annotation title] isEqualToString:@"终点"])
        {
            poiAnnotationView.image = [UIImage imageNamed:@"order_nav_end"];
        }
        
        return poiAnnotationView;
    }
    
    return nil;
}
#pragma mark - UI
- (void)setupNavBarApperance {
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.navigationItem.title = @"查看路线";
    
}

- (void)layoutPageSubviews {
    
    [self.view addSubview:self.planningView];
    [self.view addSubview:self.mapView];

    [self.planningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(64));
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.planningView.mas_top);
    }];
}

- (TPDCheckPathView *)planningView {
    if (!_planningView) {
        _planningView = [[TPDCheckPathView alloc] init];
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
- (TPDCheckPathDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDCheckPathDataManager alloc] init];
    }
    return _dataManager;
}

- (void)_setAttributedStringWithDistance:(NSString *)distance {
    
    NSString *string = [NSString stringWithFormat:@"总里程约为：%@公里。成交后，可使用导航提货和配送。",distance];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    [attString addAttributes:@{NSForegroundColorAttributeName : TPMainColor} range:NSMakeRange(6, distance.length)];
    
    self.planningView.planningLable.attributedText = attString;
}
@end
