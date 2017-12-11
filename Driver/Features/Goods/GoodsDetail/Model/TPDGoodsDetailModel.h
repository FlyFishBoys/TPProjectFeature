//
//  TPDGoodsDetailModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPSenderReceiverModel.h"
#import "TPDOrderDetailShipperInfoModel.h"

@interface TPDGoodsDetailModel : NSObject

/*
 goods_id    货源ID    是    string
 goods_no    货源号    是    string
 goods_version    货源数据版本    是    string
 remark    备注信息    是    string
 remark_img_key    备注图片key    是    string
 remark_img_url    备注图片url    是    string
 other_remark    其他备注信息    是    string
 goods_push_num    推送总数    是    string
 offer_sum    报价总数    是    string
 update_time    更新时间    是    string
 pre_goods_id    报价ID    是    string
 is_offer    是否报价    是    string    0：未报价 1：已报价
 transport_fee    运费/报价    是    string
 deposit_fee    定金    是    string
 pre_goods_version    报价version    是    string
 distance    距离    是    string    如果没有传司机定位的经纬度，则不会返回
 the_total_distance    总距离    是    string
 owner_info    货主信息    是    Object    结构见下表
 sender_info    发货人信息    是    Object    结构见下表
 receiver_info    收货人信息    是    Object    结构见下表
 goods_status    货源状态    是    string
 */

@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * goods_no;
@property (nonatomic, copy) NSString * goods_version;
@property (nonatomic, copy) NSString * goods_status;
@property (nonatomic, copy) NSString * remark;
@property (nonatomic, copy) NSString * remark_img_key;
@property (nonatomic, copy) NSString * remark_img_url;
@property (nonatomic, copy) NSString * other_remark;
@property (nonatomic, copy) NSString * goods_push_num;
@property (nonatomic, copy) NSString * offer_sum;
@property (nonatomic, copy) NSString * pre_goods_id;
@property (nonatomic, copy) NSString * is_offer;
@property (nonatomic, copy) NSString * update_time;
@property (nonatomic, copy) NSString * transport_fee;
@property (nonatomic, copy) NSString * deposit_fee;
@property (nonatomic, copy) NSString * pre_goods_version;
@property (nonatomic, copy) NSString * distance;
@property (nonatomic, copy) NSString * the_total_distance;
@property (nonatomic, strong) TPSenderReceiverModel * sender_info;
@property (nonatomic, strong) TPSenderReceiverModel * receiver_info;
@property (nonatomic, strong) TPDOrderDetailShipperInfoModel * owner_info;

@end
