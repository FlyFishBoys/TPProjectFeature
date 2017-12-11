//
//  TPDMyVehicleTeamModel.h
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDMyVehicleTeamModel : NSObject
/*
 driver_truck_id    司机车辆id    string
 truck_icon_key    车头照key    string
 truck_icon_url    车头照url    string
 plate_no1    车牌照1级    string
 plate_no2    车牌照2级    string
 plate_no3    车牌照3级    string
 plate_color    车牌颜色    string    1 蓝色 2 黄色
 audit_status    认证状态    string    0 无需认证
 1 未认证
 2 已认证
 3 认证中
 4 认证失败
 truck_type_name    车型name    string
 truck_length_name    车长name    string
 truck_status    车辆状态    string    1 空车/求货中,2 休息
 driver_name    驾驶员姓名    string    备注信息
 driver_mobile    驾驶员手机号    string
 */

@property (nonatomic, copy) NSString * driver_truck_id;
@property (nonatomic, copy) NSString * truck_icon_key;
@property (nonatomic, copy) NSString * truck_icon_url;
@property (nonatomic, copy) NSString * plate_no1;
@property (nonatomic, copy) NSString * plate_no2;
@property (nonatomic, copy) NSString * plate_no3;
@property (nonatomic, copy) NSString * plate_color;
@property (nonatomic, copy) NSString * audit_status;
@property (nonatomic, copy) NSString * truck_type_name;
@property (nonatomic, copy) NSString * truck_length_name;
@property (nonatomic, copy) NSString * truck_status;
@property (nonatomic, copy) NSString * driver_name;
@property (nonatomic, copy) NSString * driver_mobile;

@end
