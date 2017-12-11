//
//  TPDMyVehicleTeamCell.h
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"
@class TPDMyVehicleTeamCell;

@protocol TPDMyVehicleTeamCellDelegate <NSObject>
/**

 @param myVehicleTeamCell 车辆列表cell
 @param driverTruckId 司机车辆id
 @param truckStatus 车辆状态
 @param button 切换求货状态的按钮
 */
- (void)myVehicleTeamCell:(TPDMyVehicleTeamCell *)myVehicleTeamCell driverTruckId:(NSString *)driverTruckId truckStatus:(NSString *)truckStatus button:(UIButton *)button;
@end

@interface TPDMyVehicleTeamCell : TPBaseTableViewCell

@property (nonatomic,weak) id<TPDMyVehicleTeamCellDelegate> delegate;
@end
