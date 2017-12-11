//
//  TPDHomeDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAdvertModel.h"
#import "TPAnnouncementModel.h"
typedef void (^TPDHomeUserParameterBlcok)(BOOL isExist);
typedef void (^TPDHomeDataManagerFetchComplete)();
typedef void (^TPDHomeDataManagerFetchAnnouncementURLComplete)(NSString *turnURL,NSString *webTitle);
@interface TPDHomeDataManager : NSObject

@property (nonatomic , copy)  TPDHomeDataManagerFetchComplete fetchHomeBannerComplete;//获取轮播图完成

@property (nonatomic , copy)  TPDHomeDataManagerFetchComplete fetchHomeAnnouncementComplete;//获取首页公告完成

@property (nonatomic , copy)  TPDHomeDataManagerFetchAnnouncementURLComplete fetchAnnouncementURLComplete;//获取首页公告URL完成

@property (nonatomic , copy)  TPDHomeDataManagerFetchComplete fetchHomeWebURLComplete;//获取首页h5完成

@property (nonatomic , copy) TPDHomeDataManagerFetchComplete fetchfuctionItemComplete;//获取首页中间item完成

@property (nonatomic , copy) TPDHomeUserParameterBlcok fetchHomeUserParameterComplete;//请求用户参数

@property (nonatomic , strong) NSArray <TPAdvertModel *>*bannerArray;//轮播图

@property (nonatomic , strong) NSArray *bannnerImages;//轮播图图片数组

@property (nonatomic , strong) NSArray <TPAnnouncementModel *> *announcementArray;//公告

@property (nonatomic , strong) NSArray *announcementTextArray;//公告文字数组

@property (nonatomic , copy) NSString *webURL;//h5地址

@property (nonatomic , assign) BOOL isExistWebURL;//是否存在h5

@property (nonatomic , strong) NSArray *fuctionItemArr;//中间item

/**
 默认请求 包括banner 公告 h5地址 FuctionItem
 */
- (void)defaultRequestAPIs;


/**
 请求用户是否添加了常跑跑城市

 */
- (void)requestHomeUserParameter;

/**
 请求公告活动链接

 @param index 坐标
 */
- (void)requestHomeNoticeURLWithIndex:(NSInteger)index;

@end
