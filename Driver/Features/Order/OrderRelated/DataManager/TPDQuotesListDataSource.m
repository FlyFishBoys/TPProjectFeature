//
//  TPDQuotesListDataSource.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDQuotesListDataSource.h"
#import "TPDQuotesListCell.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPLocationServices.h"
#import "TPDQuotesListAPI.h"
#import "TPDQuotesListModel.h"
#import "TPDRevokedQuotesAPI.h"
#import "TPDQuotesListViewModel.h"

@interface TPDQuotesListDataSource ()
{
    NSInteger _page;
}
@property (nonatomic,weak) id target;

@end

@implementation TPDQuotesListDataSource
- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        self.target = target;
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    return self;
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    return [TPDQuotesListCell class];
}

- (TPNoResultViewType)noResultViewTypeForTableView:(UITableView *)tableView {
    return TPNoResultViewTypeQuoteListNull;
}

- (NSInteger)count {
    TPBaseTableViewSectionObject *firstSectionObject = [self.sections firstObject];
    return firstSectionObject.items.count;
}

- (void)refreshQuotesListWithCompleteBlock:(RequestCompleteBlock)completeBlock {
    _page = 1;
    TPLocationServices * locationServices = [TPLocationServices locationService];
    [locationServices requestSingleLocationWithReGeocode:NO completionHandler:^(TPAddressModel *addressModel, NSError *error) {
        TPDQuotesListAPI * quotesListAPI = [[TPDQuotesListAPI alloc]initWithPage:_page longitude:addressModel.longitude latitude:addressModel.latitude];
        quotesListAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
            if (error == nil && success) {
                if (completeBlock) {
                    NSArray * orderLists = [NSArray yy_modelArrayWithClass:[TPDQuotesListModel class] json:responseObject[@"list"]];
                    TPDQuotesListViewModel * viewModel = [[TPDQuotesListViewModel alloc]initWithModels:orderLists target:self.target];
                    [self clearAllItems];
                    [self appendItems:viewModel.viewModels];
                    completeBlock(YES,nil);
                }
            } else {
                if (completeBlock) {
                    completeBlock(NO,error);
                }
            }
        };
        [quotesListAPI start];
    }];
    
}

- (void)loadMoreQuotesListWithCompleteBlock:(RequestListCompleteBlock)completeBlock {
    _page ++;
    TPLocationServices * locationServices = [TPLocationServices locationService];
    [locationServices requestSingleLocationWithReGeocode:NO completionHandler:^(TPAddressModel *addressModel, NSError *error) {
        
        TPDQuotesListAPI * quotesListAPI = [[TPDQuotesListAPI alloc]initWithPage:_page longitude:addressModel.longitude latitude:addressModel.latitude];
        quotesListAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
            if (error == nil && success) {
                if (completeBlock) {
                    NSArray * orderLists = [NSArray yy_modelArrayWithClass:[TPDQuotesListModel class] json:responseObject[@"list"]];
                    if (orderLists.count) {
                        TPDQuotesListViewModel * viewModel = [[TPDQuotesListViewModel alloc]initWithModels:orderLists target:self.target];
                        [self appendItems:viewModel.viewModels];
                    }
                    completeBlock(YES,nil,orderLists.count);
                }
            } else {
                _page --;
                if (completeBlock) {
                    completeBlock(NO,error,0);
                }
            }
        };
        
        [quotesListAPI start];
    }];
}

- (void)revokedQuotesWithQuotesIds:(NSArray<NSString *> *)quotesIds completeBlock:(RequestCompleteBlock)completeBlock {
    TPDRevokedQuotesAPI * revokedQuotesAPI = [[TPDRevokedQuotesAPI alloc]initWithQuotesIds:quotesIds];
    revokedQuotesAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [revokedQuotesAPI start];
}


@end
