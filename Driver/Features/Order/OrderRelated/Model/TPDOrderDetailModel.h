//
//  TPDOrderDetailModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPSenderReceiverModel.h"
#import "TPDOrderDetailShipperInfoModel.h"
#import "TPOrderFreightModel.h"
#import "TPRefundModel.h"

@interface TPDOrderDetailModel : NSObject

/*
 order_id    订单ID    是    string
 order_no    订单号    是    string
 order_status    订单状态    是    string
 order_version    订单数据版本    是    string
 remark    备注信息    是    string
 remark_img_key    备注图片key    是    string
 remark_img_url    备注图片url    是    string
 other_remark    其他备注信息    是    string
 update_time    更新时间    是    string
 pickup_code    提货码    是    list    货主确认发送后会返回
 owner_info    货主信息    是    Object    结构见下表
 freight    运费信息    是    Object    结构见下表
 sender_info    发货人信息    是    Object    结构见下表
 receiver_info    收货人信息    是    Object    结构见下表
 refund_info    退款单信息    是    Object    结构见下表

 */

@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * order_no;
@property (nonatomic, copy) NSString * order_status;
@property (nonatomic, copy) NSString * order_version;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * remark_img_key;
@property (nonatomic, copy) NSString * remark_img_url;
@property (nonatomic, copy) NSString * other_remark;
@property (nonatomic, copy) NSString * update_time;
@property (nonatomic, copy) NSString * pickup_code;
@property (nonatomic, strong) TPDOrderDetailShipperInfoModel * owner_info;
@property (nonatomic, strong) TPOrderFreightModel * freight;
@property (nonatomic, strong) TPSenderReceiverModel * sender_info;
@property (nonatomic, strong) TPSenderReceiverModel * receiver_info;
@property (nonatomic, strong) TPRefundModel * refund_info;

@end
