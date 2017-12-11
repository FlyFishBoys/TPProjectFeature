//
//  TPConstantCityRouterEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPConstantCityRouterEntry.h"
#import "TPDConstantCityController.h"
@implementation TPConstantCityRouterEntry

+ (void)load {
    
    [self registerConstantCityList];
    
}
+ (void)registerConstantCityList {
    
    [MGJRouter registerURLPattern:TPRouter_ConstantCity_Controller toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDConstantCityController *vc = [[TPDConstantCityController alloc]init];
        return vc;
    }];
    
}
@end
