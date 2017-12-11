//
//  TPDSubscribeRouteDataSource.m
//  TopjetPicking
//
//  Created by lish on 2017/8/29.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteDataSource.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDSubscribeRouteCell.h"
@implementation TPDSubscribeRouteDataSource
- (instancetype)init {
    if (self = [super init]) {
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    return [TPDSubscribeRouteCell class];
}

- (TPNoResultViewType)noResultViewTypeForTableView:(UITableView *)tableView {
    return TPNoResultViewTypeSubscribeRouteNull;
}
@end
