//
//  TPNearSupplyMapModel.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPNearSupplyMapModel.h"


@implementation TPGoodsStatistical

@end

@implementation TPNearSupplyMapModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"goods_statistical" : [TPGoodsStatistical class],
             @"near_goods_response_list" : [TPDGoodsModel class]
             };
    
}
@end


