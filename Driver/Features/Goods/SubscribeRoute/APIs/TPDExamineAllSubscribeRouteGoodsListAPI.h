//
//  TPDExamineAllSubscribeRouteGoodsListAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDExamineAllSubscribeRouteGoodsListAPI : TPBaseAPI
/**
 查看所有订阅路线货源列表
 
 @param page 页码
 */
- (instancetype)initWithPage:(NSString *)page;
@end
