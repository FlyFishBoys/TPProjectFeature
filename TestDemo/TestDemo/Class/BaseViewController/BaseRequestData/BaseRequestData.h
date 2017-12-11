//
//  BaseRequestData.h
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequstDataHandle)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error);

@interface BaseRequestData : NSObject

/**
 请求的参数
 */
@property (nonatomic,strong)  NSDictionary * _Nonnull paramDic;

/**
 接口的名字
 */
@property (nonatomic,copy)    NSString * _Nonnull destination;

/**
 接口的返回回调
 */
@property (nonatomic,copy)    RequstDataHandle _Nullable  requestDataHandle;


-(void)requestWithDestination:(NSString*_Nullable)destination paramDic:(NSDictionary*_Nonnull)paramDic finishBlock:(RequstDataHandle _Nullable )handle;


@end
