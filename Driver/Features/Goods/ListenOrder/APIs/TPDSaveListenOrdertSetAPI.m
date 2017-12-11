//
//  TPDSaveListenOrdertSetAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSaveListenOrdertSetAPI.h"
@implementation TPDSaveListenOrdertSetAPI {
    
    id _departObject,_optionalObject;
    NSArray *_commonArr;
}

- (instancetype)initWithDepartObject:(id)depart optional:(id)optional commonArr:(NSArray *)commonArr {
    
    if (self = [super init]) {
       
        _departObject = depart;
        _optionalObject = optional;
        _commonArr = [commonArr yy_modelToJSONObject];
    }
    return self;
    
}

- (id)businessParameters {
    if ([_optionalObject isKindOfClass:[NSNull class]] || _optionalObject == nil ) {
         return @{
                        @"depart":[_departObject yy_modelToJSONObject],
                        @"common":_commonArr
                        };
    }else{
        return @{
                 @"depart":[_departObject yy_modelToJSONObject],
                 @"optional":[_optionalObject yy_modelToJSONObject],
                 @"common":_commonArr
                 };
    }
    
}

- (NSString *)requestMethod {
    
    return @"order-service/listengoods/savesetting";
}

- (NSString *)destination {
    
    return @"listengoods.savesetting";
}
- (BOOL)shouldShowLoadingHUD {
    return NO;
}
@end
