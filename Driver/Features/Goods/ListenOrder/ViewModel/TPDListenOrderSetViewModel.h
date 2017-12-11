//
//  TPDListenOrderSetViewModel.h
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPBaseTableViewItem.h"
#import "TPDListenOrderSetModel.h"
#import "TPDConstantCityModel.h"
//出发地
@interface TPDListenOrderSetDepartViewModel : TPBaseTableViewItem

@property (nonatomic , copy) NSString *cityName;

@property (nonatomic , strong) TPDListenOrderSetModel *model;

@end

//目的地
@interface TPDListenOrderSetDestinationViewModel : TPBaseTableViewItem

@property (nonatomic , assign) BOOL isSelectCity;//是否选择该城市

@property (nonatomic , copy) NSString *cityName;

@property (nonatomic , strong) TPDListenOrderSetModel *model;

@end


@interface TPDListenOrderSetViewModel : TPBaseTableViewItem

@property (nonatomic , strong) TPDListenOrderSetDestinationViewModel *optionalSetViewModel;//自选城市

@property (nonatomic , strong) TPDListenOrderSetDepartViewModel *departSetViewModel;//出发地

@property (nonatomic , strong) NSMutableArray <TPDListenOrderSetDestinationViewModel *> *destinationSetViewModels;//目的地

- (instancetype)initWithDepartSetModel:(TPDListenOrderSetModel *)departSetModel destinationSetModels:(NSMutableArray<TPDListenOrderSetModel *> *)destinationSetModels optionalSetModel:(TPDListenOrderSetModel *)optionalSetModel constantCityModels:(NSArray<TPDConstantCityModel *>*)constantCityModels target:(id)target;

- (void)blindDepartModel:(TPDListenOrderSetModel *)departModel;

- (void)blindOptionalModel:(TPDListenOrderSetModel *)optionalModel;
@end

