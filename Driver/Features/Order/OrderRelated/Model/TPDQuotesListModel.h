//
//  TPDQuotesListModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

/*
 pre_goods_id	报价ID	是	String
 goods_id	货源ID	是	String
 depart_city	出发城市	是	String
 destination_city	目的地城市	是	String
 goods_size	货物数量	是	String
 truck_length_type	车长 车型	是	String
 transport_fee	运费	是	String
 deposit_fee	定金	是	String
 update_time	修改时间	是	String
 distance	当前与出发地的距离	是	String	单位是米，请自行转换
 the_total_distance	总路程
 */

#import <Foundation/Foundation.h>

@interface TPDQuotesListModel : NSObject

@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * depart_city;
@property (nonatomic, copy) NSString * destination_city;
@property (nonatomic, copy) NSString * goods_size;
@property (nonatomic, copy) NSString * truck_length_type;
@property (nonatomic, copy) NSString * update_time;
@property (nonatomic, copy) NSString * distance;
@property (nonatomic, copy) NSString * pre_goods_id;
@property (nonatomic, copy) NSString * transport_fee;
@property (nonatomic, copy) NSString * deposit_fee;
@property (nonatomic, copy) NSString * the_total_distance;
@property (nonatomic, copy) NSString * pre_goods_version;

@end
