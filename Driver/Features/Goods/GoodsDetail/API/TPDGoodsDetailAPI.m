//
//  TPDGoodsDetailAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsDetailAPI.h"

@interface TPDGoodsDetailAPI ()
{
    NSString *_goodsId;
}
@end

@implementation TPDGoodsDetailAPI

- (instancetype)initWithGoodsId:(NSString *)goodId {
    if (self = [super init]) {
        _goodsId = goodId;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"order-service/driverorder/drivergoodsinfo";
}

- (nullable NSString *)destination {
    return @"driverorder.drivergoodsinfo";
}

- (id)businessParameters {
    return @{
             @"goods_id":_goodsId.isNotBlank ? _goodsId : @"",
             };
}

- (BOOL)shouldShowLoadingHUD {
    return NO;
}

@end
