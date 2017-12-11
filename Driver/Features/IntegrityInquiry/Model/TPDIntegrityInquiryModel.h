//
//  TPDIntegrityInquiryModel.h
//  Driver
//
//  Created by Mr.mao on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDIntegrityInquiryModel : NSObject

/*
 user_id    用户id    String
 icon_image_key    头像key    String
 icon_image_url    头像url    String
 user_name    用户姓名    String
 user_mobile    用户手机号    String
 user_type    用户类型    String    1 : 司机 2 : 货主',
 use_status    实名认证状态    String    0：认证未通过 1：认证通过
 user_auth_status    身份认证状态    String    0：认证未通过 1：认证通过
 truck_status    车辆认证状态    String    0：认证未通过 1：认证通过 （只有用户是司机才反）
 degree_of_praise    好评度    String
 evaluation_score    评价得分    String
 integrity_value    诚信值    String
 integrity_value_level    诚信值等级    String
 shipments_or_receiving_num    发货/接单数    String
 clinch_a_deal_num    成交数    String
 */

@property (nonatomic,copy) NSString * user_id;
@property (nonatomic,copy) NSString * icon_image_key;
@property (nonatomic,copy) NSString * icon_image_url;
@property (nonatomic,copy) NSString * user_name;
@property (nonatomic,copy) NSString * user_mobile;
@property (nonatomic,copy) NSString * user_type;
@property (nonatomic,copy) NSString * use_status;
@property (nonatomic,copy) NSString * user_auth_status;
@property (nonatomic,copy) NSString * truck_status;
@property (nonatomic,copy) NSString * degree_of_praise;
@property (nonatomic,copy) NSString * evaluation_score;
@property (nonatomic,copy) NSString * integrity_value;
@property (nonatomic,copy) NSString * integrity_value_level;
@property (nonatomic,copy) NSString * shipments_or_receiving_num;
@property (nonatomic,copy) NSString * clinch_a_deal_num;

@end
