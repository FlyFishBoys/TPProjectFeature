//
//  TPDIntegrityInquiryResultDataSource.m
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryResultDataSource.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDIntegrityInquiryGoodsCell.h"
#import "TPBaseTableViewItem.h"
#import "TPDIntegrityInquiryGoodsListAPI.h"
#import "TPDIntegrityInquiryGoodsListViewModel.h"
#import "TPDIntegrityInquiryGoodsModel.h"

@interface TPDIntegrityInquiryResultDataSource ()
{
    NSInteger _page;
}
@property (nonatomic,weak) id target;

@end

@implementation TPDIntegrityInquiryResultDataSource
- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        self.target = target;
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    return self;
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    
    return [TPDIntegrityInquiryGoodsCell class];
}
- (TPNoResultViewType)noResultViewTypeForTableView:(UITableView *)tableView {
    return TPNoResultViewTypeIntegrityInquiryResultListNull;
}

- (void)refreshGoodsListWithUserId:(NSString *)userId completeBlock:(RequestCompleteBlock)completeBlock {
    _page = 1;
    TPDIntegrityInquiryGoodsListAPI * integrityInquiryGoodsListAPI = [[TPDIntegrityInquiryGoodsListAPI alloc]initWithUserId:userId page:_page];
    integrityInquiryGoodsListAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (error == nil && success) {
            if (completeBlock) {
                NSArray * orderLists = [NSArray yy_modelArrayWithClass:[TPDIntegrityInquiryGoodsModel class] json:responseObject[@"list"]];
                TPDIntegrityInquiryGoodsListViewModel * viewModel = [[TPDIntegrityInquiryGoodsListViewModel alloc]initWithModels:orderLists target:self.target];
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
    
    [integrityInquiryGoodsListAPI start];
}

- (void)loadMoreGoodsListWithUserId:(NSString *)userId completeBlock:(RequestListCompleteBlock)completeBlock {
    _page ++;
    TPDIntegrityInquiryGoodsListAPI * integrityInquiryGoodsListAPI = [[TPDIntegrityInquiryGoodsListAPI alloc]initWithUserId:userId page:_page];
    integrityInquiryGoodsListAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (error == nil && success) {
            if (completeBlock) {
                NSArray * orderLists = [NSArray yy_modelArrayWithClass:[TPDIntegrityInquiryGoodsModel class] json:responseObject[@"list"]];
                TPDIntegrityInquiryGoodsListViewModel * viewModel = [[TPDIntegrityInquiryGoodsListViewModel alloc]initWithModels:orderLists target:self.target];
                [self appendItems:viewModel.viewModels];
                completeBlock(YES,nil,orderLists.count);
            }
        } else {
            _page --;
            if (completeBlock) {
                completeBlock(NO,error,0);
            }
        }
    };
    
    [integrityInquiryGoodsListAPI start];
}
@end
