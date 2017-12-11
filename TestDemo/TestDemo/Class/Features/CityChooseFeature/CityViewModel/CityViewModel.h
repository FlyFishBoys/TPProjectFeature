//
//  CityViewModel.h
//  TestDemo
//
//  Created by sunwf on 2017/12/4.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewModel.h"
#import "CityChooseView.h"

typedef void(^CityChooseBind)(CityModel* cityModel);

@interface CityViewModel : BaseViewModel


@property (nonatomic,strong) CityChooseView * cityView;

-(void)citySelectFinishHandle:(CityChooseBind)handle;

@end
