//
//  TPDListenOrderGoodsListAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDListenOrderGoodsListAPI : TPBaseAPI


/**
 听单货源列表

 @param startTime 开始时间
 @param departCityId 出发地
 @param destinationCityIdArr 目的地数组
 @return object
 */
- (instancetype)initWithStartTime:(NSString *)startTime departCityId:(NSString *)departCityId destinationCityIdArr:(NSMutableArray *)destinationCityIdArr;
@end
