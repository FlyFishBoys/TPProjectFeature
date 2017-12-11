//
//  PageControllerCenterProtocol.h
//  TestDemo
//
//  Created by sunwf on 2017/11/22.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PageControllerCenterProtocol <NSObject>
/**
 从当前视图控制器跳转到目标视图控制器
 
 @param viewControllerClass 要跳转的目标视图控制器的名字
 @param currentVC 当前的视图控制器
 */
-(void)pageTurnToViewControllerClass:(NSString *)viewControllerClass fromCurrentViewController:(id)currentVC;
@end
