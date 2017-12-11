//
//  TPDMyVehicleTeamDataSource.h
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"
#import "TPDVehicleDefines.h"

@interface TPDMyVehicleTeamDataSource : TPBaseTableViewDataSource

- (instancetype _Nonnull)initWithTarget:(id _Nonnull)target;

//刷新我的车队列表数据
- (void)refreshMyVehicleTeamWithCompleteBlock:(RequestCompleteBlock _Nonnull )completeBlock;

//加载更多我的车队列表数据
- (void)loadMoreMyVehicleTeamWithCompleteBlock:(RequestListCompleteBlock _Nonnull )completeBlock;

//切换求货/休息状态
- (void)switchSeekGoodsStatusWithDriverTruckId:(NSString * _Nonnull)driverTruckId truckStatus:(NSString * _Nonnull)truckStatus completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

//全部求货/全部休息
- (void)switchSeekGoodsStatusAllWithTruckStatus:(NSString * _Nonnull)truckStatus completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

@end
