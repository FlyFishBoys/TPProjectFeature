//
//  TPDListenOrderGoodsListAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderGoodsListAPI.h"

@implementation TPDListenOrderGoodsListAPI {
    
    NSString *_startTime,*_departCityId;
    NSMutableArray *_destinationCityIdArr;
}
- (instancetype)initWithStartTime:(NSString *)startTime departCityId:(NSString *)departCityId destinationCityIdArr:(NSMutableArray *)destinationCityIdArr {
    
    if (self = [super init]) {
       
        _startTime = startTime;
        _departCityId = departCityId;
        _destinationCityIdArr = destinationCityIdArr;
    }
    return self;
    
}

- (id)businessParameters {
    return @{
             @"start_time":_startTime,
             @"start_city_id":_departCityId ?:@"",
             @"destination_city_ids":_destinationCityIdArr == nil ? @[].mutableCopy:_destinationCityIdArr
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/listengoods/list";
}

- (NSString *)destination {
    
    return @"listengoods.list";
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
