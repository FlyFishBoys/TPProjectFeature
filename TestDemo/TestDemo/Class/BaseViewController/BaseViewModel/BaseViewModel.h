//
//  BaseViewModel.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NetWorkManagerCenterProtocol.h"
#import "CommonUnitCenterProtocol.h"
#import "BusinessConstants.h"

@interface BaseViewModel : NSObject<NetWorkManagerCenterProtocol,CommonUnitCenterProtocol>

@property (nonatomic,strong) UIView * currentView;//被绑定的viewController的界面


//加载view
-(void)loadView;

/**
 获取当前model 的所在Group路径

 @param path  __file__ 当前代码执行文件所在路径
 @return Group路径
 */
-(NSString*)currentGroupFilePathWithMFilePath:(char[])path;

@end
