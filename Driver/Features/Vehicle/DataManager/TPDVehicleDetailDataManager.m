//
//  TPDVehicleDetailDataManager.m
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleDetailDataManager.h"
#import "TPDVehicleDetailAPI.h"
#import "TPDVehicleDetailModel.h"
#import "TPDVehicleDetailViewModel.h"
#import "TPDDeleteVehicleAPI.h"

@implementation TPDVehicleDetailDataManager

- (void)getVehicleDetailWithDriverTruckId:(NSString *)driverTruckId completeBlock:(RequestViewModelCompleteBlock)completeBlock {
    TPDVehicleDetailAPI * vehicleDetailAPI = [[TPDVehicleDetailAPI alloc]initWithDriverTruckId:driverTruckId];
    vehicleDetailAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            TPDVehicleDetailModel * model = [TPDVehicleDetailModel yy_modelWithJSON:responseObject];
            TPDVehicleDetailViewModel * viewModel = [[TPDVehicleDetailViewModel alloc]initWithModel:model];
            completeBlock(YES,nil,viewModel);
        } else {
            completeBlock(NO,error,nil);
        }
    };
    [vehicleDetailAPI start];
}

- (void)deleteVehicleWithDriverTruckId:(NSString *)driverTruckId driverTruckVersion:(NSString *)driverTruckVersion completeBlock:(RequestCompleteBlock)completeBlock {
    TPDDeleteVehicleAPI * deleteVehicleAPI = [[TPDDeleteVehicleAPI alloc] initWithDriverTruckId:driverTruckId driverTruckVersion:driverTruckVersion];
    deleteVehicleAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [deleteVehicleAPI start];
}
@end
