//
//  TPDNearbyMapStaticalModel.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearbyMapStaticalModel.h"

@implementation TPDNearbyMapStaticalModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"near_goods_response_list" : [TPDGoodsModel class],
             };
    
}
@end
