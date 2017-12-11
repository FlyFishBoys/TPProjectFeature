//
//  LoginPageTurn.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginPageTurn.h"

@implementation LoginPageTurn

-(void)turnToLoginPage:(UIViewController*)vc
{
    [[[UIApplication sharedApplication]keyWindow]setRootViewController:vc];
}

@end
