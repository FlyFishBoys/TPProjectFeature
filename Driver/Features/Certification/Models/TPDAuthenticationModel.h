//
//  TPDAuthenticationModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDAuthenticationModel : NSObject
/**
 参数名	                中文名	    必填	  类型	说明
 driver_license_img    驾驶证    否    string
 driver_license_img_key    驾驶证key    否    string
 driver_operation_img    运营证    否    string
 driver_operation_img_key    运营证key    否    string
 version    数据版本    是    String
 driver_license_img_url    司机驾驶证url    string
 driver_operation_img_url    司机营运证url    string
 user_auth_status    审核状态    string    0、未认证 1、认证中 2、认证失败 3、认证通过
 user_auth_remark    审核备注    string
 */

//修改需要
@property (nonatomic, copy) NSString * driver_license_img;
@property (nonatomic, copy) NSString * driver_license_img_key;
@property (nonatomic, copy) NSString * driver_operation_img;
@property (nonatomic, copy) NSString * driver_operation_img_key;
@property (nonatomic, copy) NSString * version;
//获取需要
@property (nonatomic, copy) NSString * driver_license_img_url;
@property (nonatomic, copy) NSString * driver_operation_img_url;
@property (nonatomic, copy) NSString * user_auth_status;
@property (nonatomic, copy) NSString * user_auth_remark;

@end
