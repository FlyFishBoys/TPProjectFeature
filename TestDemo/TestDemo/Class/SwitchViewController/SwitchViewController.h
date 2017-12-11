//
//  SwitchViewController.h
//  TestDemo
//
//  Created by sunwf on 2017/11/22.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchViewController : UITabBarController

/**
 接收的参数
 */
@property (nonatomic,copy) NSString * loginStyle;


-(void)logLoginStyle;


@end
