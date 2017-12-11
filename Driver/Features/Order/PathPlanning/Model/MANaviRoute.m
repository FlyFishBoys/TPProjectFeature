//
//  MANaviRoute.m
//  OfficialDemo3D
//
//  Created by yi chen on 1/7/15.
//  Copyright (c) 2015 songjian. All rights reserved.
//

#import "MANaviRoute.h"
#import "TPDPathPlanningDataManager.h"

#define kMANaviRouteReplenishPolylineFilter     5

@interface MANaviRoute()

@property (nonatomic, weak) MAMapView *mapView;
@end

@implementation MANaviRoute

- (void)addToMapView:(MAMapView *)mapView
{
    self.mapView = mapView;
    
    if ([self.routePolylines count] > 0)
    {
        [mapView addOverlays:self.routePolylines];
    }
    
    if (self.anntationVisible && [self.naviAnnotations count] > 0)
    {
        [mapView addAnnotations:self.naviAnnotations];
    }
}

- (void)removeFromMapView
{
    if (self.mapView == nil)
    {
        return;
    }
    
    if ([self.routePolylines count] > 0)
    {
        [self.mapView removeOverlays:self.routePolylines];
    }
    
    if (self.anntationVisible && [self.naviAnnotations count] > 0)
    {
        [self.mapView removeAnnotations:self.naviAnnotations];
    }
    
    self.mapView = nil;
}

- (void)setNaviAnnotationVisibility:(BOOL)visible
{
    if (visible == self.anntationVisible)
    {
        return;
    }
    
    self.anntationVisible = visible;
    
    if (self.mapView == nil)
    {
        return;
    }
    
    if (self.anntationVisible)
    {
        [self.mapView addAnnotations:self.naviAnnotations];
    }
    else
    {
        [self.mapView removeAnnotations:self.naviAnnotations];
    }
}

#pragma mark - Format Search Result



- (instancetype)initWithPath:(AMapPath *)path startPoint:(AMapGeoPoint *)start endPoint:(AMapGeoPoint *)end {
    self = [self init];
    
    if (self == nil) {
        return nil;
    }
    
    if (path == nil || path.steps.count == 0) {
        return self;
    }
    
    NSMutableArray *polylines = [NSMutableArray array];
    
    NSMutableArray *naviAnnotations = [NSMutableArray array];
    
    // 为drive类型且需要显示路况
    [path.steps enumerateObjectsUsingBlock:^(AMapStep *step, NSUInteger idx, BOOL *stop) {
        
        MAPolyline *stepPolyline = [MANaviRoute polylineForStep:step];
        
        if (stepPolyline != nil) {
            MANaviPolyline *naviPolyline = [[MANaviPolyline alloc] initWithPolyline:stepPolyline];
            [polylines addObject:naviPolyline];
            
            if (idx > 0) {
                // 填充step和step之间的空隙
                [MANaviRoute replenishPolylinesForPathWith:stepPolyline
                                              lastPolyline:[MANaviRoute polylineForStep:[path.steps objectAtIndex:idx-1]]
                                                 Polylines:polylines];
            }
        }
    }];

    
    [MANaviRoute replenishPolylinesForStartPoint:start endPoint:end Polylines:polylines];
    
    self.routePolylines = polylines;
    self.naviAnnotations = naviAnnotations;
    
    return self;
}

+ (void)replenishPolylinesForPathWith:(MAPolyline *)stepPolyline
                         lastPolyline:(MAPolyline *)lastPolyline
                            Polylines:(NSMutableArray *)polylines {
    CLLocationCoordinate2D startCoor;
    CLLocationCoordinate2D endCoor;
    
    [stepPolyline getCoordinates:&endCoor range:NSMakeRange(0, 1)];
    
    [lastPolyline getCoordinates:&startCoor range:NSMakeRange(lastPolyline.pointCount -1, 1)];
    
    
    if ((endCoor.latitude != startCoor.latitude || endCoor.longitude != startCoor.longitude ))
    {
        LineDashPolyline *dashPolyline = [self replenishPolylineWithStart:startCoor end:endCoor];
        if (dashPolyline) {
            [polylines addObject:dashPolyline];
        }
    }
}
+ (LineDashPolyline *)replenishPolylineWithStart:(CLLocationCoordinate2D)startCoor end:(CLLocationCoordinate2D)endCoor
{
    if (!CLLocationCoordinate2DIsValid(startCoor) || !CLLocationCoordinate2DIsValid(endCoor))
    {
        return nil;
    }
    
    double distance = MAMetersBetweenMapPoints(MAMapPointForCoordinate(startCoor), MAMapPointForCoordinate(endCoor));
    
    LineDashPolyline *dashPolyline = nil;
    
    // 过滤一下，距离比较近就不加虚线了
    if (distance > kMANaviRouteReplenishPolylineFilter) {
        CLLocationCoordinate2D points[2];
        points[0] = startCoor;
        points[1] = endCoor;
        MAPolyline *polyline = [MAPolyline polylineWithCoordinates:points count:2];
        dashPolyline = [[LineDashPolyline alloc] initWithPolyline:polyline];
    }
    
    return dashPolyline;
}
/* polyline parsed from search result. */

