//
//  TPDVehicleCertificationModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDVehicleCertificationModel : NSObject

/**
 参数名	             中文名	      必填     	类型	    说明
 plate_no1	         车牌号码第1级	  是	        string	京A123456 京字为第一级号码
 plate_no2	         车牌号码第2级	  是		    string	京A123456 A为第2级号码
 plate_no3	         车牌号码第3级	  是		    string	京A123456 123456字为第3级号码
 plate_color	     车牌颜色	      是			string	1 蓝色 2 黄色
 truck_typeId	     车型id	      是			string
 truck_lengthId	     车长id	      是			string
 truck_head_img	     车头照	      是			string	Base64
 driver_license_img	 行驶证照片	  是			string	Base64
 driver_truck_id    车辆信息id    string
 truck_length    车型    string
 truck_type    车长    string
 truck_head_img_key    车头照key    string
 truck_head_img_url    车头照url    string
 driver_license_img_key    行驶证照片key    string
 driver_license_img_url    行驶证照片url    string
 audit_status    认证状态    string    1 未认证 2 已认证 3 认证中 4 认证失败
 audit_status_remark    审核备注    string
 */

@property (nonatomic, copy) NSString * plate_no1;
@property (nonatomic, copy) NSString * plate_no2;
@property (nonatomic, copy) NSString * plate_no3;
@property (nonatomic, copy) NSString * plate_color;
@property (nonatomic, copy) NSString * truck_typeId;
@property (nonatomic, copy) NSString * truck_lengthId;
@property (nonatomic, copy) NSString * truck_head_img;
@property (nonatomic, copy) NSString * driver_license_img;
@property (nonatomic, copy) NSString * driver_truck_id;
@property (nonatomic, copy) NSString * truck_length;
@property (nonatomic, copy) NSString * truck_type;
@property (nonatomic, copy) NSString * truck_head_img_key;
@property (nonatomic, copy) NSString * truck_head_img_url;
@property (nonatomic, copy) NSString * driver_license_img_key;
@property (nonatomic, copy) NSString * driver_license_img_url;
@property (nonatomic, copy) NSString * audit_status;
@property (nonatomic, copy) NSString * audit_status_remark;

@end
