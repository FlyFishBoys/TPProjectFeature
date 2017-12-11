//
//  TPDVehicleCertificationDataManager.m
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleCertificationDataManager.h"
#import "TPDModifyVehicleCerificationAPI.h"
#import "TPDVehicleCerificationAPI.h"
#import "TPDVehicleCertificationModel.h"
#import "TPDVehicleCertificationViewModel.h"

@implementation TPDVehicleCertificationDataManager

- (void)modifyVehicleCertificationWithModel:(TPDVehicleCertificationModel *)model completeBlock:(RequestCompleteBlock)completeBlock {
    
    TPDModifyVehicleCerificationAPI * modifyVehicleCerificationAPI = [[TPDModifyVehicleCerificationAPI alloc]initWithModel:model];
    modifyVehicleCerificationAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        if ( success && !error) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    
    [modifyVehicleCerificationAPI start];
}

- (void)getVehicleCertificationWithCompleteBlock:(RequestViewModelCompleteBlock)completeBlock {
    TPDVehicleCerificationAPI * vehicleCerificationAPI = [[TPDVehicleCerificationAPI alloc]init];
    vehicleCerificationAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        if (success && error == nil) {
            TPDVehicleCertificationModel * model = [TPDVehicleCertificationModel yy_modelWithJSON:responseObject];
            TPDVehicleCertificationViewModel * viewModel = [[TPDVehicleCertificationViewModel alloc] initWithModel:model];
            completeBlock(YES,nil,viewModel);
        } else {
            completeBlock(NO,error,nil);
        }
    };
    
    [vehicleCerificationAPI start];
}
@end
