//
//  CommonUnitCenter+ShowProgressHUD.m
//  TestDemo
//
//  Created by sunwf on 2017/12/4.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "CommonUnitCenter+ShowProgressHUD.h"

@implementation CommonUnitCenter (ShowProgressHUD)

-(void)showSuccessMessageWithContent:(NSString *)message
{
    [ProgressHUD showSuccess:message Interaction:NO];
}

-(void)showFailMessageWithContent:(NSString *)message
{
    [ProgressHUD showError:message Interaction:NO];
}

-(void)showSuccessMessageWithContent:(NSString *)message enable:(BOOL)enable
{
    [ProgressHUD showSuccess:message Interaction:enable];
}

-(void)showFailMessageWithContent:(NSString *)message enable:(BOOL)enable
{
    [ProgressHUD showError:message Interaction:enable];
}


-(void)showNetWorkProgressHUDforView:(UIView *)view
{
    [MBProgressHUD showHUDAddedTo:view  animated:YES];
}

-(void)hidenNetWorkProgressHUDforView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:NO];
}


@end



