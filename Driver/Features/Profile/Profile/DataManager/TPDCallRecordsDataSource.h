//
//  TPDCallRecordsDataSource.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewDataSource.h"

@interface TPDCallRecordsDataSource : TPBaseTableViewDataSource

@property (nonatomic,weak) id target;

- (void)fetchCallRecordsListDataWithHandler:(void(^)(BOOL success,TPBusinessError *error))handler;


- (void)clearAllCallRecordsWithHandler:(void(^)(BOOL success,TPBusinessError *error))handler;


- (void)loadNextPageHandler:(void(^)(BOOL success,TPBusinessError *error))handler;


- (void)fetchGoodsStatusWithGoodsId:(NSString *)goodsId Handler:(void(^)(BOOL shouldOperation))handler;

@end
