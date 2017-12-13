//
//  MainPageViewModel.h
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainPageView;
@class BaseViewModel;

@interface MainPageViewModel  : NSObject

@property (nonatomic,strong) MainPageView * mainPageView;
@property (nonatomic,strong) BaseViewModel * mainPageViewModel;


@end
