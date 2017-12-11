//
//  CommonUnitCenterProtocol.h
//  TestDemo
//
//  Created by sunwf on 2017/11/27.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommonUnitCenterProtocol <NSObject>

#pragma mark- ProgressHUD
//显示提示信息成功或失败
-(void)showSuccessMessageWithContent:(NSString *)message;
-(void)showFailMessageWithContent:(NSString*)message;

/**
 显示提示信息成功或失败
 
 @param message 显示的文本
 @param enable 是否可操作界面，默认不可以
 */
-(void)showSuccessMessageWithContent:(NSString *)message  enable:(BOOL)enable;
-(void)showFailMessageWithContent:(NSString*)message enable:(BOOL)enable;

//显示网络请求进度
-(void)showNetWorkProgressHUDforView:(UIView*)view;
-(void)showNetWorkProgressHUD;
//隐藏网络请求进度
-(void)hidenNetWorkProgressHUDforView:(UIView*)view;
-(void)hidenNetWorkProgressHUD;

#pragma mark-  MyTool

//城市选择
-(void)chooseCityFinishHandle:(void(^)(id cityViewModel))handle;

@end
