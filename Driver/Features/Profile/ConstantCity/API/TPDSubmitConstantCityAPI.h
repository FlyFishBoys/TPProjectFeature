//
//  TPDModifyConstantCityAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"
@class TPDConstantCityModel;
@interface TPDSubmitConstantCityAPI : TPBaseAPI


/**
 常跑路线-提交

 @param addBusinessLineCityCodes 添加常跑城市code集合
 @param updateBusinessLines 修改常跑城市集合
 @param deleteBusinessLineIds 删除常跑城市id集合
 @return return value description
 */
- (instancetype)initWithAddBusinessLineCityCodes:(NSArray <NSString *>*)addBusinessLineCityCodes updateBusinessLines:(NSArray <TPDConstantCityModel *>*)updateBusinessLines deleteBusinessLineIds:(NSArray <NSString *>*)deleteBusinessLineIds;

@end
