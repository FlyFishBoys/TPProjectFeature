//
//  TPDPathPlanningDataManager.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MANaviRoute.h"

@interface TPDPathPlanningDataManager : NSObject

@property (nonatomic,assign) CLLocationCoordinate2D startLocation;

@property (nonatomic,assign) CLLocationCoordinate2D endLocation;

@property (nonatomic, strong,readonly) MANaviRoute *naviRoute;

@property (nonatomic,strong,readonly) AMapPath * path;

@property (nonatomic,strong,readonly) NSMutableArray * searchData;

- (void)fetchRouteWithBlock:(void(^)(BOOL success,NSInteger time,NSString *distance))block;

- (NSArray *)fetchAnnotations;

- (void)clearRoute;


- (void)fetchSearchResultWithText:(NSString *)text block:(void(^)(NSInteger count))block;

- (void)cancelSearchRequests;

- (void)fetchDestinationCityWithCallBack:(void(^)(NSString *cityName))callBack;

- (NSArray *)fetchCanOpenMapSchemes;

- (CLLocationCoordinate2D)transformToBDMapWithAmapLocation:(CLLocationCoordinate2D)p;

- (void)fetchViewDataWithMobile:(NSString *)mobile pickupStatus:(NSString *)pickupStatus block:(void(^)(NSString *title,NSString *rightNavItemText))block;


@end
