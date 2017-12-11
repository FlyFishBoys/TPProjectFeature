//
//  TPDFreightAgrentModel.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//货运经纪人

#import <Foundation/Foundation.h>

@interface TPDFreightAgrentModel : NSObject

//货运经济人id
@property (nonatomic , copy) NSString *broker_id;

//姓名
@property (nonatomic , copy) NSString *name;

//手机号
@property (nonatomic , copy) NSString *mobile;

//是否打过电话
@property (nonatomic , copy) NSString *is_call;

//用户头像key
@property (nonatomic , copy) NSString *icon_key;

//用户头像url
@property (nonatomic , copy) NSString *icon_url;

//经营路线 出发地1
@property (nonatomic , copy) NSString *broker_route_begin_city_1;

//经营路线 目的地1
@property (nonatomic , copy) NSString *broker_route_end_city_1;

//经营路线 出发地2
@property (nonatomic , copy) NSString *broker_route_begin_city_2;

//经营路线 目的地2
@property (nonatomic , copy) NSString *broker_route_end_city_2;

//经营路线 出发地3
@property (nonatomic , copy) NSString *broker_route_begin_city_3;

//经营路线 目的地3
@property (nonatomic , copy) NSString *broker_route_end_city_3;



@end
