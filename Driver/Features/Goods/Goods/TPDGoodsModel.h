//
//  TPDGoodsModel.h
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
@class TPDOwnerModel;
@interface TPDOwnerModel: NSObject

@property (nonatomic , copy) NSString *owner_id;//货主id

@property (nonatomic , copy) NSString *owner_name;//货主名字

@property (nonatomic , copy) NSString *owner_icon_url;//货主头像url 匿名开启时不返回

@property (nonatomic , copy) NSString *owner_icon_key;//货主头像key 匿名开启时不返回

@property (nonatomic , copy) NSString *owner_comment_level;//货主星星级别

@property (nonatomic , copy) NSString *owner_mobile;//货主手机号码

@property (nonatomic , copy) NSString *sex;//性别 1女2男

@property (nonatomic , copy) NSString *is_anonymous;//0否 1是

@end

@interface TPDGoodsModel : NSObject

@property (nonatomic, copy) NSString *depart_city; //出发地

@property (nonatomic, copy) NSString  *destination_city;//目的地

@property (nonatomic, copy) NSString *latitude;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, copy) NSString *goods_id;//货源id

@property (nonatomic, copy) NSString *update_time;//更新时间

@property (nonatomic , copy) NSString *the_goods;//货物类型，货物数量、货物单位 拼接的总字符）

@property (nonatomic , copy) NSString *tuck_length_type;//车型车长拼接的总字符串

@property (nonatomic, copy) NSString * goods_version;//货源数据版本

@property (nonatomic , copy) NSString *is_call;//是否对此货源拨打过电话 0:没打过 1：打过

@property (nonatomic , copy) NSString *is_examine;//是否查看过货源

@property (nonatomic , copy) NSString *is_receive_order;//是否接单过

@property (nonatomic , copy) NSString *listen_single_content;//听单接口的播报内容

@property (nonatomic , copy) NSString *goods_status;//货源状态

@property (nonatomic , strong) TPDOwnerModel *owner_info;//货主信息

/* 货源活动增加的字段 */ 
@property (nonatomic , copy) NSString *Icon_key;//好货节活动标识头像key

@property (nonatomic , copy) NSString *Icon_url;//好货节活动标识头像url

@property (nonatomic , copy) NSString *Icon_image_key;//好货节补贴金额图key

@property (nonatomic , copy) NSString *Icon_image_url;//好货节补贴金额图url


@end
