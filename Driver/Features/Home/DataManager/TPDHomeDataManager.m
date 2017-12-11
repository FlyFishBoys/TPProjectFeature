//
//  TPDHomeDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeDataManager.h"
#import "TPDHomeFunctionItemAPI.h"
#import "TPDHomeFuctionItemModel.h"
#import "TPDHomeUserParameterAPI.h"
#import "TPAdvertDataManager.h"
@implementation TPDHomeDataManager
- (instancetype)init {
    
    self = [super init];
    if (self) {
        _fuctionItemArr = [NSArray arrayWithArray:[self defaultHomenFuctionItem]];
    }
    return self;
    
}

- (void)defaultRequestAPIs {
   
    [self requestHomeBanner];
    [self requestHomeNotice];
    [self requestHomeWebURL];
    [self requestHomeFuctionItem];
}
- (void)requestHomeBanner{
    
    [TPAdvertDataManager requestHomeBannerWithComplete:^(BOOL success, id responseObject, TPBusinessError *error) {
        self.bannerArray  = [NSArray arrayWithArray:responseObject];
        if (self.fetchHomeBannerComplete) {
            self.fetchHomeBannerComplete();
        }
    }];
}

- (void)requestHomeNotice{
    
    [TPAdvertDataManager requestHomeNoticeComplete:^(BOOL success, id responseObject, TPBusinessError *error) {
        self.announcementArray = [NSArray arrayWithArray:responseObject];
        if (self.fetchHomeAnnouncementComplete) {
            self.fetchHomeAnnouncementComplete();
        }
    }];
}
- (void)requestHomeWebURL {
    [TPAdvertDataManager requestHomeWebURLWithComplete:^(BOOL success, id responseObject, TPBusinessError *error) {
         self.webURL = responseObject;
         self.isExistWebURL = [self.webURL isNotBlank]?YES:NO;
        if (self.fetchHomeWebURLComplete) {
            self.fetchHomeWebURLComplete();
        }
    }];
    
}

- (void)requestHomeNoticeURLWithIndex:(NSInteger)index{
    
    if (![self.announcementArray[index].announcement_id isNotBlank]) {
        return;
    }
    [TPAdvertDataManager requestHomeNoticeURLWithAnnouncementId:self.announcementArray[index].announcement_id complete:^(BOOL success, id responseObject, TPBusinessError *error) {
        
        if (self.fetchAnnouncementURLComplete) {
            self.fetchAnnouncementURLComplete(responseObject[@"redirect_url"],responseObject[@"title"]);
        }
    }];
    
}

- (void)requestHomeUserParameter{
    
    TPDHomeUserParameterAPI *api = [[TPDHomeUserParameterAPI alloc]initUserParameter];
    __block BOOL isExtit = NO;
    api.filterCompletionHandler = ^(BOOL success,id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        if (responseObject != nil && ![responseObject  isKindOfClass:[NSNull class]]) {
            
            if ([responseObject[@"is_exist"] isEqualToString:@"1"]) {
               isExtit =YES;
                
            }else{
                 isExtit =NO;
            }
            
        }else{
            
            isExtit = YES;
        }
        if (self.fetchHomeUserParameterComplete) {
            self.fetchHomeUserParameterComplete(isExtit);
        }
    };
    [api start];
}

- (void)requestHomeFuctionItem {
    TPDHomeFunctionItemAPI *api = [[TPDHomeFunctionItemAPI alloc] initWithVersion:@""];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            NSString *version = responseObject[@"version"];
            if (![version isKindOfClass:[NSNull class]]) {
                if ([version isNotBlank]) {
                    [[NSUserDefaults standardUserDefaults]setObject:version forKey:@"HomeFunctionVersion"];
                }
            }
            NSArray *temp = [NSArray yy_modelArrayWithClass:[TPDHomeFuctionItemModel class] json:responseObject[@"list"]];
            
            if (temp == nil || responseObject == nil || [temp isKindOfClass:[NSNull class]] || temp.count == 0) {
                self.fuctionItemArr  =[NSArray arrayWithArray:[self defaultHomenFuctionItem]];

            }
        }
        if (self.fetchfuctionItemComplete) {
            self.fetchfuctionItemComplete();
        }
    };
    [api start];
    
}

- (NSArray *)defaultHomenFuctionItem {
    
     NSArray *iconArr = @[@"homepage_icon_wallet",
                          @"homepage_icon_integrity",
                          @"homepage_icon_illegal",
                          @"homepage_icon_delivery",
                          @"homepage_icon_helpcenter",
                          @"homepage_icon_weather",
                          @"homepage_icon_longju",
                          @"homepage_icon_qygame",
                          @"homepage_icon_luckshop"];
    
    NSArray *detailArr = @[
                           @"安全交易到账快",
                           @"查诚信 交易更放心",
                           @"我们是免费的",
                           @"发货找车在这里",
                           @"给你最满意的解答",
                           @"你那里的天气好吗",
                           @"物流人的专属理财",
                           @"三缺一，就等你了",
                           @"一块钱就能买iPhone",
                           ];
    NSArray *titleArr = @[
                          @"我的钱包",
                          @"诚信查询",
                          @"违章查询",
                          @"货主发货",
                          @"帮助中心",
                          @"本地天气",
                          @"龙驹财行",
                          @"趣赢游戏",
                          @"好运购",
                          ];
    
    NSArray *routeUrlArr = @[
                             TPRouter_WalletHomePage,
                             TPRouter_IntegrityInquiry_Conteroller,
                             TPRouter_WebViewController_ViolationQuery,
                             @"",
                             TPRouter_WebViewController_HelpCenter,
                             TPRouter_Weather_Conteroller,
                             @"",
                             @"",
                             @"",
                             @"",
                             ];
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < titleArr.count; i++) {
        
        TPDHomeFuctionItemModel *model = [[TPDHomeFuctionItemModel alloc]init];
        model.title = titleArr[i];
        model.content = detailArr[i];
        model.icon_image = iconArr[i];
        model.url = routeUrlArr[i];
        [temp addObject:model];
        
    }
    
    return temp.mutableCopy;
}

- (void)setAnnouncementArray:(NSArray *)announcementArray {
    
    _announcementArray = announcementArray;
    NSMutableArray *textArr = [NSMutableArray array];
   
    for (TPAnnouncementModel *model in _announcementArray) {
        [textArr addObject:model.content];
    }
    _announcementTextArray = [NSArray arrayWithArray:textArr.mutableCopy];
}
- (void)setBannerArray:(NSArray *)bannerArray {
    
    _bannerArray = bannerArray;
   NSMutableArray * bannnerImages = [NSMutableArray array];
    if (_bannerArray.count == 0 || _bannerArray == nil) {
        for (int index = 0; index < 1; index++) {
            UIImage *image = [UIImage imageNamed:@"homepage_banner"];
            [bannnerImages addObject:image];
        }
        _bannnerImages = [NSArray arrayWithArray:bannnerImages.mutableCopy];
        return;
    }
    for (int index = 0; index < _bannerArray.count; index++) {
        UIImageView *pic= [[UIImageView alloc]init];
        [pic tp_setOriginalCircleImageWithURL:[NSURL URLWithString:_bannerArray[index].picture_url] md5Key:_bannerArray[index].picture_key placeholderImage:[UIImage imageNamed:@"homepage_banner"]];
        [bannnerImages addObject:pic.image];
    }
    _bannnerImages = [NSArray arrayWithArray:bannnerImages.mutableCopy];
    
}

@end
