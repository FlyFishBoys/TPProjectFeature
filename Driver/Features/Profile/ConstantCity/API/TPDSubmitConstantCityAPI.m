//
//  TPDModifyConstantCityAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubmitConstantCityAPI.h"
#import "TPDConstantCityModel.h"
@implementation TPDSubmitConstantCityAPI {
    
    NSArray *_addBusinessLineCityCodes,*_updateBusinessLines,*_deleteBusinessLineIds;
    
}

- (instancetype)initWithAddBusinessLineCityCodes:(NSArray <NSString *>*)addBusinessLineCityCodes updateBusinessLines:(NSArray <TPDConstantCityModel *>*)updateBusinessLines deleteBusinessLineIds:(NSArray <NSString *>*)deleteBusinessLineIds {
    
    self = [super init];
    if (self) {
        _addBusinessLineCityCodes = [NSArray arrayWithArray:addBusinessLineCityCodes];
        _updateBusinessLines = [NSArray arrayWithArray:updateBusinessLines];
        _deleteBusinessLineIds = [NSArray arrayWithArray:deleteBusinessLineIds];
    }
    return self;
}

- (id)businessParameters {
    return @{
             @"add_business_line_city_codes":_addBusinessLineCityCodes?[_addBusinessLineCityCodes yy_modelToJSONObject]:@[],
             @"update_business_lines":_updateBusinessLines?[_updateBusinessLines yy_modelToJSONObject]:@[],
             @"delete_business_line_ids":_deleteBusinessLineIds?[_deleteBusinessLineIds yy_modelToJSONObject]:@[]
             };
    
}

- (NSString *)requestMethod {
    
    return @"truck-service/truck/businesslinecentre";
}

- (NSString *)destination {
    
    return @"truck.businesslinecentre";
}
@end
