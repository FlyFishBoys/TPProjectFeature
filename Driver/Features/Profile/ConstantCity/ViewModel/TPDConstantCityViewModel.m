//
//  TPDConstantCityViewModel.m
//  TopjetPicking
//
//  Created by lish on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDConstantCityViewModel.h"
#import "TPCityAdressService.h"
#import "TPLocationServices.h"
@implementation TPDConstantCityItemViewModel

- (void)blindConstantCityViewModel:(TPDConstantCityModel *)model {
    
    _addressModel = [[TPAddressModel alloc]init];
    _constantCityModel = model;
    @weakify(self);
    [TPCityAdressService getCityNameWithCityId:_constantCityModel.business_line_city_id completeBlock:^(BOOL success, TPAddressModel *currentCityModel) {
        @strongify(self);
        self.cityName = currentCityModel.formatted_area;
        self.addressModel.formatted_area = currentCityModel.formatted_area;
        self.addressModel.adcode = _constantCityModel.business_line_city_id;
    }];
    
    
}

@end
@implementation TPDConstantCityViewModel
- (instancetype)init {
    
    self = [super init];
    if (self) {
        _constantCitysArr = [NSMutableArray array];
        _addBusinessLineCityCodesArr = [NSMutableArray array];
        _updateBusinessLinesArr = [NSMutableArray array];
        _deleteBusinessLineIdsArr = [NSMutableArray array];
    }
    return self;
    
}

- (void)blindConstantCityViewModel:(NSArray <TPDConstantCityModel *>*)list {
    
    [list enumerateObjectsUsingBlock:^(TPDConstantCityModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TPDConstantCityItemViewModel *item = [[TPDConstantCityItemViewModel alloc]init];
        [item blindConstantCityViewModel:obj];
        [_constantCitysArr addObject:item];
    }];

}
- (void)addAdressModel:(TPAddressModel *)addressModel {
    
    TPDConstantCityModel *model = [[TPDConstantCityModel alloc]init];
    model.business_line_city_id = addressModel.adcode;
    TPDConstantCityItemViewModel *viewModel = [[TPDConstantCityItemViewModel alloc]init];
    [viewModel blindConstantCityViewModel:model];
    [_constantCitysArr addObject:viewModel];
    //添加提交用的cityCode
    [_addBusinessLineCityCodesArr addObject:addressModel.adcode];
    
}

- (void)deleteConstantCity:(NSInteger)index {

   
    TPDConstantCityItemViewModel *obj = self.constantCitysArr[index];
    if ([obj.constantCityModel.business_line_id isNotBlank]) {
        //不空说明是之前提交
        [_deleteBusinessLineIdsArr addObject:obj.constantCityModel.business_line_city_id];
        
    }else{
        //应该删添加的
           [self.constantCitysArr enumerateObjectsUsingBlock:^(TPDConstantCityItemViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              
               if (![obj.constantCityModel.business_line_id isNotBlank] && idx == index) {
                  [_addBusinessLineCityCodesArr removeObject:obj.addressModel.adcode];
               }
           }];
    }
    
    [self.constantCitysArr removeObjectAtIndex:index];
    
}

- (void)updateConstantCity:(TPAddressModel *)addressModel index:(NSInteger)index {
    

    TPDConstantCityItemViewModel *vieModel = self.constantCitysArr[index];
    
    if ([vieModel.constantCityModel.business_line_id isNotBlank]) {
        
        //说明是之前的
        TPDConstantCityModel *model = [[TPDConstantCityModel alloc]init];
        model.business_line_city_id = addressModel.adcode;
        model.business_line_id = vieModel.constantCityModel.business_line_id;
        TPDConstantCityItemViewModel *viewModel = [[TPDConstantCityItemViewModel alloc]init];
        [viewModel blindConstantCityViewModel:model];
        [_constantCitysArr replaceObjectAtIndex:index withObject:viewModel];
        [_updateBusinessLinesArr addObject:model];
    }
    else{
        TPDConstantCityItemViewModel *oldViewModel =_constantCitysArr[index];
        NSString *oldCityId = oldViewModel.constantCityModel.business_line_city_id ;
        [_addBusinessLineCityCodesArr removeObject:oldCityId];
        if ([addressModel.adcode isNotBlank]) {
          [_addBusinessLineCityCodesArr addObject:addressModel.adcode];
        }
        //说明是添加
        TPDConstantCityModel *model = [[TPDConstantCityModel alloc]init];
        model.business_line_city_id = addressModel.adcode;
        TPDConstantCityItemViewModel *viewModel = [[TPDConstantCityItemViewModel alloc]init];
        [viewModel blindConstantCityViewModel:model];
        [_constantCitysArr replaceObjectAtIndex:index withObject:viewModel];
        
    }
    
    
}
@end
