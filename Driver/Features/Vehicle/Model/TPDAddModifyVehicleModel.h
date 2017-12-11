//
//  TPDAddModifyVehicleModel.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 driver_truck_id    司机车辆id    是    string
 plate_no1    车牌照1级    是    string
 plate_no2    车牌照2级    是    string
 plate_no3    车牌照3级    是    string
 plate_color    车牌颜色    是    string    1 蓝色 2 黄色
 truck_type_id    车型id    是    string
 truck_length_id    车长id    是    string
 truck_icon_img    车头照片    否    string
 truck_icon_key    车头照片key    否    string    如果没有修改图片,则直接传入服务端返回的key
 truck_license_img    行驶证照片    否    string
 truck_license_key    行驶证照片key    否    string    如果没有修改图片,则直接传入服务端返回的key
 driver_name    驾驶员姓名    否    string    备注信息
 driver_mobile    驾驶员手机号    否    string    备注信息
 driver_truck_version    司机车辆version    是    string
 */

@interface TPDAddModifyVehicleModel : NSObject
@property (nonatomic,copy) NSString * plate_no1;
@property (nonatomic,copy) NSString * plate_no2;
@property (nonatomic,copy) NSString * plate_no3;
@property (nonatomic,copy) NSString * plate_color;
@property (nonatomic,copy) NSString * truck_type_id;
@property (nonatomic,copy) NSString * truck_length_id;
@property (nonatomic,copy) NSString * truck_icon_img;
@property (nonatomic,copy) NSString * truck_license_img;
@property (nonatomic,copy) NSString * driver_name;
@property (nonatomic,copy) NSString * driver_mobile;
//修改车辆需要的参数
@property (nonatomic,copy) NSString * driver_truck_id;
@property (nonatomic,copy) NSString * driver_truck_version;
@property (nonatomic,copy) NSString * truck_icon_key;
@property (nonatomic,copy) NSString * truck_license_key;
@property (nonatomic,copy) NSString * truck_type_name;
@property (nonatomic,copy) NSString * truck_length_name;
@property (nonatomic,copy) NSString * truck_icon_url;
@property (nonatomic,copy) NSString * truck_license_url;
@end
