//
//  TPDListenOrderSetDataSource.m
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderSetDataSource.h"

#import "TPDListenOrderSetDestinationCell.h"
#import "TPDListenOrderSetDepartCell.h"
#import "TPDListenOrderSetModel.h"

@implementation TPDListenOrderSetDataSource {
    id _target;
}

- (instancetype)initWithTarget:(id)target {
    
    self = [super init];
    if (self) {
        TPBaseTableViewSectionObject * firstTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
         TPBaseTableViewSectionObject *secondTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
         TPBaseTableViewSectionObject *thirdTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = @[firstTableViewSectionObject,secondTableViewSectionObject,thirdTableViewSectionObject].mutableCopy;
        _target = target;
    }
    return self;
    
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    
    if (![object isKindOfClass:[TPDListenOrderSetDestinationViewModel class]]) {
        return [TPDListenOrderSetDepartCell class];
    }
    else {
        return [TPDListenOrderSetDestinationCell class];
    }
    
}

//拼接出发地
- (void)appendDepartModelWithModel:(TPDListenOrderSetModel *)departModel destinationModels:(NSArray <TPDListenOrderSetModel *>*)destinationModels constantCityModels:(NSArray <TPDConstantCityModel *>*)constantCityModels optionalModel:(TPDListenOrderSetModel *)optionalModel{
    
    
    [self clearItemsAtSection:0];
    [self clearItemsAtSection:1];
    [self clearItemsAtSection:2];
    
    _viewModel = [[TPDListenOrderSetViewModel alloc]initWithDepartSetModel:departModel destinationSetModels:destinationModels.mutableCopy optionalSetModel:optionalModel constantCityModels:constantCityModels target:_target];
     [self appendItem:_viewModel.departSetViewModel atSection:0];
     [self appendItems:_viewModel.destinationSetViewModels atSection:1];
     [self appendItem:_viewModel.optionalSetViewModel atSection:2];
    
}
- (void)blindDepartModel:(TPDListenOrderSetModel *)departModel  {
     [self clearItemsAtSection:0];
     [self.viewModel blindDepartModel:departModel];
     [self appendItem:_viewModel.departSetViewModel atSection:0];

}
- (void)blindOptionalModel:(TPDListenOrderSetModel *)optionalModel {
    [self clearItemsAtSection:2];
    [self.viewModel blindOptionalModel:optionalModel];
    [self appendItem:_viewModel.optionalSetViewModel atSection:2];
}
@end
