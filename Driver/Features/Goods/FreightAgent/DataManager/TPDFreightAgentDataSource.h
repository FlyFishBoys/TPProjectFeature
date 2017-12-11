//
//  TPDFreightAgentDataSource.h
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"

@interface TPDFreightAgentDataSource : TPBaseTableViewDataSource

- (instancetype)initWithTarget:(id)target;

- (void)reloadItemsWithResponseObject:(NSArray *)responseObject;

- (void)appendItemsWithResponseObject:(NSArray *)responseObject;

@end
