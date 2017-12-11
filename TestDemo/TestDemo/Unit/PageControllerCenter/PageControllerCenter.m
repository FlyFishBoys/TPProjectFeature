//
//  PageControllerCenter.m
//  TestDemo
//
//  Created by sunwf on 2017/11/22.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "PageControllerCenter.h"
#import <objc/runtime.h>
#import "SwitchPageTurn.h"
#import "MainPageTurn.h"

@implementation PageControllerCenter

+(id)shareInstance
{
    static PageControllerCenter * pageControllerCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pageControllerCenter = [[PageControllerCenter alloc]init];

    });
    return pageControllerCenter;
}

-(void)pageTurnToViewControllerClass:(NSString *)viewControllerClass fromCurrentViewController:(id)currentVC
{
    UIViewController * currentViewController = currentVC;

    UIViewController * toViewController = [self getParamWithOrignViewControllerWithClass:viewControllerClass fromController:currentVC];
    
    if (toViewController) {

        if (!currentViewController.navigationController) {
            [currentViewController presentViewController:toViewController animated:YES completion:nil];
        }else
        {
            [currentViewController.navigationController pushViewController:toViewController animated:YES];

        }
        
    }
}

-(UIViewController*)getParamWithOrignViewControllerWithClass:(NSString*)viewControllerClass fromController:(id)fromController
{
    
    if ([viewControllerClass isEqualToString:NSStringFromClass([SwitchViewController class])]) {
#pragma mark-  SwitchViewController
        return [[[SwitchPageTurn alloc]init] turnToSwitchPageFromVC:fromController];
    }
    else if ([viewControllerClass isEqualToString:NSStringFromClass([UIViewController class])])
    {
#pragma mark-  UIViewController
        UIViewController * viewController = [[UIViewController alloc]init];
        viewController.view.backgroundColor = [UIColor brownColor];
        return viewController;
    
    }
    else if ([viewControllerClass isEqualToString:NSStringFromClass([MainPageViewController class])])
    {
#pragma mark-  MainPageViewController
        return [[[MainPageTurn alloc]init]turnToMainPageFromVC:fromController];
        
    }

    return nil;
}



-(UIViewController*)getOrignViewControllerWithClass:(NSString*)viewControllerClass withParamDic:(NSDictionary*)paramDic
{
    if ([viewControllerClass isEqualToString:NSStringFromClass([SwitchViewController class])]) {
        
   
    }else if ([viewControllerClass isEqualToString:NSStringFromClass([UIViewController class])])
    {
      
        
    }
    else
    {
       //待扩展运行时获取视图控制器
        
    }
    
    return nil;
}


@end
