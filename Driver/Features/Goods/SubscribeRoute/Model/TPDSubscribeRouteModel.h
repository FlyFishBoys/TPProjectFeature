//
//  TPDSubscribeRouteModel.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDSubscribeRouteModel : NSObject


@property (nonatomic, copy) NSString *truck_type_length;//车型车长

@property (nonatomic, copy) NSString *depart_city;//出发地城市

@property (nonatomic, copy) NSString *subscribe_line_id;//订阅路线id

@property (nonatomic, copy) NSString *destination_city;//目的地城市

@property (nonatomic, copy) NSString *supply_of_goods_count;//订阅路线货源总数

@property (nonatomic, copy) NSString *destination_city_code;//目的地城市Code

@property (nonatomic, copy) NSString *depart_city_code;//出发地城市Code

@end
