//
//  CityViewModel.m
//  TestDemo
//
//  Created by sunwf on 2017/12/4.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "CityViewModel.h"

@implementation CityViewModel

#pragma mark- Public

-(void)loadView
{
    
}

-(void)citySelectFinishHandle:(CityChooseBind)handle
{
    self.cityView.cityChooseHandle = ^(CityModel *cityModel) {
        
        if (handle) {
            handle(cityModel);
        }
    };
    [self.cityView show];
}


#pragma mark- Private



#pragma mark- Delegate


#pragma mark- Getter
-(CityChooseView *)cityView
{
    if (_cityView ==nil) {
        _cityView = [[CityChooseView alloc]init];
    }
    
    return _cityView;
}





@end
