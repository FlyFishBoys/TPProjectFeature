//
//  TPDMyVehicleTeamAPI.h
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDMyVehicleTeamAPI : TPBaseAPI

/**
 获取车队列表

 @param page  页数       初始为1
 @return  初始化对象
 */
- (instancetype)initWithPage:(NSInteger)page;
@end
