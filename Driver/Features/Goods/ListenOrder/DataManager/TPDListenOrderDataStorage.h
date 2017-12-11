//
//  TPDListenOrderDataStorage.h
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//听单数据存储

#import <Foundation/Foundation.h>
@class TPDGoodsModel;
typedef void (^ListenOrderRecordCompleteBlock)(BOOL succeed);
typedef void (^ListenOrderObtainCompleteBlock)(BOOL succeed,NSMutableArray<TPDGoodsModel *> *result);
@interface TPDListenOrderDataStorage : NSObject

/**
 保存单条听单数据
 
 @param model 数据
 @param completeBlock completeBlock
 */
- (void)recordSingleListenOrderDataWithModel:(TPDGoodsModel *)model completeBlock:(ListenOrderObtainCompleteBlock)completeBlock;



/**
 保存objcet
 
 @param object object description
 @param completeBlock completeBlock description
 */
- (void)recordListenOrderDataWithObject:(id)object completeBlock:(ListenOrderRecordCompleteBlock)completeBlock;


/**
 获取听单数据
 
 @param completeBlock completeBlock
 */
- (void)obtainListenOrderDataCompleteBlock:(ListenOrderObtainCompleteBlock)completeBlock;


/**
 删除听单数据
 
 @param completeBlock completeBlock description
 */
- (void)removeListenOrderDataWithCompleteBlock:(ListenOrderRecordCompleteBlock)completeBlock;


/**
 删除单条听单数据 根据goodsId
 
 @param completeBlock completeBlock description
 */
- (void)removeSingleListenOrderDataWithGoodsId:(NSString *)goodsId completeBlock:(ListenOrderObtainCompleteBlock)completeBlock;

@end
