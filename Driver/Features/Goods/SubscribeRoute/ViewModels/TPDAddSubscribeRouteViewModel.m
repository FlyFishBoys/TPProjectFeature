//
//  TPDAddSubscribeRouteViewModel.m
//  TopjetPicking
//
//  Created by lish on 2017/9/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddSubscribeRouteViewModel.h"
@interface TPDAddSubscribeRouteViewModel()
@property (nonatomic , strong) TPAddressModel *departModel;//出发地model

@property (nonatomic , strong) TPAddressModel *destintionModel;//目的地model

@property (nonatomic , strong)  TrucktypeModel *truckTypeModel;//车型model

@property (nonatomic , strong)  TrucklengthModel *truckLengthModel;//车长model

@end

@implementation TPDAddSubscribeRouteViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        
        _departModel = [[TPAddressModel alloc]init];
        _destintionModel = [[TPAddressModel alloc]init];
        _truckTypeModel = [[TrucktypeModel alloc]init];
        _truckLengthModel = [[TrucklengthModel alloc]init];
    }
    return self;
}
- (void)blindDepartModel:(TPAddressModel *)departModel {
     _departModel = departModel;
     self.departCityCode = _departModel.adcode;
     self.departAddress = [self.departModel.formatted_area stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
}

- (void)blindDestintionModel:(TPAddressModel *)destintionModel {
     _destintionModel =  destintionModel;
    self.destintionCityCode = _destintionModel.adcode;
    self.destintionAddress = _destintionModel.formatted_area;
}

- (void)blindTruckTypeModel:(TrucktypeModel *)truckTypeModel {
    
    _truckTypeModel = truckTypeModel;
    self.truckTypeId = _truckTypeModel.typeId;
}

- (void)blindTruckLengthModel:(TrucklengthModel *)truckLengthModel {
    _truckLengthModel = truckLengthModel;
    self.truckLengthId = _truckLengthModel.lengthId;
    self.truckLengthType = [[[self.truckLengthModel.displayName stringByAppendingString:@"  "] stringByAppendingString:self.truckTypeModel.displayName] isNotBlank]?[[self.truckLengthModel.displayName stringByAppendingString:@"  "] stringByAppendingString:self.truckTypeModel.displayName]:@"不限";
}

@end
