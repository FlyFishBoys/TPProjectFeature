//
//  CalulatorMaker.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//  简单链式编程练习

#import <Foundation/Foundation.h>
#define   ADD
#define   MULTY

@interface CalulatorMaker : NSObject

@property (nonatomic,assign) int result;

-(CalulatorMaker*(^) (int num))add;
-(CalulatorMaker*(^) (int num))multy;

@end
