//
//  TPNearSupplyMapModel.h
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsModel.h"

@interface TPGoodsStatistical : NSObject

@property (nonatomic, copy) NSString *city_id;
@property (nonatomic, copy) NSString *city_name;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *count;

@end

@interface TPNearSupplyMapModel : NSObject

@property (nonatomic, copy)   NSString *parameter_level;
@property (nonatomic, strong) NSArray <TPGoodsStatistical *> *goods_statistical;
@property (nonatomic, strong) NSArray <TPDGoodsModel *> *near_goods_response_list;

@end
