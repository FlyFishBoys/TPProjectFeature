//
//  TPDSwitchSeekGoodsStatusAllAPI.h
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDSwitchSeekGoodsStatusAllAPI : TPBaseAPI
/**
 我的车队--求货/休息状态切换
 
 @param truckStatus 车辆状态 : 1 空车/求货中,2 休息
 */
- (instancetype)initWithTruckStatus:(NSString *)truckStatus;
@end
