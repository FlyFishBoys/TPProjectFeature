//
//  TPDAddModifyVehicleDataManager.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddModifyVehicleDataManager.h"
#import "TPDAddModifyVehicleModel.h"
#import "TPDAddVehicleAPI.h"
#import "TPDModifyVehicleAPI.h"

@implementation TPDAddModifyVehicleDataManager

- (void)addVehicleWithModel:(TPDAddModifyVehicleModel *)model completeBlock:(RequestCompleteBlock _Nonnull)completeBlock {
    TPDAddVehicleAPI * addVehicleAPI = [[TPDAddVehicleAPI alloc]initWithModel:model];
    addVehicleAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [addVehicleAPI start];
}

- (void)modifyVehicleWithModel:(TPDAddModifyVehicleModel *)model completeBlock:(RequestCompleteBlock)completeBlock {
    TPDModifyVehicleAPI * modifyVehicleAPI = [[TPDModifyVehicleAPI alloc]initWithModel:model];
    modifyVehicleAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [modifyVehicleAPI start];
}
@end
