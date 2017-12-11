//
//  TPDListenOrderSetViewModel.m
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderSetViewModel.h"
@implementation TPDListenOrderSetDepartViewModel

- (instancetype)initWithSetModelWithModel:(TPDListenOrderSetModel *)model target:(id)target {
    self = [super init];
    if (self) {
        
        self.cityName = model.city_name;
        self.model = model;
        self.model.type = @"1";
        self.target = target;
 
    }
    return self;
}
@end

@implementation TPDListenOrderSetDestinationViewModel


- (instancetype)initWithSetModelWithModel:(TPDListenOrderSetModel *)model isSelect:(BOOL)isSelect target:(id)target {
    self = [super init];
    if (self) {
        
        self.cityName = model.city_name;
        self.model = model;
        self.target = target;
        self.isSelectCity = isSelect;
    }
    return self;
}
@end
@implementation TPDListenOrderSetViewModel {
    id _target;
}
- (instancetype)initWithDepartSetModel:(TPDListenOrderSetModel *)departSetModel destinationSetModels:(NSMutableArray<TPDListenOrderSetModel *> *)destinationSetModels optionalSetModel:(TPDListenOrderSetModel *)optionalSetModel constantCityModels:(NSArray<TPDConstantCityModel *>*)constantCityModels target:(id)target {
    
    self = [super init];
    if (self) {
        _target = target;
        _destinationSetViewModels = [NSMutableArray array];
        [self handleDestinationSetViewModelsWithConstantCityModels:constantCityModels destinationSetModels:destinationSetModels];
        
        self.departSetViewModel = [[TPDListenOrderSetDepartViewModel alloc]initWithSetModelWithModel:departSetModel target:target];
        self.optionalSetViewModel = [[TPDListenOrderSetDestinationViewModel alloc]initWithSetModelWithModel:optionalSetModel isSelect:[optionalSetModel.city_name containsString:@"手动选择城市"]?NO:YES target:target];
    }
    return self;
}

- (void)handleDestinationSetViewModelsWithConstantCityModels:(NSArray<TPDConstantCityModel *>*)constantCityModels destinationSetModels:(NSMutableArray<TPDListenOrderSetModel *> *)destinationSetModels {
    

    //1.没有目的地城市
    if (destinationSetModels.count == 0|| !destinationSetModels) {
       //常跑城市作为所有的目的地城市
        [constantCityModels enumerateObjectsUsingBlock:^(TPDConstantCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            TPDListenOrderSetModel *setModel = [[TPDListenOrderSetModel alloc]init];
            setModel.city_name = obj.business_line_city;
            setModel.city_id = obj.business_line_city_id;
            setModel.type = @"2";
           
            TPDListenOrderSetDestinationViewModel *viewModel = [[TPDListenOrderSetDestinationViewModel alloc]initWithSetModelWithModel:setModel isSelect:YES target:_target];
            [self.destinationSetViewModels addObject:viewModel];
            
        }];
        return;
    }
    
    //2. 有目的地 有常跑城市 进行筛选
    //设置目的地选项为选中的状态
    [destinationSetModels enumerateObjectsUsingBlock:^(TPDListenOrderSetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.city_name isNotBlank]&& [obj.city_id isNotBlank]) {
            TPDListenOrderSetDestinationViewModel *viewModel = [[TPDListenOrderSetDestinationViewModel alloc]initWithSetModelWithModel:obj isSelect:YES target:_target];
            [self.destinationSetViewModels addObject:viewModel];
        }
    }];
    
    //转换常跑城市模型
    NSMutableArray <TPDListenOrderSetModel *>*constantCitySetModelArr = [NSMutableArray array];
    [constantCityModels enumerateObjectsUsingBlock:^(TPDConstantCityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TPDListenOrderSetModel *setModel = [[TPDListenOrderSetModel alloc]init];
        setModel.city_name = obj.business_line_city;
        setModel.city_id = obj.business_line_city_id;
        setModel.type = @"2";
        [constantCitySetModelArr addObject:setModel];
    }];

    
    __block NSMutableArray *difObject = [NSMutableArray array];
    //找到常跑城市数组中,目的地数组没有的数据
    [constantCitySetModelArr enumerateObjectsUsingBlock:^(TPDListenOrderSetModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *cityId = obj.city_id;
        __block BOOL isHave = NO;
        [destinationSetModels enumerateObjectsUsingBlock:^(TPDListenOrderSetModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([cityId isEqual:obj.city_id]) {
                isHave = YES;
                *stop = YES;
            }
        }];
        if (!isHave) {
            [difObject addObject:obj];
        }
    }];
    //设置目的地选项为不选中的状态
    [difObject enumerateObjectsUsingBlock:^(TPDListenOrderSetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.city_name isNotBlank] && [obj.city_id isNotBlank]) {
            TPDListenOrderSetDestinationViewModel *viewModel = [[TPDListenOrderSetDestinationViewModel alloc]initWithSetModelWithModel:obj isSelect:NO target:_target];
            [self.destinationSetViewModels addObject:viewModel];
        }
    }];

}
- (void)blindDepartModel:(TPDListenOrderSetModel *)departModel  {
    
    self.departSetViewModel = [[TPDListenOrderSetDepartViewModel alloc]initWithSetModelWithModel:departModel target:_target];
}
- (void)blindOptionalModel:(TPDListenOrderSetModel *)optionalModel {
    self.optionalSetViewModel = [[TPDListenOrderSetDestinationViewModel alloc]initWithSetModelWithModel:optionalModel isSelect:[optionalModel.city_name isEqualToString:@"手动选择城市"]?NO:YES  target:_target];
}
@end
