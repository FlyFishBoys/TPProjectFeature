//
//  TPDHomeController.m
//  TopjetPicking
//
//  Created by lish on 2017/8/8.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeController.h"
#import "TPDBeginGuideView.h"
#import "TPDHomeBannerCell.h"
#import "TPDHomeMiddleCell.h" //
#import "TPDHomeFuctionCell.h"
#import "TPDHomeWebViewCell.h"
#import "TPDHomeScrollLabelView.h"
#import "UIImage+Gradient.h"
#import "WRNavigationBar.h"
#import "TPDHomeDataManager.h"
#import "TPWalletPayTool.h"
#import "TPDAddConstantCityView.h"
#import "TPDSelectProvinceView.h"
#import "TPWebViewController.h"
#import "TPRegularActivityView.h"
#import "TPHomeAdvertPopView.h"
#import "NSFileManager+Category.h"
#import "TPDCheckPathViewController.h"
@interface TPDHomeController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) TPDHomeScrollLabelView *headerView;

@property (nonatomic , strong) TPDHomeDataManager *dataManager;

@end
@implementation TPDHomeController
#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self requestDefaultAPI];
    [self setNavBarAppearence];
   [self addRegularActivity];
}

#pragma mark - Event Response
//点击消息中心
- (void)tapRightItem {
    
}
//点击我的车队
- (void)tapLeftBtn {
    [TPRouterAnalytic openInteriorURL:TPRouter_Vehicle_MyVehicleTeam_List parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
 
}
//点击积分商城
- (void)tapRightBtn {

}
//点击轮播图
- (void)tapBannerWithIndex:(NSInteger)index {
    
    NSString *webURL = [self.dataManager.bannerArray objectAtIndex:index].redirect_url;
    DDLog(@"点击URL'%@",webURL);
    NSString *title = [self.dataManager.bannerArray objectAtIndex:index].web_title;
    [self turnWebControllerWithWebTitle:title turnURL:webURL isNavigationBar:@"0"];
    
}
//点击中间选项item
- (void)tapFuctionItemWithRouterURL:(NSString *)routeURL {
    if ([routeURL isEqualToString:TPRouter_WalletHomePage]) {
    
        [TPRouterAnalytic openInteriorURL:routeURL parameter:@{} completeBlock:nil];
    }else {
        [TPRouterAnalytic openInteriorURL:routeURL parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
    }
    
}
//添加常跑城市
- (void)addConstantCityComplete:(void(^)())complete {
    
    [self.dataManager requestHomeUserParameter];
    self.dataManager.fetchHomeUserParameterComplete = ^(BOOL isExist) {
        if (!isExist) {
            TPDAddConstantCityView *cityView = [[TPDAddConstantCityView alloc]initWithSelectViewType:SELECTVIEW_Third_ALL_AREA];
            [cityView show];
            cityView.dismissBlock = ^{
                if (complete) {
                    complete();
                }
            };
        }else{
            if (complete) {
                complete();
            }
        }
    };
}
//点击进入webview页面
- (void)turnWebControllerWithWebTitle:(NSString *)webTitle turnURL:(NSString *)turnURL isNavigationBar:(NSString *)isNavigationBar {
    if (![turnURL isNotBlank] ) {
        return;
    }
    UIViewController *vc = [TPRouterAnalytic interiorObjectForURL:TPRouter_WebViewController_Common parameter:@{@"loadURL":turnURL,@"title":webTitle?webTitle:@"",@"isNavigationBar":isNavigationBar?isNavigationBar:@"1"}];
    
    [self cyl_pushViewController:vc animated:YES];
}

#pragma mark - request methods
- (void)requestDefaultAPI {
    
    [self.dataManager defaultRequestAPIs];
    [self fetchBanner];
    [self fetchNotice];
    [self fetchWebURL];
}
//获取bannner
- (void)fetchBanner {
     @weakify(self);
    self.dataManager.fetchHomeBannerComplete = ^() {
          @strongify(self);
        [self.tableView reloadData];
    };
}
//获取中间item
- (void)fetchHomeFuctionItem {
    @weakify(self);
    self.dataManager.fetchfuctionItemComplete  = ^() {
        @strongify(self);
        [self.tableView reloadData];
    };
}
//获取h5地址
- (void)fetchWebURL {
     @weakify(self);
    self.dataManager.fetchHomeWebURLComplete = ^() {
           @strongify(self);
        [self.tableView reloadData];
    };
}
//获取公告
- (void)fetchNotice {
    @weakify(self);
    self.dataManager.fetchHomeAnnouncementComplete = ^() {
        @strongify(self);
        self.headerView.scrollTextArray = self.dataManager.announcementTextArray;
        [self.tableView reloadData];
    };
}
//获取公告链接
- (void)fetchNoticeURLWithIndex:(NSInteger)index{
    @weakify(self);
    [self.dataManager requestHomeNoticeURLWithIndex:index];
    self.dataManager.fetchAnnouncementURLComplete = ^(NSString *turnURL, NSString *webTitle) {
        @strongify(self);
        [self turnWebControllerWithWebTitle:webTitle turnURL:turnURL isNavigationBar:@"0"];
    };
}
#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section  == 0) {
        return 1;
    }
    else {
        return self.dataManager.isExistWebURL?3:2;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return TPAdaptedHeight(180);
        
    }else {
        if (indexPath.row == 0) {
            return TPAdaptedHeight(70);
        }else if (indexPath.row == 1){
            return TPAdaptedHeight(75*3+28);
        }
        else {
            return self.dataManager.isExistWebURL?TPScreenHeight:CGFLOAT_MIN;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        TPDHomeBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BannerCell"];
        cell.bannerImages = self.dataManager.bannerArray;
        @weakify(self);
        cell.tapBannerHandler = ^(NSInteger index) {
            @strongify(self);
            [self tapBannerWithIndex:index];
        };
        return cell;
    }else {
        
        if (indexPath.row == 0) {
            TPDHomeMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MiddleCell"];
            @weakify(self);
            cell.tapLeftBtnCompleteBlock = ^(UIButton * button) {
                 @strongify(self);
                [self tapLeftBtn];
            };
            cell.tapRightBtnCompleteBlock = ^(UIButton *button) {
                @strongify(self);
                [self tapRightBtn];
            };
            return cell;
        }else if (indexPath.row == 1){
            TPDHomeFuctionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FuctionCell"];
            cell.fuctionItemArr = self.dataManager.fuctionItemArr;
            @weakify(self);
            cell.tapItemBlock = ^(NSString *routeURL) {
                @strongify(self);
                [self tapFuctionItemWithRouterURL:routeURL];
            };
            return cell;
            
        }else {
            TPDHomeWebViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"WebViewCell"];
            cell.webURL = self.dataManager.webURL;
            return cell;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return TPAdaptedHeight(45);
    }else {
        return CGFLOAT_MIN;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.headerView;
        
    }else {
        return nil;
    }
}

#pragma mark - Getters and Setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TPDHomeBannerCell class] forCellReuseIdentifier:@"BannerCell"];
        [_tableView registerClass:[TPDHomeMiddleCell class] forCellReuseIdentifier:@"MiddleCell"];
        [_tableView registerClass:[TPDHomeFuctionCell class] forCellReuseIdentifier:@"FuctionCell"];
        [_tableView registerClass:[TPDHomeWebViewCell class] forCellReuseIdentifier:@"WebViewCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (TPDHomeScrollLabelView *)headerView {
    
    if (!_headerView) {
        _headerView = [[TPDHomeScrollLabelView alloc]initWithFrame:CGRectMake(0, 0, TPScreenWidth, TPAdaptedWidth(40))];
        @weakify(self);
        
        _headerView.tapScrollLabelHander = ^(NSInteger index) {
              @strongify(self);
            [self fetchNoticeURLWithIndex:index];
        };
    }
    return _headerView;
}
- (TPDHomeDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDHomeDataManager alloc]init];
    }
    return _dataManager;
}
#pragma mark - UI
- (void)addSubviews {
    
    [self addRightItem];
    [self startBeginGuideView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
 
    
}
//新手引导页
- (void)startBeginGuideView {
    @weakify(self);
    [TPDBeginGuideView startBeginGuideCompleteBlock:^(BOOL isFirst) {
        @strongify(self);
        //常跑城市
        [self addConstantCityComplete:^{
            @strongify(self);
            //首页广告弹窗
            [self popHomeAdvertView];
        }];
    }];
}
//添加定时红包
- (void)addRegularActivity {
    [TPRouterAnalytic openInteriorURL:TPRouter_RegularActivity parameter:@{
                                                                           @"presentController":self} completeBlock:nil];
   
}
//弹首页广告
- (void)popHomeAdvertView {
    @weakify(self);
    void (^disappearHandler)() = ^{
        NSLog(@"消失");
    };
    void (^clickHandler)(NSString *webTitle,NSString *turnURL) = ^(NSString *webTitle,NSString *turnURL){
        @strongify(self);
        [self turnWebControllerWithWebTitle:webTitle turnURL:turnURL isNavigationBar:@"0"];
        NSLog(@"点击 %@ %@",webTitle,turnURL);
    };
    [TPRouterAnalytic openInteriorURL:TPRouter_HomeAdvert parameter:@{MGJRouterParameterCompletion:clickHandler,
                                                                     @"disappearHandler":disappearHandler
                                                                      } completeBlock:nil];
    
    
}

- (void)addRightItem {
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"personal_center_message_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(tapRightItem)];;
}
- (void)setNavBarAppearence {
    
    self.navigationItem.title = @"首页";
    [self wr_setNavBarBackgroundImage:[UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth, 64) startColor:TPGradientStartColor endColor:TPGradientEndColor]];
    [self wr_setNavBarBarTintColor:TPMainColor];
    [self wr_setNavBarTitleColor:TPWhiteColor];
    [self wr_setNavBarTintColor:TPWhiteColor];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self wr_setNavBarShadowImageHidden:YES];
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress {
    [self.navigationController.navigationBar wr_setTranslationY:(-64 * progress)];
    [self.navigationController.navigationBar wr_setBarButtonItemsAlpha:(1 - progress) hasSystemBackIndicator:NO];
}
@end
