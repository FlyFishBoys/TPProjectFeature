//
//  BaseView.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseView.h"
#import "Masonry.h"

@implementation BaseView

-(instancetype)init
{
    self = [super init];
    if (self) {
        
        [self addSubViews];
    }
    return self;
}

-(void)addSubViews
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}
@end
