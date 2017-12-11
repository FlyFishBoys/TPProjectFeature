//
//  CityChooseView.m
//  TestDemo
//
//  Created by sunwf on 2017/12/4.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "CityChooseView.h"

@implementation CityChooseView


#pragma mark- Public

-(void)show
{
    UIButton * chooseButt = [UIButton buttonWithType:UIButtonTypeCustom];
    chooseButt.backgroundColor = [UIColor whiteColor];
    [chooseButt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    chooseButt.frame = CGRectMake(100, 100, 100, 100);
    [chooseButt addTarget:self action:@selector(cityChooseAction:) forControlEvents:UIControlEventTouchUpInside];
    [chooseButt setTitle:@"选择城市" forState:UIControlStateNormal];
    
    self.frame = [[UIScreen mainScreen]bounds];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.65];
    [self addSubview:chooseButt];
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:self];
    self.hidden = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
       
        self.hidden = NO;
    }];
    
    
}

-(void)hiden
{
    if (self.superview) {
        
        [UIView animateWithDuration:0.25 animations:^{
           
            self.hidden = YES;
            [self removeFromSuperview];
        }];
        
    }
}

#pragma mark- Events
-(void)cityChooseAction:(UIButton*)sender
{
    if (self.cityChooseHandle) {
        CityModel * model = [[CityModel alloc]init];
        model.cityName = @"上海 徐汇区";
        model.cityCode = @"10020";
        self.cityChooseHandle(model);
    }
    
    [self hiden];
}



@end
