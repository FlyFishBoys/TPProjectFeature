//
//  TPDListenOrderSetModel.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//听单设置模型

#import <Foundation/Foundation.h>

@interface TPDListenOrderSetModel : NSObject

@property (nonatomic , copy) NSString *type; //设置类型 : 1 出发地 2 常跑路线--目的地 3 自选路线--目的地

@property (nonatomic , copy) NSString *city_id;//城市id

@property (nonatomic , copy) NSString *city_name;//城市名字

@end
