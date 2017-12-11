//
//  TPDGoodsDataSource.h
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"
@class TPDGoodsModel;
@interface TPDGoodsDataSource : TPBaseTableViewDataSource

@property (nonatomic , assign) TPNoResultViewType noResultViewType;

- (instancetype)initWithTarget:(id)target;

//刷新货源
- (void)refreshItemsWithResponseObject:(id)responseObject;

//刷新货源
- (void)refreshItemsWithGoodsModels:(NSArray <TPDGoodsModel *>*)goodsModels;

//加载更多数据
- (void)appendItemsWithResponseObject:(id)responseObject;

- (void)appendItemsWithGoodsModels:(NSArray <TPDGoodsModel *>*)goodsModels;

//插入货源广告
- (void)insertGoodsAdvertWithResponseObject:(id)responseObject;


@end
