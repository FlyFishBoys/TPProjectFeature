//
//  TPDProfileDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/10/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileDataManager.h"
#import "TPDProfileParameterAPI.h"
#import "TPDProfileModel.h"
#import "TPDCheckInAPI.h"
@implementation TPDProfileDataManager
+ (void)requestPersonCenterParameterWithComplete:(TPDProfileDataManagerRequestComplete)complete {
    
    
    TPDProfileParameterAPI *api = [[TPDProfileParameterAPI alloc]init];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
            TPDProfileModel *model = [TPDProfileModel yy_modelWithJSON:responseObject];
            complete(YES,model,error);
        }else{
             complete(NO,responseObject,error);
        }
    };
    [api start];
}

+ (void)requestSignInAPIWithComplete:(TPDProfileDataManagerRequestComplete)complete  {
    TPDCheckInAPI *api = [[TPDCheckInAPI alloc]init];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
                complete(YES,responseObject[@"next_score"],error);
        }else{
            complete(NO,responseObject,error);
        }
    };
    [api start];
}
@end
