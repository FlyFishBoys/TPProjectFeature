//
//  PageControllerCenter.h
//  TestDemo
//
//  Created by sunwf on 2017/11/22.
//  Copyright © 2017年 sunwf. All rights reserved.
//  界面跳转中心

#import <Foundation/Foundation.h>
#import "PageControllerCenterProtocol.h"

@interface PageControllerCenter : NSObject<PageControllerCenterProtocol>


/**
 界面跳转中心单例

 @return PageControllerCenter
 */
+(id)shareInstance;


@end
