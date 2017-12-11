//
//  TPDOrderDetailDataManager.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDOrderDetailDataManager.h"
#import "TPDOrderDetailAPI.h"
#import "TPDOrderDetailModel.h"
#import "TPDGoodsSignInAPI.h"
#import "TPDConfirmPickUpAPI.h"
#import "TPDConfirmDealAPI.h"
#import "TPDCancelDealAPI.h"

@implementation TPDOrderDetailDataManager
- (void)requestGoodsDetailWithOrderId:(NSString *)orderId completeBlock:(RequestModelCompleteBlock)completeBlock {
    TPDOrderDetailAPI * orderDetailAPI = [[TPDOrderDetailAPI alloc]initWithOrderId:orderId];
    
    orderDetailAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
                if (success && error == nil) {
                    TPDOrderDetailModel * model = [TPDOrderDetailModel yy_modelWithJSON:responseObject];
                    completeBlock(YES,nil,model);
                } else {
                    completeBlock(NO,error,nil);
                }
    };
    
    [orderDetailAPI start];
}

- (void)goodsSignUpWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion unloadCode:(NSString * _Nullable)unloadCode completeBlock:(RequestCompleteBlock _Nonnull)completeBlock {
    TPDGoodsSignInAPI * goodsSignInAPI = [[TPDGoodsSignInAPI alloc]initWithOrderId:orderId orderVersion:orderVersion unloadCode:unloadCode];
    goodsSignInAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [goodsSignInAPI start];
}

- (void)confirmPickUpWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion pickupCode:(NSString *)pickupCode completeBlock:(RequestCompleteBlock)completeBlock {
    TPDConfirmPickUpAPI * confirmPickUpAPI = [[TPDConfirmPickUpAPI alloc]initWithOrderId:orderId orderVersion:orderVersion pickupCode:pickupCode];
    confirmPickUpAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [confirmPickUpAPI start];
}

- (void)confirmDealWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion completeBlock:(RequestCompleteBlock)completeBlock {
    TPDConfirmDealAPI * confirmDealAPI = [[TPDConfirmDealAPI alloc]initWithPreOrderId:orderId orderVersion:orderVersion];
    confirmDealAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [confirmDealAPI start];
}

- (void)cancelDealWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion completeBlock:(RequestCompleteBlock)completeBlock {
    TPDCancelDealAPI * cancelDealAPI = [[TPDCancelDealAPI alloc]initWithPreOrderId:orderId orderVersion:orderVersion];
    cancelDealAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [cancelDealAPI start];
}
@end
