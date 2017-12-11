//
//  TPDIntegrityInquiryResultDataSource.h
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"
#import "TPDIntegrityInquiryDefines.h"

@interface TPDIntegrityInquiryResultDataSource : TPBaseTableViewDataSource

- (instancetype _Nonnull)initWithTarget:(id _Nonnull)target;

//刷新货源列表数据
- (void)refreshGoodsListWithUserId:(NSString *_Nullable)userId completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

//加载更多货源数据
- (void)loadMoreGoodsListWithUserId:(NSString *_Nullable)userId completeBlock:(RequestListCompleteBlock _Nonnull )completeBlock;
@end
