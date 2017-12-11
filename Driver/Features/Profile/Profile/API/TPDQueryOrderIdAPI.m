//
//  TPDQueryOrderIdAPI.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDQueryOrderIdAPI.h"

@implementation TPDQueryOrderIdAPI
{
    NSString * _goodsId;
}

- (instancetype)initWithGoodsId:(NSString *)goodsId {
    if (self = [super init]) {
        _goodsId = goodsId;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"/order-service/ownerorder/selectorderidbygoodsid";
}

- (nullable NSString *)destination {
    return @"ownerorder.selectorderidbygoodsid";
}

- (id)businessParameters {
    return @{
             @"goods_id":_goodsId.isNotBlank ? _goodsId : @"",
             };
}
@end
