//
//  TPDListenOrderDataStorage.m
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderDataStorage.h"
#import "NSFileManager+Category.h"
#import "TPDGoodsModel.h"
#import "TPUserServices.h"

static NSString * const ListenOrderDirectoryName = @"ListenOrder";
@implementation TPDListenOrderDataStorage

- (void)obtainListenOrderDataCompleteBlock:(ListenOrderObtainCompleteBlock)completeBlock{
    
    [NSFileManager getModelObjectByFileName:[self listenOrderFileName] directoryName:ListenOrderDirectoryName completeBlock:^(BOOL succeed, id result) {
        
        if (completeBlock) {
            completeBlock(succeed,result);
        }
    }];
    
}

- (void)recordSingleListenOrderDataWithModel:(TPDGoodsModel *)model completeBlock:(ListenOrderObtainCompleteBlock)completeBlock {
    
    if (model == nil || [model isKindOfClass:[NSNull class]] || ![model.goods_id isNotBlank]) {
        return;
    }
    [self obtainListenOrderDataCompleteBlock:^(BOOL succeed, NSMutableArray<TPDGoodsModel *> *result) {
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:result];
        //当大于20条的时候 移除最后一条
        if (arr.count >= 20) {
            [arr removeLastObject];
        }
        
        [arr enumerateObjectsUsingBlock:^(TPDGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ( [model.goods_id isEqualToString:obj.goods_id]) {
                 [arr removeObjectAtIndex:idx];
            }
        }];
        if (arr.count == 0) {
            [arr addObject:model];
        }else{
            [arr insertObject:model atIndex:0];
        }
        
        [self recordListenOrderDataWithObject:arr completeBlock:^(BOOL succeed) {
            if (completeBlock) {
                completeBlock(succeed,arr);
            }
        }];
    }];
    
}
- (void)recordListenOrderDataWithObject:(id)object completeBlock:(ListenOrderRecordCompleteBlock)completeBlock {
    
    BOOL succeeds = [NSFileManager saveModelObject:object directoryName:ListenOrderDirectoryName fileName:[self listenOrderFileName]];
    
    if (completeBlock) {
        completeBlock(succeeds);
    }
    
}
- (void)removeListenOrderDataWithCompleteBlock:(ListenOrderRecordCompleteBlock)completeBlock {
    
    BOOL succeeds = [NSFileManager deleteFileWithPath:[NSFileManager sanBoxFilePathWithFileName:[ListenOrderDirectoryName stringByAppendingString:[NSString stringWithFormat:@"/%@",[self listenOrderFileName]]]]];
    if (completeBlock) {
        completeBlock(succeeds);
    }
    
}


- (void)removeSingleListenOrderDataWithGoodsId:(NSString *)goodsId completeBlock:(ListenOrderObtainCompleteBlock)completeBlock {
    
    [self obtainListenOrderDataCompleteBlock:^(BOOL succeed, NSMutableArray<TPDGoodsModel *> *result) {
        
        [result enumerateObjectsUsingBlock:^(TPDGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.goods_id isEqualToString:goodsId]) {
                
                [result removeObject:obj];
            }
            
        }];
        
        [self recordListenOrderDataWithObject:result completeBlock:^(BOOL succeed) {
            if (completeBlock) {
                completeBlock(succeed,result);
            }
        }];
        
    }];
    
}

- (NSString *)listenOrderFileName {
    
    return [NSString stringWithFormat:@"ListenOrder%@.plist",[TPUserServices currentUserModel].user_id];
    
}
@end

