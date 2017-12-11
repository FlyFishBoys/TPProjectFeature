//
//  TPDIntegrityInquiryGoodsModel.h
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDIntegrityInquiryGoodsModel : NSObject

/*
 中文名    类型    说明
 goods_id    货源ID    String
 pre_goods_version    报价version    String
 pre_goods_id    报价ID    String
 depart_city    出发城市    String
 destination_city    目的地城市    String
 goods_size    货物数量    String
 truck_length_type    车长 车型    String
 transport_fee    运费    String
 deposit_fee    定金    String
 create_time    货源发布时间
 */

@property (nonatomic,copy) NSString * goods_id;
@property (nonatomic,copy) NSString * goods_version;
@property (nonatomic,copy) NSString * pre_goods_version;
@property (nonatomic,copy) NSString * pre_goods_id;
@property (nonatomic,copy) NSString * depart_city;
@property (nonatomic,copy) NSString * destination_city;
@property (nonatomic,copy) NSString * goods_size;
@property (nonatomic,copy) NSString * truck_length_type;
@property (nonatomic,copy) NSString * transport_fee;
@property (nonatomic,copy) NSString * deposit_fee;
@property (nonatomic,copy) NSString * create_time;
@end
