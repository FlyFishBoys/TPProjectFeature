//
//  TPDAuthenticationDataManager.m
//  Driver
//
//  Created by Mr.mao on 2017/10/27.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAuthenticationDataManager.h"
#import "TPDAuthenticationAPI.h"
#import "TPDModifyAuthenticationAPI.h"
#import "TPDAuthenticationModel.h"

@implementation TPDAuthenticationDataManager

- (void)modifyAuthenticationWithModel:(TPDAuthenticationModel *)model completeBlock:(RequestCompleteBlock)completeBlock {
    TPDModifyAuthenticationAPI * modifyAuthenticationAPI = [[TPDModifyAuthenticationAPI alloc]initWithModel:model];
    
    modifyAuthenticationAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if ( success && !error) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    
    [modifyAuthenticationAPI start];
}

- (void)getAuthenticationWithCompleteBlock:(RequestModelCompleteBlock)completeBlock {
    TPDAuthenticationAPI * authenticationAPI = [[TPDAuthenticationAPI alloc]init];
    
    authenticationAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            TPDAuthenticationModel * model = [TPDAuthenticationModel yy_modelWithJSON:responseObject];
            completeBlock(YES,nil,model);
        } else {
            completeBlock(NO,error,nil);
        }
    };
    
    [authenticationAPI start];
}
@end
