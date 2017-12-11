//
//  TPDConstantCityDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TPDConstantCityModel;
typedef void (^RequesConstantCitytCompleteBlock)(BOOL succeed);
typedef void (^RequestConstantCityListCompleteBlock)(BOOL succeed,id responseObjet,TPBusinessError *error);
@interface TPDConstantCityDataManager : NSObject


/**
 更新常跑城市

 @param arr 常跑城市数组
 @param completeBlock block
 */
+ (void)requestUpdateConstantCityWithConstantCityArr:(NSMutableArray *)arr  completeBlock:(RequesConstantCitytCompleteBlock)completeBlock;



/**
 获取常跑城市列表

 @param completeBlock block
 */
+ (void)requestConstantCityListAPIWithCompleteBlock:(RequestConstantCityListCompleteBlock)completeBlock;



/**
 获取个人中心常跑城市

 @param completeBlock completeBlock description
 */
+ (void)requestPersonCenterConstantCityListAPIWithCompleteBlock:(RequestConstantCityListCompleteBlock)completeBlock;



/**
 提交常跑城市的更改

 @param completeBlock completeBlock description
 */
+ (void)requestPersonCenterSubmitConstantCityAPIWithAddBusinessLineCityCodes:(NSArray <NSString *>*)addBusinessLineCityCodes updateBusinessLines:(NSArray <TPDConstantCityModel *>*)updateBusinessLines deleteBusinessLineIds:(NSArray <NSString *>*)deleteBusinessLineIds completeBlock:(RequestConstantCityListCompleteBlock)completeBlock;


@end
