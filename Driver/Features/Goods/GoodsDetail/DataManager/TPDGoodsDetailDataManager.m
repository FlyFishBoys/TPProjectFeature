//
//  TPDGoodsDetailDataManager.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsDetailDataManager.h"
#import "TPDGoodsDetailAPI.h"
#import "TPDGoodsDetailModel.h"

@implementation TPDGoodsDetailDataManager
- (void)requestGoodsDetailWithGoodsId:(NSString *)goodsId completeBlock:(RequestModelCompleteBlock)completeBlock {
    TPDGoodsDetailAPI * goodsDetailAPI = [[TPDGoodsDetailAPI alloc]initWithGoodsId:goodsId];
    
    goodsDetailAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
                if (success && error == nil) {
                    TPDGoodsDetailModel * model = [TPDGoodsDetailModel yy_modelWithJSON:responseObject];
                    completeBlock(YES,nil,model);
                } else {
                    completeBlock(NO,error,nil);
                }
    };
    
    [goodsDetailAPI start];
}

@end
