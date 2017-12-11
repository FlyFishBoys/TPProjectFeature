//
//  TPDNearbyGoodsDataSource.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearbyGoodsDataSource.h"

#import "TPDNearSupplyStaticalAPI.h"

#import "TPDNearbyMapStaticalModel.h"

#import "TPBaseTableViewSectionObject.h"

@implementation TPDNearbyGoodsDataSource
{
    NSInteger page_;
}
- (instancetype)init {
    if (self = [super init]) {
        page_ = 1;
    }
    return self;
}

- (void)loadStaticalDataWithArray:(NSArray *)dataArray callBack:(void(^)(BOOL success,TPBusinessError *error))callBack {
    if (dataArray == nil || dataArray.count == 0) {
        TPBusinessError *error = [[TPBusinessError alloc] init];
        error.business_msg = @"数据请求为空E566560";
        error.business_code = @"566560";
        if (callBack) {
            callBack(NO,error);
        }
        return;
    }
    [self refreshItemsWithResponseObject:dataArray];
    
    if (callBack) {
        callBack(YES,nil);
    }
}

- (void)fetchDataWithCallBack:(void(^)(BOOL success,TPBusinessError *error,NSString *count))callBack {
    page_ = 1;
    TPDNearSupplyStaticalAPI *api = [[TPDNearSupplyStaticalAPI alloc] initWithParams:self.requestParams page:page_];
    @weakify(self);
    api.filterCompletionHandler = ^(BOOL success,  id _Nonnull responseObject, TPBusinessError * _Nullable error) {
        @strongify(self);
        NSString *total;
        if (success && error == nil) {
            //total = responseObject.total;
            [self refreshItemsWithResponseObject:responseObject];
        } else {
            total = @"0";
        }
        if (callBack) callBack(success,error,total);
    };
    [api start];
}

- (void)loadNextPageDataWithCallBack:(void(^)(BOOL success,TPBusinessError *error,NSString *count))callBack {
    page_ ++;
    
    TPDNearSupplyStaticalAPI *api = [[TPDNearSupplyStaticalAPI alloc] initWithParams:self.requestParams page:page_];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        NSString *total;
        if (success && error == nil) {
            
            NSArray *tempArr = [NSArray arrayWithArray:responseObject[@"list"]];
            if (tempArr.count > 0) {
                [self appendItemsWithResponseObject:responseObject];
                //total = responseObject.total.isNotBlank ? responseObject.total : @"0";
            } else {
               // total = [NSString stringWithFormat:@"%ld",((TPBaseTableViewSectionObject *)self.sections.firstObject).items.count];
                page_ --;
            }
            if (callBack) callBack(YES,nil,@"0");
        } else {
            page_ --;
            if (callBack) callBack(NO,error,@"0");
        }
    };
    [api start];
}
@end
