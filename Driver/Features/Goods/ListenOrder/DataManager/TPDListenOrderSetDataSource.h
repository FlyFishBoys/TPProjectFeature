//
//  TPDListenOrderSetDataSource.h
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDListenOrderSetViewModel.h"
@class TPDListenOrderSetModel,TPDConstantCityModel;
@interface TPDListenOrderSetDataSource : TPBaseTableViewDataSource

@property (nonatomic , strong) TPDListenOrderSetViewModel *viewModel;

- (instancetype)initWithTarget:(id)target;

- (void)appendDepartModelWithModel:(TPDListenOrderSetModel *)departModel destinationModels:(NSArray <TPDListenOrderSetModel *>*)destinationModels constantCityModels:(NSArray <TPDConstantCityModel *>*)constantCityModels optionalModel:(TPDListenOrderSetModel *)optionalModel;

- (void)blindDepartModel:(TPDListenOrderSetModel *)departModel;

- (void)blindOptionalModel:(TPDListenOrderSetModel *)optionalModel;

@end
