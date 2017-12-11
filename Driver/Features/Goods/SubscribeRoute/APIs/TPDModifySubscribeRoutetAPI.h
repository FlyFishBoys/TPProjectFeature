//
//  TPDEditSubscribeRoutetAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDModifySubscribeRoutetAPI : TPBaseAPI
/**
 修改订阅路线
 
 @param subscribeLineId 订阅路线id
 @param departCityCode 出发地 cityId
 @param destinationCityCode 目的地cityId
 @param truckTypeId 车型ID
 @param truckLengthId 车长ID
 @return object
 */
- (instancetype)initWithSubscribeLineId:(NSString *)subscribeLineId departCode:(NSString *)departCityCode destinationCityCode:(NSString *)destinationCityCode truckTypeId:(NSString *)truckTypeId truckLengthId:(NSString *)truckLengthId;
@end
