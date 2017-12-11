//
//  MANaviRoute.h
//  OfficialDemo3D
//
//  Created by yi chen on 1/7/15.
//  Copyright (c) 2015 songjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "MANaviPolyline.h"
#import "LineDashPolyline.h"

@interface MANaviRoute : NSObject

/// 是否显示annotation, 显示路况的情况下无效。
@property (nonatomic, assign) BOOL anntationVisible;

@property (nonatomic, strong) NSArray *routePolylines;

@property (nonatomic, strong) NSArray *naviAnnotations;

@property (nonatomic, strong) UIColor *routeColor;

- (void)addToMapView:(MAMapView *)mapView;

- (void)removeFromMapView;

- (void)setNaviAnnotationVisibility:(BOOL)visible;

- (instancetype)initWithPath:(AMapPath *)path startPoint:(AMapGeoPoint *)start endPoint:(AMapGeoPoint *)end;

@end
