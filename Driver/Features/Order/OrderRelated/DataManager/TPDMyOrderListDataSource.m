//
//  TPDMyOrderListDataSource.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyOrderListDataSource.h"
#import "TPDMyOrderListCell.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDMyOrderListAPI.h"
#import "TPDMyOrderListModel.h"
#import "TPDGoodsSignInAPI.h"
#import "TPDConfirmPickUpAPI.h"
#import "TPDConfirmDealAPI.h"
#import "TPDCancelDealAPI.h"
#import "TPDMyOrderListViewModel.h"

@interface TPDMyOrderListDataSource ()
{
    NSInteger _page;
}
@property (nonatomic,weak) id target;

@end

@implementation TPDMyOrderListDataSource
- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        self.target = target;
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    return self;
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    
    return [TPDMyOrderListCell class];
}
- (TPNoResultViewType)noResultViewTypeForTableView:(UITableView *)tableView {
    return TPNoResultViewTypeOrderListNull;
}

- (void)refreshMyOrderListWithStatus:(NSString *)status completeBlock:(RequestCompleteBlock)completeBlock {
    _page = 1;
    TPDMyOrderListAPI * myOrderListAPI = [[TPDMyOrderListAPI alloc]initWithStatus:status page:_page];
    myOrderListAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (error == nil && success) {
            if (completeBlock) {
                NSArray * orderLists = [NSArray yy_modelArrayWithClass:[TPDMyOrderListModel class] json:responseObject[@"list"]];
                TPDMyOrderListViewModel * viewModel = [[TPDMyOrderListViewModel alloc]initWithModels:orderLists target:self.target];
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
    
    [myOrderListAPI start];
}

- (void)loadMoreMyOrderListWithStatus:(NSString *)status completeBlock:(RequestListCompleteBlock)completeBlock {
    _page ++;
    TPDMyOrderListAPI * myOrderListAPI = [[TPDMyOrderListAPI alloc]initWithStatus:status page:_page];
    myOrderListAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (error == nil && success) {
            if (completeBlock) {
                NSArray * orderLists = [NSArray yy_modelArrayWithClass:[TPDMyOrderListModel class] json:responseObject[@"list"]];
                TPDMyOrderListViewModel * viewModel = [[TPDMyOrderListViewModel alloc]initWithModels:orderLists target:self.target];
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
    
    [myOrderListAPI start];
}

- (void)goodsSignUpWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion unloadCode:(NSString * _Nullable)unloadCode completeBlock:(RequestCompleteBlock _Nonnull)completeBlock {
    TPDGoodsSignInAPI * goodsSignInAPI = [[TPDGoodsSignInAPI alloc]initWithOrderId:orderId orderVersion:orderVersion unloadCode:unloadCode];
    goodsSignInAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [goodsSignInAPI start];
}

- (void)confirmPickUpWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion pickupCode:(NSString *)pickupCode completeBlock:(RequestCompleteBlock)completeBlock {
    TPDConfirmPickUpAPI * confirmPickUpAPI = [[TPDConfirmPickUpAPI alloc]initWithOrderId:orderId orderVersion:orderVersion pickupCode:pickupCode];
    confirmPickUpAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [confirmPickUpAPI start];
}

- (void)confirmDealWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion completeBlock:(RequestCompleteBlock)completeBlock {
    TPDConfirmDealAPI * confirmDealAPI = [[TPDConfirmDealAPI alloc]initWithPreOrderId:orderId orderVersion:orderVersion];
    confirmDealAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [confirmDealAPI start];
}

- (void)cancelDealWithOrderId:(NSString *)orderId orderVersion:(NSString *)orderVersion completeBlock:(RequestCompleteBlock)completeBlock {
    TPDCancelDealAPI * cancelDealAPI = [[TPDCancelDealAPI alloc]initWithPreOrderId:orderId orderVersion:orderVersion];
    cancelDealAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [cancelDealAPI start];
}
@end
