//
//  TPDSeachSmartFindGoodsAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSeachSmartFindGoodsAPI.h"

@implementation TPDSeachSmartFindGoodsAPI {
    
    NSString *_departCityCode,*_destinationCityCode,*_truckTypeId,*_truckLengthId;
    NSString *_page;
    
}
- (instancetype)initWithDepartCode:(NSString *)departCityCode destinationCityCode:(NSString *)destinationCityCode truckTypeId:(NSString *)truckTypeId truckLengthId:(NSString *)truckLengthId page:(NSString *)page {
    
    self = [super init];
    if (self) {
     
        _departCityCode = departCityCode;
        _destinationCityCode = destinationCityCode;
        _truckTypeId = truckTypeId;
        _truckLengthId = truckLengthId;
        _page = page;
        
    }
    return self;
}

- (id)businessParameters {
    
    return @{@"truck_type_id":[_truckTypeId isNotBlank]?_truckTypeId:@"",
             @"truck_length_id":[_truckLengthId isNotBlank]?_truckLengthId:@"",
             @"destination_city_code":[_destinationCityCode isNotBlank]?_destinationCityCode:@"",
             @"start_city_id":_departCityCode,
             @"page":_page
             };
}

- (NSString *)requestMethod {
    
    return @"order-service/drivergoods/findgoodslistbydriver";
}

- (NSString *)destination {
    
    return @"drivergoods.findgoodslistbydriver";
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
