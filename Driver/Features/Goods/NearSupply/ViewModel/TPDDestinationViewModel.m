//
//  TPDDestinationViewModel.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDDestinationViewModel.h"

#import "TPDConstantCityModel.h"

@implementation TPDestinationItemViewModel

- (instancetype)initWithModel:(TPDConstantCityModel *)model
{
    if (self = [super init]) {
        
        self.bussiness_line_id = model.business_line_id;
        self.driver_id = model.driver_id;
        self.business_line_city = model.business_line_city;
        self.business_line_city_id = model.business_line_city_id;
        
    }
    return self;
}

@end

@implementation TPDDestinationViewModel


- (instancetype)initWithModels:(NSArray <TPDConstantCityModel *> *)models target:(id)target
{
    self = [super init];
    if (self) {
        
        __block NSMutableArray * mutableArray = [[NSMutableArray alloc]init];
        [models enumerateObjectsUsingBlock:^(TPDConstantCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TPDestinationItemViewModel * viewModel = [[TPDestinationItemViewModel alloc] initWithModel:obj];
            viewModel.target = target;
            [mutableArray addObject:viewModel];
        }];
        _viewModels = [NSMutableArray arrayWithArray:mutableArray];
        
    }
    return self;
}

- (void)appendModel:(TPDestinationItemViewModel *)model target:(id)target
{
    model.target = target;
    [_viewModels addObject:model];
}

@end
