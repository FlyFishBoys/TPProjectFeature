//
//  MainPageView.m
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "MainPageView.h"
#import "Masonry.h"
#import <MAMapKit/MAMapKit.h>

@implementation MainPageView

-(void)addSubViews
{
    UILabel * testLab = [[UILabel alloc]initWithFrame:CGRectMake(50, 65, 200, 20)];
    testLab.text = @"456456456456456456";
    testLab.backgroundColor = [UIColor blueColor];
    [self addSubview:testLab];
    
    [testLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@50);
        make.right.equalTo(@65);
        make.width.equalTo(@200);
        make.height.equalTo(@20);
    }];
    
    
    MAMapView * mapView = [MAMapView new];
    [self addSubview:mapView];
    
}

@end
