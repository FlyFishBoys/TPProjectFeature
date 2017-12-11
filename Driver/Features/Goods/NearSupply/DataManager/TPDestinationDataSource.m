//
//  TPDestinationDataSource.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDestinationDataSource.h"

#import "TPBaseTableViewSectionObject.h"

#import "TPDDestinationCell.h"

@implementation TPDestinationDataSource

- (instancetype)init {
    if (self = [super init]) {
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    
    return [TPDDestinationCell class];
    
}


@end
