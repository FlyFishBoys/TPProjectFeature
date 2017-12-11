//
//  NetWorkManagerCenter.h
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//  网络请求中心

#import <Foundation/Foundation.h>
#import "NetWorkManagerCenterProtocol.h"

@interface NetWorkManagerCenter : NSObject <NetWorkManagerCenterProtocol>

/**
 管理所有界面的接口调用

 @return NetWorkManagerCenter
 */
+(id)shareInstance;



@end
