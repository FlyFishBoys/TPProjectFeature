//
//  TPDNearbyGoodsDataSource.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsDataSource.h"

@interface TPDNearbyGoodsDataSource : TPDGoodsDataSource

@property (nonatomic,strong) NSDictionary * requestParams;

- (void)loadStaticalDataWithArray:(NSArray *)dataArray callBack:(void(^)(BOOL success,TPBusinessError *error))callBack;


- (void)fetchDataWithCallBack:(void(^)(BOOL success,TPBusinessError *error,NSString *count))callBack;


- (void)loadNextPageDataWithCallBack:(void(^)(BOOL success,TPBusinessError *error,NSString *count))callBack;

@end
