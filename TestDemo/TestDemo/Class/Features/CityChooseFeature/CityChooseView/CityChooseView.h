//
//  CityChooseView.h
//  TestDemo
//
//  Created by sunwf on 2017/12/4.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityModel.h"


typedef  void (^CityChooseHandle) (CityModel* cityModel);

@interface CityChooseView : UIView

@property (nonatomic,copy) CityChooseHandle cityChooseHandle;


-(void)show;
-(void)hiden;

@end
