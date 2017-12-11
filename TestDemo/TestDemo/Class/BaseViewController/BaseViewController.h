//
//  BaseViewController.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageControllerCenterProtocol.h"
#import "CustomNavgationBar.h"

/* 导航条样式 分两种，解决不同界面的导航条设置后互相影响 */
typedef NS_ENUM(NSInteger,UIBaseViewControllerNavgationBarStyle) {
    UIBaseViewControllerNavgationBarStyle_Default,//标准样式 self.navgationBar， 不可以更改导航条颜色样式等
    UIBaseViewControllerNavgationBarStyle_Custom//自定义样式 self.customNavgationBar， 可以设置导航条颜色，背景等
};

@interface BaseViewController : UIViewController <PageControllerCenterProtocol>

/* 导航条item  */
@property (nonatomic,strong) UIView * backItem; //有默认样式
@property (nonatomic,strong) UIView * rightItem; //默认无

@property (nonatomic,strong) CustomNavgationBar * my_NavgationBar;//自定义导航条
@property (nonatomic,strong) UINavigationItem * my_NavgationItem;//自定义导航条按钮

/**
 导航条样式   子类如果需要自定义样式，需要重写 navgationBarStyle的getter方法
 */
@property (nonatomic,assign) UIBaseViewControllerNavgationBarStyle  navgationBarStyle;
@property (nonatomic,assign) BOOL  navgationBarHiden;//导航条是否隐藏

//绑定viewModel 业务
-(void)viewModelBind;
//加载子视图
-(void)subViewLoad;

@end
