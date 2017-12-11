//
//  ViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/15.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "ViewController.h"
#import "CalulatorMaker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CalulatorMaker * maker = [[CalulatorMaker alloc]init];
    maker.add(1).multy(5);
    NSLog(@"maker.result====>%d",maker.result);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
