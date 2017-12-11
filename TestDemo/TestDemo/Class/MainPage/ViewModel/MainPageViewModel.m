//
//  MainPageViewModel.m
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "MainPageViewModel.h"

@implementation MainPageViewModel

#pragma mark- Override
-(void)loadView
{
    if (!_mainPageView) {
        _mainPageView = [[MainPageView alloc]init];
        self.currentView = _mainPageView;
    }
}


#pragma mark- Public



#pragma mark- Delegate


#pragma mark- Events

@end
