//
//  TPDCheckPathDataManager.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCheckPathDataManager.h"
#import "TPAMapServices.h"

@interface TPDCheckPathDataManager ()

@property (nonatomic, strong,readwrite) MANaviRoute *naviRoute;

@property (nonatomic,strong,readwrite) AMapPath * path;

@end

@implementation TPDCheckPathDataManager

- (void)fetchRouteWithSuccessLocation:(BOOL)success Block:(void(^)(BOOL success,NSString *distance))block {
    @weakify(self);
    CLLocationCoordinate2D origin;
    CLLocationCoordinate2D destination;
    AMapGeoPoint *point;
    if (success) {
        origin = self.myLocation;
        destination = self.endLocation;
        point = [AMapGeoPoint locationWithLatitude:self.startLocation.latitude longitude:self.startLocation.longitude];
    } else {
        origin = self.startLocation;
        destination = self.endLocation;
        point = nil;
    }
    [[TPAMapServices sharedInstance] drivingRouteSearchWithOrigin:origin destination:destination waypoints:point ?@[point] : nil callback:^(AMapPath * _Nullable path, BOOL success) {
        @strongify(self);
        if (success && path) {
            self.path = path;
            
            self.naviRoute = [[MANaviRoute alloc] initWithPath:path startPoint:[AMapGeoPoint locationWithLatitude:self.startLocation.latitude longitude:self.startLocation.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.endLocation.latitude longitude:self.endLocation.longitude]];
        }
        if (block) {
            block(success && path,[@(path.distance/1000) stringValue]);
        }
    }];
}
- (void)clearRoute {
    [self.naviRoute removeFromMapView];
}

- (NSArray *)fetchAnnotations {
    
    NSMutableArray *annotations = @[].mutableCopy;
    
    if (CLLocationCoordinate2DIsValid(self.myLocation)) {
        MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
        startAnnotation.title = @"我的位置";
        startAnnotation.coordinate = self.myLocation;
        [annotations addObject:startAnnotation];
    }
    
    MAPointAnnotation *wayAnnotation = [[MAPointAnnotation alloc] init];
    wayAnnotation.title = @"起点";
    wayAnnotation.coordinate = self.startLocation;
    [annotations addObject:wayAnnotation];
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.title = @"终点";
    destinationAnnotation.coordinate = self.endLocation;
    [annotations addObject:destinationAnnotation];
    
    return annotations.copy;
}


@end
