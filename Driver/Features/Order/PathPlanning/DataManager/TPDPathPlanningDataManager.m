//
//  TPDPathPlanningDataManager.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDPathPlanningDataManager.h"
#import "TPAMapServices.h"

@interface TPDPathPlanningDataManager ()

@property (nonatomic, strong,readwrite) MANaviRoute *naviRoute;

@property (nonatomic,strong,readwrite) AMapPath * path;

@property (nonatomic,strong,readwrite) NSMutableArray * searchData;

@property (nonatomic,assign) BOOL shouldCallBackSearchResult;

@property (nonatomic,copy) NSString * cityName;

@end

@implementation TPDPathPlanningDataManager
- (instancetype)init {
    if (self = [super init]) {
        self.shouldCallBackSearchResult = YES;
    }
    return self;
}
- (void)fetchRouteWithBlock:(void(^)(BOOL success,NSInteger time,NSString *distance))block {
    @weakify(self);
    [[TPAMapServices sharedInstance] drivingRouteSearchWithOrigin:self.startLocation destination:self.endLocation waypoints:nil callback:^(AMapPath * _Nullable path, BOOL success) {
        @strongify(self);
        if (success && path) {
            self.path = path;
            
            self.naviRoute = [[MANaviRoute alloc] initWithPath:path startPoint:[AMapGeoPoint locationWithLatitude:self.startLocation.latitude longitude:self.startLocation.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.endLocation.latitude longitude:self.endLocation.longitude]];
        }
        if (block) {
            block(success && path,path.duration,[@(path.distance/1000) stringValue]);
        }
    }];
}
- (void)clearRoute {
    [self.naviRoute removeFromMapView];
}

- (void)fetchSearchResultWithText:(NSString *)text block:(void(^)(NSInteger count))block {
    
    if (text.length > 0) {
        @weakify(self);
        [[TPAMapServices sharedInstance] tipsSearchWithWords:text
                                                        city:self.cityName
                                         keyWordsSearchBlock:^(NSArray<TPSearchResultModel *> * _Nullable results, NSError * _Nullable error) {
                                             @strongify(self);
                                             if (!error && results.count > 0 && self.shouldCallBackSearchResult) {
                                                 [self.searchData removeAllObjects];
                                                 [self.searchData addObjectsFromArray:results];
                                                 if (block) block(results.count);
                                             } else {
                                                 [self.searchData removeAllObjects];
                                                 if (block) block(0);
                                             }
                                         }];
    } else {
        [self.searchData removeAllObjects];
        if (block) block(0);
    }
}

- (void)cancelSearchRequests {
    self.shouldCallBackSearchResult = NO;
}

- (NSArray *)fetchAnnotations {
    
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.title = @"起点";
    startAnnotation.coordinate = self.startLocation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.title = @"终点";
    destinationAnnotation.coordinate = self.endLocation;
    
    return @[startAnnotation,destinationAnnotation];
}

- (NSArray *)fetchCanOpenMapSchemes {
    NSMutableArray *canOpenedMaps = @[].mutableCopy;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        [canOpenedMaps addObject:@{@"name" : @"高德地图",@"shceme" : @"iosamap://",@"type" : @"1"}];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        [canOpenedMaps addObject:@{@"name" : @"百度地图",@"shceme" : @"baidumap://",@"type" : @"2"}];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]]) {
        [canOpenedMaps addObject:@{@"name" : @"苹果地图",@"shceme" : @"http://maps.apple.com/",@"type" : @"3"}];
    }
    
    return canOpenedMaps.copy;
}

- (void)fetchDestinationCityWithCallBack:(void(^)(NSString *cityName))callBack {
    @weakify(self);
    [[TPAMapServices sharedInstance] reGoecodeSearchWithLocation:self.endLocation responseBlock:^(AMapAddressComponent * _Nullable addressComponent, NSError * _Nullable error) {
        @strongify(self);
        if (!error) {
            self.cityName = addressComponent.city;
            if (callBack) callBack(addressComponent.city);
        } else {
            if (callBack) callBack(@"");
        }
    }];
}
- (void)fetchViewDataWithMobile:(NSString *)mobile pickupStatus:(NSString *)pickupStatus block:(void(^)(NSString *title,NSString *rightNavItemText))block {
    NSString *title;
    NSString *rightItemTitle;
    
    if (pickupStatus.isNotBlank) {
        if ([pickupStatus isEqualToString:@"1"]) {
            title = @"去提货";
            rightItemTitle = @"呼叫发货人";
        } else if ([pickupStatus isEqualToString:@"2"]) {
            title = @"去送货";
            rightItemTitle = @"呼叫收货人";
        } else {
            title = @"";
            rightItemTitle = @"";
        }
    } else {
        title = @"";
    }
    
    if (!mobile.isNotBlank) {
        rightItemTitle = @"";
    }
    
    if (block) block(title,rightItemTitle);
}
- (CLLocationCoordinate2D)transformToBDMapWithAmapLocation:(CLLocationCoordinate2D)p {
    
    long double z = sqrt(p.longitude * p.longitude + p.latitude * p.latitude) + 0.00002 * sqrt(p.latitude * M_PI);
    long double theta = atan2(p.latitude, p.longitude) + 0.000003 * cos(p.longitude * M_PI);
    CLLocationCoordinate2D geoPoint;
    geoPoint.latitude  = (z * sin(theta) + 0.006);
    geoPoint.longitude = (z * cos(theta) + 0.0065);
    return geoPoint;
}

- (NSMutableArray *)searchData {
    if (!_searchData) {
        _searchData = @[].mutableCopy;
    }
    return _searchData;
}
@end
