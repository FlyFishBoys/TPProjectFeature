//
//  TPDGoodsDetailAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDGoodsDetailAPI : TPBaseAPI

/**
 用goodId初始化
 
 @param goodId 货源Id
 @return 初始化对象
 */
- (instancetype)initWithGoodsId:(NSString *)goodId;
@end
