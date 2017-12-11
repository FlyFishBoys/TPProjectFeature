//
//  CommonUnitCenter.h
//  TestDemo
//
//  Created by sunwf on 2017/11/27.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonUnitCenterProtocol.h"

@interface CommonUnitCenter : NSObject


/**
 常用工具类单例

 @return CommonUnitCenter
 */
+(id)shareCommon;


@end
