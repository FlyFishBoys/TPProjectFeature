//
//  TPDAddConstantCityDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDConstantCityDataManager.h"
#import "TPDUpdateConstantCityAPI.h"
#import "TPDObtainConstantCityListAPI.h"
#import "TPDConstantCityModel.h"
#import "TPLocationServices.h"
#import "TPCityAdressService.h"
#import "TPDObtainPerasonCenterConstantCityAPI.h"
#import "TPDSubmitConstantCityAPI.h"
@implementation TPDConstantCityDataManager

+ (void)requestUpdateConstantCityWithConstantCityArr:(NSMutableArray *)arr  completeBlock:(RequesConstantCitytCompleteBlock)completeBlock{
    
    TPShowLoading;
    TPDUpdateConstantCityAPI *api  = [[TPDUpdateConstantCityAPI alloc]initUpdateConstantCityAPIWithArr:arr];
    
    
    api.filterCompletionHandler = ^(BOOL success,id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        TPHiddenLoading;
        if (error == nil && success) {
            
            completeBlock(YES);
        }
        else{
            completeBlock(NO);
        }
    };
    
    
    [api start];
    
    
}


+ (void)requestConstantCityListAPIWithCompleteBlock:(RequestConstantCityListCompleteBlock)completeBlock {
    
    TPDObtainConstantCityListAPI *api = [[TPDObtainConstantCityListAPI alloc]init];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
    

        if (error == nil && success) {
            
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:[TPDConstantCityModel class] json:responseObject[@"list"]];
            completeBlock(YES,tempArr,error);
        }
        else{
            completeBlock(NO,responseObject,error);
        }
   };
   
 [api start];
}



+ (void)requestPersonCenterConstantCityListAPIWithCompleteBlock:(RequestConstantCityListCompleteBlock)completeBlock {
    
    TPDObtainPerasonCenterConstantCityAPI *api = [[TPDObtainPerasonCenterConstantCityAPI alloc]init];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        
        if (error == nil && success) {
            
            NSArray *tempArr = [NSArray yy_modelArrayWithClass:[TPDConstantCityModel class] json:responseObject[@"list"]];
            completeBlock(YES,tempArr,error);
        }
        else{
            completeBlock(NO,responseObject,error);
        }
    };
    
    [api start];
    
    
}


+ (void)requestPersonCenterSubmitConstantCityAPIWithAddBusinessLineCityCodes:(NSArray <NSString *>*)addBusinessLineCityCodes updateBusinessLines:(NSArray <TPDConstantCityModel *>*)updateBusinessLines deleteBusinessLineIds:(NSArray <NSString *>*)deleteBusinessLineIds completeBlock:(RequestConstantCityListCompleteBlock)completeBlock {
    
    TPDSubmitConstantCityAPI *api = [[TPDSubmitConstantCityAPI alloc]initWithAddBusinessLineCityCodes:addBusinessLineCityCodes updateBusinessLines:updateBusinessLines deleteBusinessLineIds:deleteBusinessLineIds];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        
        if (error == nil && success) {
            
          completeBlock(YES,responseObject,error);
        }
        else{
            completeBlock(NO,responseObject,error);
        }
    };
    
    [api start];
    

}


@end
