//
//  TPDDeleteSubscribeRoutetAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDDeleteSubscribeRoutetAPI : TPBaseAPI


/**
 删除订阅路线

 @param list 删除路线的列表
 @return object
 */
- (instancetype)initWithRouteIdList:(NSMutableArray *)list;
@end
