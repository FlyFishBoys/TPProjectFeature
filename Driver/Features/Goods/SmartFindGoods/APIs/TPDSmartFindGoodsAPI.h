//
//  TPSmartFindGoodsAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDSmartFindGoodsAPI : TPBaseAPI


/**
 智能找货 货源列表

 @param departCityCode 定位的城市id(出发地城市id)
 @param page 页码
 @return object
 */
- (instancetype)initWithDepartCode:(NSString *)departCityCode page:(NSString *)page;

@end
