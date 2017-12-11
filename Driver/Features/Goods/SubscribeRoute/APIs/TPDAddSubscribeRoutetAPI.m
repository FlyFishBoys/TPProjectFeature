//
//  TPDAddSubscribeRoutetAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddSubscribeRoutetAPI.h"

@implementation TPDAddSubscribeRoutetAPI {
    
       NSString *_departCityCode,*_destinationCityCode,*_truckTypeId,*_truckLengthId;
}
- (instancetype)initWithDepartCode:(NSString *)departCityCode destinationCityCode:(NSString *)destinationCityCode truckTypeId:(NSString *)truckTypeId truckLengthId:(NSString *)truckLengthId  {
    
    self = [super init];
    if (self) {
        
        _departCityCode = departCityCode;
        _destinationCityCode = destinationCityCode;
        _truckTypeId = [truckTypeId isNotBlank] ?truckTypeId:@"";
        _truckLengthId = [truckLengthId isNotBlank] ? truckLengthId:@"";
    }
    return self;
}

- (id)businessParameters {
    return @{
             @"depart_city_code":_departCityCode,
             @"destination_city_code":_destinationCityCode,
             @"truck_type_id":_truckTypeId,
             @"truck_length_id":_truckLengthId
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/insertsubscribeline";
}

- (NSString *)destination {
    
    return @"subscribeline.insertsubscribeline";
}
@end
