//
//  TPDCheckPathDataManager.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MANaviRoute.h"

@interface TPDCheckPathDataManager : NSObject

@property (nonatomic,assign) CLLocationCoordinate2D myLocation;

@property (nonatomic,assign) CLLocationCoordinate2D startLocation;

@property (nonatomic,assign) CLLocationCoordinate2D endLocation;

@property (nonatomic, strong,readonly) MANaviRoute *naviRoute;

@property (nonatomic,strong,readonly) AMapPath * path;

- (void)fetchRouteWithSuccessLocation:(BOOL)success Block:(void(^)(BOOL success,NSString *distance))block;

- (NSArray *)fetchAnnotations;

- (void)clearRoute;

@end
