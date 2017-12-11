//
//  TPDAddConstantCityAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"
@class TPAddressModel;
@interface TPDUpdateConstantCityAPI : TPBaseAPI


/**
 更新常跑城市

 @param arr 数组 装的是TPAddressModel
 @return object
 */
- (instancetype)initUpdateConstantCityAPIWithArr:(NSMutableArray <TPAddressModel *>*)arr;

@end
