//
//  TPDFreightAgentDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreightAgentDataManager.h"
#import "TPDJudgeFreighAgentAPI.h"
#import "TPDFreighAgentListAPI.h"
@implementation TPDFreightAgentDataManager {
    NSString *_page;
}
- (instancetype)initWithTarget:(id)target {
    
    self = [super init];
    if (self) {
        
        self.dataSource = [[TPDFreightAgentDataSource alloc]initWithTarget:target];
        _page = @"1";
    }
    return self;
    
}

- (void)pullUpFreightAgentListWithDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode {
    
    
    if (![departCode isNotBlank]) {
        return;
    }
    _page = [NSString stringWithFormat:@"%d",_page.intValue+1];
    
    TPDFreighAgentListAPI *api = [[TPDFreighAgentListAPI alloc]initWithBeginCity:departCode endCity:destinationCode page:_page];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
            [self.dataSource appendItemsWithResponseObject:responseObject[@"economic_list"]];
        }else{
            [self.dataSource appendItemsWithResponseObject:@[]];
            TPShowToast(error.business_msg);
        }
        if (self.fetchListComplete) {
            self.fetchListComplete();
        }
    };
    [api start];
    
}
- (void)pullDownFreightAgentListWithDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode {
    
    
    if (![departCode isNotBlank]) {
        return;
    }
    _page = @"1";
    TPDFreighAgentListAPI *api = [[TPDFreighAgentListAPI alloc]initWithBeginCity:departCode endCity:destinationCode page:_page];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
            [self.dataSource reloadItemsWithResponseObject:responseObject[@"economic_list"]];
        }else{
            [self.dataSource reloadItemsWithResponseObject:@[]];
            TPShowToast(error.business_msg);
        }
        if (self.fetchListComplete) {
            self.fetchListComplete();
        }
    };
    [api start];
    
}
- (void)fetchHaveFreightAgentWithDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode {
    
    
    TPDJudgeFreighAgentAPI *api = [[TPDJudgeFreighAgentAPI alloc]initWithBeginCity:departCode endCity:destinationCode];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        BOOL isHave = NO;
        if (success && !error && ![responseObject isKindOfClass:[NSNull class]]) {
            NSString *count = responseObject[@"economic_count"];
                if (count.integerValue == 0 ) {
                    isHave = NO;
                }else{
                    isHave = YES;
                }
        }else{
            isHave = NO;
           
        }
        if (self.fetchFreightAgentComplete) {
            self.fetchFreightAgentComplete(isHave);
        }
    };
    [api start];
}
@end
