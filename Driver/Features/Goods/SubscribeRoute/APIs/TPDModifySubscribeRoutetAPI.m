//
//  TPDEditSubscribeRoutetAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDModifySubscribeRoutetAPI.h"

@implementation TPDModifySubscribeRoutetAPI
{
    
  NSString  *_subscribeLineId,*_departCityCode,*_destinationCityCode,*_truckTypeId,*_truckLengthId;
}
- (instancetype)initWithSubscribeLineId:(NSString *)subscribeLineId departCode:(NSString *)departCityCode destinationCityCode:(NSString *)destinationCityCode truckTypeId:(NSString *)truckTypeId truckLengthId:(NSString *)truckLengthId {
    
    self = [super init];
    if (self) {
        
        _subscribeLineId = subscribeLineId;
        _departCityCode = departCityCode;
        _destinationCityCode = destinationCityCode;
        _truckTypeId = truckTypeId;
        _truckLengthId = truckLengthId;
    }
    return self;
}

- (id)businessParameters {
    
    return @{
             @"subscribe_line_id":_subscribeLineId,
             @"depart_city_code":_departCityCode,
             @"destination_city_code":_destinationCityCode,
             @"truck_type_id":_truckTypeId,
             @"truck_length_id":_truckLengthId
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/updatesubscribeline";
}

- (NSString *)destination {
    
    return @"subscribeline.updatesubscribeline";
}
@end