+ (MAPolyline *)polylineForStep:(AMapStep *)step {
    if (step == nil) {
        return nil;
    }
    return [self polylineForCoordinateString:step.polyline];
}
/// 补充起点和终点对于路径的空隙
+ (void)replenishPolylinesForStartPoint:(AMapGeoPoint *)start
                               endPoint:(AMapGeoPoint *)end
                              Polylines:(NSMutableArray *)polylines
{
    if (polylines.count < 1)
    {
        return;
    }
    
    LineDashPolyline *startDashPolyline = nil;
    LineDashPolyline *endDashPolyline = nil;
    if (start)
    {
        CLLocationCoordinate2D startCoor1 = CLLocationCoordinate2DMake(start.latitude, start.longitude);
        CLLocationCoordinate2D endCoor1 = startCoor1;
        
        MANaviPolyline *naviPolyline = [polylines firstObject];
        MAPolyline *polyline = nil;
        if ([naviPolyline isKindOfClass:[MANaviPolyline class]])
        {
            polyline = naviPolyline.polyline;
        }
        else if ([naviPolyline isKindOfClass:[MAPolyline class]])
        {
            polyline = (MAPolyline *)naviPolyline;
        }
        
        if (polyline)
        {
            [polyline getCoordinates:&endCoor1 range:NSMakeRange(0, 1)];
            startDashPolyline = [self replenishPolylineWithStart:startCoor1 end:endCoor1];
            
        }
    } // end start
    
    if (end)
    {
        CLLocationCoordinate2D startCoor2;
        CLLocationCoordinate2D endCoor2;
        
        MANaviPolyline *naviPolyline = [polylines lastObject];
        MAPolyline *polyline = nil;
        if ([naviPolyline isKindOfClass:[MANaviPolyline class]])
        {
            polyline = naviPolyline.polyline;
        }
        else if ([naviPolyline isKindOfClass:[MAPolyline class]])
        {
            polyline = (MAPolyline *)naviPolyline;
        }
        
        if (polyline)
        {
            [polyline getCoordinates:&startCoor2 range:NSMakeRange(polyline.pointCount - 1, 1)];
            endCoor2 = CLLocationCoordinate2DMake(end.latitude, end.longitude);
            
            endDashPolyline = [self replenishPolylineWithStart:startCoor2 end:endCoor2];
        }
    } //end end
    
    if (startDashPolyline)
    {
        [polylines addObject:startDashPolyline];
    }
    if (endDashPolyline)
    {
        [polylines addObject:endDashPolyline];
    }
}
- (id)init {
    self = [super init];
    if (self) {
        self.anntationVisible = YES;
        self.routeColor = UIColorHex(3B48EE);
    }
    
    return self;
}
+ (MAPolyline *)polylineForCoordinateString:(NSString *)coordinateString
{
    if (coordinateString.length == 0)
    {
        return nil;
    }
    
    NSUInteger count = 0;
    
    CLLocationCoordinate2D *coordinates = [self coordinatesForString:coordinateString
                                                     coordinateCount:&count
                                                          parseToken:@";"];
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:coordinates count:count];
    
    free(coordinates), coordinates = NULL;
    
    return polyline;
}
+ (CLLocationCoordinate2D *)coordinatesForString:(NSString *)string
                                 coordinateCount:(NSUInteger *)coordinateCount
                                      parseToken:(NSString *)token {
    if (string == nil) {
        return NULL;
    }
    if (token == nil) {
        token = @",";
    }
    NSString *str = @"";
    if (![token isEqualToString:@","]) {
        str = [string stringByReplacingOccurrencesOfString:token withString:@","];
    }
    else {
        str = [NSString stringWithString:string];
    }
    NSArray *components = [str componentsSeparatedByString:@","];
    NSUInteger count = [components count] / 2;
    if (coordinateCount != NULL) {
        *coordinateCount = count;
    }
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < count; i++) {
        coordinates[i].longitude = [[components objectAtIndex:2 * i]     doubleValue];
        coordinates[i].latitude  = [[components objectAtIndex:2 * i + 1] doubleValue];
    }
    
    return coordinates;
}

@end
