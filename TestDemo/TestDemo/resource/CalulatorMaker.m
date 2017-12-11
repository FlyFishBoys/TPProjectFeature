//
//  CalulatorMaker.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//  简单链式编程练习

#import "CalulatorMaker.h"

@implementation CalulatorMaker

-(CalulatorMaker *(^)(int))add
{
    return ^(int num) {
        _result +=num;
        return self;
    };
}

-(CalulatorMaker *(^)(int))multy
{
    return ^(int num) {
        _result *= num;
        return self;
    };
}

@end
