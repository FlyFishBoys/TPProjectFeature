//
//  TPDModifySubscribeRoutetQueryTimeAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDModifySubscribeRoutetQueryTimeAPI : TPBaseAPI

/**
 修改订阅路线查询时间

 @param subscribeLineId 订阅路线id
 @return object
 */
- (instancetype)initWithSubscribeLineId:(NSString *)subscribeLineId;
@end
