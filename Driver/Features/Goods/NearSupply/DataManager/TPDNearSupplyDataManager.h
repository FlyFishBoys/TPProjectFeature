//
//  TPDNearSupplyDataManager.h
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TPNearSupplyMapModel.h"

#import "TPDGoodsDataSource.h"

typedef void(^NearSupplyMapCompletionBlock)(BOOL success, TPNearSupplyMapModel * _Nullable model , TPBusinessError * _Nullable error);
typedef void (^NearSupplyFetchAdvertBlock)();
@interface TPDNearSupplyDataManager : NSObject

- (instancetype)initWithTarget:(id _Nullable )target;

@property (nonatomic, strong,nonnull) NSMutableDictionary *requestParams;

@property (nonatomic,strong,nonnull,readonly) TPDGoodsDataSource * listDataSource;

//获取广告完成
@property (nonatomic , copy) NearSupplyFetchAdvertBlock _Nullable fetchAdvertHandler;

- (void)fetchLocationCompletion:(void(^_Nonnull)(NSString *_Nonnull latitude,NSString *_Nonnull longitude))completionBlock;

- (void)loadListDataWithCallback:(void(^ _Nonnull)(BOOL success,TPBusinessError *_Nonnull error))callback;

- (void)loadNextPageDataWithCallback:(void(^ _Nonnull)(BOOL success,TPBusinessError * _Nonnull error))callback;

- (void)requestNearSupplyMapWithCallback:(NearSupplyMapCompletionBlock _Nonnull)callback;

@end
