//
//  TPDFreightAgentDataSource.m
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreightAgentDataSource.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDFreightAgentCell.h"
#import "TPDFreightAgrentViewModel.h"
#import "TPDFreightAgrentModel.h"
@implementation TPDFreightAgentDataSource {
    id _target;
}

- (instancetype)init {
    if (self = [super init]) {
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    return self;
}

- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
       
        _target = target;
    }
    return self;
    
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    
    return [TPDFreightAgentCell class];
    
}
//加载数据数据
- (void)reloadItemsWithResponseObject:(NSArray *)responseObject {
    NSArray *models;
    if ([responseObject.firstObject isKindOfClass:[NSDictionary class]]) {
        models = [NSArray yy_modelArrayWithClass:[TPDFreightAgrentModel class] json:responseObject];
    } else {
        models = responseObject;
    }
    
    [self clearSections];
    [self clearAllItems];
    TPDFreightAgrentViewModel *viewModel = [[TPDFreightAgrentViewModel alloc] initWithFreightAgrentModels:models target:_target];
    [self appendItems:viewModel.viewModels];
    
}

//加载更多数据

- (void)appendItemsWithResponseObject:(NSArray *)responseObject {
    NSArray *models;
    if ([responseObject.firstObject isKindOfClass:[NSDictionary class]]) {
        models = [NSArray yy_modelArrayWithClass:[TPDFreightAgrentModel class] json:responseObject];
    } else {
        models = responseObject;
    }
    

    TPDFreightAgrentViewModel *viewModel = [[TPDFreightAgrentViewModel alloc] initWithFreightAgrentModels:models target:_target];
    [self appendItems:viewModel.viewModels];
    
    
}

@end
