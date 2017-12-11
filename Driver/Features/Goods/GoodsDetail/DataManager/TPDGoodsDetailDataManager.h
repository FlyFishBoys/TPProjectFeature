//
//  TPDGoodsDetailDataManager.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDOrderDefines.h"

@interface TPDGoodsDetailDataManager : NSObject

/**
 请求货源详情
 
 @param goodsId 货源id
 @param completeBlock 请求到的参数
 */
- (void)requestGoodsDetailWithGoodsId:(NSString * _Nullable)goodsId completeBlock:(RequestModelCompleteBlock _Nonnull)completeBlock;

@end
