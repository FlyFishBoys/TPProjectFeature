 //
//  TPSmartFindGoodsAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSmartFindGoodsAPI.h"

@implementation TPDSmartFindGoodsAPI
{
    NSString *_cityCode,*_page;
    
}
- (instancetype)initWithDepartCode:(NSString *)departCityCode page:(NSString *)page {
    
    self = [super init];
    if (self) {
       
        _cityCode = departCityCode;
        _page = page;
    }
    return self;
}

- (id)businessParameters {
    return @{@"start_city_code":[_cityCode isNotBlank]?_cityCode:@"",
             @"page":_page
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/drivergoods/searchsmartfindgoods";
}

- (NSString *)destination {
    
    return @"drivergoods.searchsmartfindgoods";
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
