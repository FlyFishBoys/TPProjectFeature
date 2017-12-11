//
//  TPCallRecordsDataSource.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCallRecordsDataSource.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDCallRecordsCell.h"
#import "TPDCallRecordsListAPI.h"
#import "TPDCallRecordsViewModel.h"
#import "TPDClearCallRecordsAPI.h"
#import "TPDQueryOrderIdAPI.h"

@implementation TPDCallRecordsDataSource
{
    NSInteger page_;
    NSMutableArray *items_;
}
- (instancetype)init {
    if (self = [super init]) {
        page_ = 1;
        items_ = @[].mutableCopy;
        self.sections = [NSMutableArray array];
    }
    return self;
}

- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    
    return [TPDCallRecordsCell class];
    
}
- (TPNoResultViewType)noResultViewTypeForTableView:(UITableView *)tableView {
    return TPNoResultViewTypeCallRecordsNull;
}
- (void)fetchCallRecordsListDataWithHandler:(void(^)(BOOL success,TPBusinessError *error))handler {
    page_ = 1;
    
    TPDCallRecordsListAPI *api = [[TPDCallRecordsListAPI alloc] initWithPage:[NSString stringWithFormat:@"%ld",page_]];
    @weakify(self);
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        @strongify(self);
        if (success && error == nil) {
            [self->items_ removeAllObjects];
            [self->items_ addObjectsFromArray:responseObject];
            [self clearSections];
            if (self->items_.count > 0) {
                TPDCallRecordsListViewModel *viewModel = [TPDCallRecordsListViewModel viewModelWithItems:self->items_.copy  target:self.target];
                [self.sections addObject:viewModel];
            }
        }
        if (handler) handler(success,error);
    };
    [api start];
}
- (void)loadNextPageHandler:(void(^)(BOOL success,TPBusinessError *error))handler {
    page_++;
    TPDCallRecordsListAPI *api = [[TPDCallRecordsListAPI alloc] initWithPage:[NSString stringWithFormat:@"%ld",page_]];
    api.filterCompletionHandler = ^(BOOL success, NSArray *  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            if (responseObject.count > 0) {
                [self->items_ addObjectsFromArray:responseObject];
                [self clearSections];
                TPDCallRecordsListViewModel *viewModel = [TPDCallRecordsListViewModel viewModelWithItems:self->items_.copy target:self.target];
                [self.sections addObject:viewModel];
            } else {
                page_--;
            }
            if (handler) handler(YES,nil);
        } else {
            page_--;
            if (handler) handler(NO,error);
        }
    };
    [api start];
}
- (void)clearAllCallRecordsWithHandler:(void(^)(BOOL success,TPBusinessError *error))handler {
    TPDClearCallRecordsAPI *api = [[TPDClearCallRecordsAPI alloc] init];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            [self clearSections];
            [items_ removeAllObjects];
            page_ = 1;
            if (handler) handler(YES,nil);
        } else {
            if (handler) handler(NO,error);
        }
    };
    [api start];
}
- (void)fetchGoodsStatusWithGoodsId:(NSString *)goodsId Handler:(void(^)(BOOL shouldOperation))handler {
    TPDQueryOrderIdAPI * api = [[TPDQueryOrderIdAPI alloc] initWithGoodsId:goodsId];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (error == nil && success) {
            if (handler) {
                NSString * orderId = responseObject[@"order_id"];
                handler(orderId.isNotBlank ? NO : YES);
            }
        } else {
            if (handler) {
                handler(NO);
            }
        }
    };
    [api start];
}
@end
