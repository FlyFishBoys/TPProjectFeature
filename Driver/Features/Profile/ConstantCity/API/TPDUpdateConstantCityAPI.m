//
//  TPDAddConstantCityAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDUpdateConstantCityAPI.h"
#import "TPCityModel.h"
@implementation TPDUpdateConstantCityAPI{
    
    NSMutableArray *_arr;
}
- (instancetype)initUpdateConstantCityAPIWithArr:(NSMutableArray <TPAddressModel *>*)arr;{
    
    if (self = [super init]) {
        
        _arr = [NSMutableArray arrayWithArray:arr];
    }
    
    return self;
}

- (NSString *)destination {
    return @"truck.addbusinessline";
}
- (NSString *)requestMethod{
    return @"truck-service/truck/addbusinessline";
}
- (id)businessParameters {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSString *key = [@"business_line_city_code" stringByAppendingString:[NSString stringWithFormat:@"%lu",(unsigned long)idx+1]];
        NSString *value = [obj adcode];
        [dic setValue:value forKey:key];
        
    }];
    
    
    return dic;
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
