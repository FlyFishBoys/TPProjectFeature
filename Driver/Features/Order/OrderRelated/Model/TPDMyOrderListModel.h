//
//  TPDMyOrderListModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPSenderReceiverModel.h"

/*
 goods_id    货源ID    是    String
 order_id    订单ID    是    String
 order_version    订单数据版本    是    String
 pickup_start_time    提货时间    是    String
 freight_fee    运费总金额    是    String
 is_freight_fee_managed    是否托管    是    String    0不托管 1托管
 delivery_fee    到付费金额    是    String
 delivery_fee_status    到付费状态    是    String    0.不托管 1.未托管 2.未支付 3.已支付
 order_status    订单状态    是    String    1.货主取消交易 2.货主确认成交 3.待支付定金 4.待支付运费 5.提货中 6.承运中 7.已承运
 agency_fee    定金金额    是    String
 owner_id    货主id    是    String
 owner_icon_key    货主头像Key    是    String
 owner_icon_url    货主头像Url    是    String
 owner_name    货主姓名    是    String
 owner_mobile    货主手机号    是    String
 owner_comment_level    货主发货诚信    是    String
 order_update_time    订单修改时间    是    String
 pickup_code    提货码    是    String
 sender_info    发货人信息    是    String
 receiver_info    收货人信息    是    String
 */

@interface TPDMyOrderListModel : NSObject
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * goods_status;
@property (nonatomic, copy) NSString * order_version;
@property (nonatomic, copy) NSString * pickup_start_time;
@property (nonatomic, copy) NSString * freight_fee;
@property (nonatomic, copy) NSString * is_freight_fee_managed;
@property (nonatomic, copy) NSString * delivery_fee;
@property (nonatomic, copy) NSString * delivery_fee_status;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * agency_fee;
@property (nonatomic, copy) NSString * owner_id;
@property (nonatomic, copy) NSString * owner_icon_key;
@property (nonatomic, copy) NSString * owner_icon_url;
@property (nonatomic, copy) NSString * owner_name;
@property (nonatomic, copy) NSString * owner_mobile;
@property (nonatomic, copy) NSString * owner_comment_level;
@property (nonatomic, copy) NSString * order_update_time;
@property (nonatomic, copy) NSString * pickup_code;
@property (nonatomic, strong) TPSenderReceiverModel * sender_info;
@property (nonatomic, strong) TPSenderReceiverModel * receiver_info;


@end
