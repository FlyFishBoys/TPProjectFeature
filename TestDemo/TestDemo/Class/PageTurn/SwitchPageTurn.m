//
//  SwitchPageTurn.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "SwitchPageTurn.h"
#import "LoginViewController.h"

@implementation SwitchPageTurn

-(UIViewController*)turnToSwitchPageFromVC:(UIViewController *)fromVC
{
    SwitchViewController * switchVC = [[SwitchViewController alloc]init];
    
    if ([fromVC isKindOfClass:[LoginViewController class]]) {
        LoginViewController * loginVC = (LoginViewController*)fromVC;
        switchVC.view.backgroundColor = [UIColor redColor];
        switchVC.loginStyle = @"密码登录！！！";
        [switchVC logLoginStyle];
    }
    return switchVC;
}

@end
