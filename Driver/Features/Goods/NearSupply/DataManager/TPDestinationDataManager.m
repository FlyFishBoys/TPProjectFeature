//
//  TPDestinationDataManager.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDestinationDataManager.h"

#import "TPDObtainConstantCityListAPI.h"

#import "TPDConstantCityModel.h"

@implementation TPDestinationDataManager

+ (void)requestNearSupplyListCallback:(DestinationCompletionBlock)callback {
    
    TPDObtainConstantCityListAPI *api = [[TPDObtainConstantCityListAPI alloc] init];
    
    api.filterCompletionHandler = ^(BOOL success,id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        if (error == nil && success) {
            
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:[TPDConstantCityModel class] json:responseObject[@"list"]];
            callback(YES,tempArr,error);
        }
        else{
            callback(NO,responseObject,error);
        }

    };
    
    [api start];
    
}

@end
