//
//  TPDConstantCityModel.h
//  TopjetPicking
//
//  Created by lish on 2017/9/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//常跑城市model

#import <Foundation/Foundation.h>

@interface TPDConstantCityModel : NSObject

@property (nonatomic , copy) NSString *business_line_id; //常跑城市line-ID

@property (nonatomic , copy) NSString *driver_id;//司机id

@property (nonatomic , copy) NSString *business_line_city;//司机id

@property (nonatomic , copy) NSString *business_line_city_id;//常跑城市id

@end
