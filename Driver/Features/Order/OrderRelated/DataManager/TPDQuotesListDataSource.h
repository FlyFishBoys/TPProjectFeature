//
//  TPDQuotesListDataSource.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"
#import "TPDOrderDefines.h"

@interface TPDQuotesListDataSource : TPBaseTableViewDataSource

@property (nonatomic, assign) NSInteger count;

- (instancetype _Nonnull)initWithTarget:(id _Nonnull)target;

//刷新我的报价数据
- (void)refreshQuotesListWithCompleteBlock:(RequestCompleteBlock _Nonnull )completeBlock;

//加载更多我的报价数据
- (void)loadMoreQuotesListWithCompleteBlock:(RequestListCompleteBlock _Nonnull )completeBlock;

/**
 撤销报价
 
 @param quotesIds 报价id的数组
 @param completeBlock 请求完成的block
 */
- (void)revokedQuotesWithQuotesIds:(NSArray<NSString *> *_Nonnull)quotesIds completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;
@end
