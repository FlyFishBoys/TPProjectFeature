//
//  CommonUnitCenter.m
//  TestDemo
//
//  Created by sunwf on 2017/11/27.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "CommonUnitCenter.h"
#import "MBProgressHUD.h"
#import "ProgressHUD.h"

@implementation CommonUnitCenter

+(id)shareCommon
{
    static CommonUnitCenter * commonUnitCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        commonUnitCenter = [[CommonUnitCenter alloc]init];
        
    });
    
    return commonUnitCenter;
}



@end
