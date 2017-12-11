//
//  TPDAuthenticationViewController.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//


/**
 路由跳转参数：isRegistered 1：代表从注册进来的 0：代表不是从注册进来的
 **/

#import <UIKit/UIKit.h>

@interface TPDAuthenticationViewController : UIViewController
/**
 是否是注册
 */
@property (nonatomic, assign) BOOL isRegistered;
@end
