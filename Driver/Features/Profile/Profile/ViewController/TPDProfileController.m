//
//  TPDProfileController.m
//  TopjetPicking
//
//  Created by lish on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileController.h"
#import "WRNavigationBar.h"
#import "TPDProfileTopView.h"
#import "TPDProfileMiddleView.h"
#import "TPDProfileCellView.h"
#import "TPDProfileDataManager.h"
#import "TPDProfileViewModel.h"
#import "TPCallCenter.h"
#import "TPGlobalRefreshGifHeader.h"
#define NAVBAR_COLORCHANGE_POINT (64)
#define TOPVIEW_HEIGHT TPAdaptedHeight(166+72)
#define NAV_HEIGHT 64
@interface TPDProfileController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrolleView;

@property (nonatomic , strong) UIImageView *navMessageIcon;

@property (nonatomic , strong) UIImageView *navSetIcon;

@property (nonatomic , copy) TPDProfileTopView *topView;

@property (nonatomic , strong) TPDProfileMiddleView *middleView;//中间

@property (nonatomic , strong) TPDProfileCellView *suspensionView;//悬浮

@property (nonatomic , strong)  TPDProfileCellView *serviceView;//客服

@property (nonatomic , strong) TPDProfileViewModel *viewModel;

@end

@implementation TPDProfileController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.scrolleView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = TPBackgroundColor;
    [self setNavigationBar];
    [self addSubviews];
    [self setFrame];
    [self addRefreshHeader];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self addRegularActivity];
    [self requestParmterAPI];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark - bind
- (void)blindViewModel:(id)responseObject {
    
    [self.viewModel blindViewModel:responseObject];
    [self.topView blindViewModel:self.viewModel];
    [self.middleView blindViewModel:self.viewModel];
}

#pragma mark - Event Response

//点击设置按钮
- (void)tapSetBtn {
   
    [TPRouterAnalytic openInteriorURL:TPRouter_SetUp_Controller parameter:@{@"recommendame" : self.viewModel.model.recommend_name ?: @""} type:PUSHCONTROLLERTYPE_PUSH];
}
//点击消息按钮
- (void)tapMessagetBtn {
    
    
}
//点击头像
- (void)tapHeaderIcon {
        [TPRouterAnalytic openInteriorURL:TPRouter_ModifyAvatar_Controller parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
}

//点击签到按钮
- (void)tapSighInBtn {
    [TPDProfileDataManager requestSignInAPIWithComplete:^(BOOL succeed, id  _Nullable responseObject, TPBusinessError * _Nullable error) {
        if (succeed) {
            NSString *str = [NSString stringWithFormat:@"签到成功,+%@积分",responseObject];
            TPShowToast(str);
            [self requestParmterAPI];
        }else{
            TPShowToast(error.business_msg);
        }
    }];
}
//点击评价 积分 钱包余额
- (void)tapTopViewItemWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            //评价
        {
 
            [TPRouterAnalytic openInteriorURL:TPRouter_Evaluate parameter:@{@"parameter":@{},
                                                                           @"loadURL":TPWEB_URL_EvaluateList
                                                                            } type:PUSHCONTROLLERTYPE_PUSH];

        }
            break;
        case 1:
            //积分
        {
           
            [TPRouterAnalytic openInteriorURL:TPRouter_IntegralRecord parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
        }

            break;
        case 2:
            //钱包余额
        {
            [TPRouterAnalytic openInteriorURL:TPRouter_WalletHomePage parameter:@{} completeBlock:nil];
        }
            break;
    }
    
}

//点击中间view的Item 进入页面
- (void)tapMiddleItemWithIndex:(NSInteger)index {

    [TPRouterAnalytic openInteriorURL:TPDProfileMiddleView_URLS[index] parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
    
}
- (void)openSuspensionView:(BOOL)on {
    if (on) {
     
        [TPRouterAnalytic openInteriorURL:TPRouter_AssistiveTouch_Show parameter:@{} completeBlock:nil];
        
    }else{
        [TPRouterAnalytic openInteriorURL:TPRouter_AssistiveTouch_Hide parameter:@{} completeBlock:nil];
    }
}
#pragma mark - System Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        if (alpha>1.0) {
            alpha=1.0;
        }
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self updateNavigationBar:YES];
        if (alpha >= 1.0 && offsetY > NAV_HEIGHT) {
            self.navigationItem.title = self.viewModel.name;
        }
    }else {
        [self wr_setNavBarBackgroundAlpha:0.0];
        [self updateNavigationBar:NO];

    }
}
#pragma mark - request methods
- (void)requestParmterAPI {
    
    [TPDProfileDataManager requestPersonCenterParameterWithComplete:^(BOOL succeed, id  _Nullable responseObject, TPBusinessError * _Nullable error) {
        if (succeed) {
            [self blindViewModel:responseObject];
        }else{
            TPShowToast(error.business_msg);
        }
        [self.scrolleView.mj_header endRefreshing];
    }];
}

#pragma mark - UI
//添加定时红包
- (void)addRegularActivity {
    [TPRouterAnalytic openInteriorURL:TPRouter_RegularActivity parameter:@{
                                                                           @"presentController":self} completeBlock:nil];
 
}
- (void)setNavigationBar {
    UIBarButtonItem *one = [[UIBarButtonItem alloc]                           initWithCustomView:self.navMessageIcon];
    UIBarButtonItem *two = [[UIBarButtonItem alloc]initWithCustomView:self.navSetIcon];
    //创建一个空白占位bar
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = TPAdaptedWidth(21);
    
    self.navigationItem.rightBarButtonItems = @[one,spaceItem,two];
    [self updateNavigationBar:NO];
    [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarTitleColor:[UIColor whiteColor]];
    [self wr_setNavBarBackgroundAlpha:0.0];
   
}
- (void)addSubviews {
    
     [self.view addSubview:self.scrolleView];
     [self.scrolleView addSubview:self.topView];
     [self.scrolleView addSubview:self.suspensionView];
     [self.scrolleView addSubview:self.serviceView];
     [self.scrolleView addSubview:self.middleView];

}
- (void)setFrame {
    
    [_scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 49, 0));
    }];
    
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.scrolleView);
        make.width.equalTo(self.scrolleView);
        make.height.mas_equalTo(TOPVIEW_HEIGHT);
    }];
    
    [_middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.left.equalTo(self.scrolleView.mas_left).offset(TPAdaptedWidth(12));
        make.right.equalTo(self.scrolleView.mas_right).offset(TPAdaptedWidth(12));
        make.height.mas_equalTo(TPAdaptedHeight(212));
    }];
    
    [_suspensionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom).offset(TPAdaptedHeight(12));
        make.left.right.equalTo(self.scrolleView);
        make.height.mas_equalTo(TPAdaptedHeight(52));
    }];
    
    [_serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.suspensionView.mas_bottom);
        make.left.right.equalTo(self.scrolleView);
        make.height.mas_equalTo(TPAdaptedHeight(52));
        make.bottom.equalTo(self.scrolleView.mas_bottom).offset(TPAdaptedHeight(-60));
    }];
    
    UIImage *messageImage = [UIImage imageNamed:@"personal_center_set_icon"];
    _navMessageIcon.frame = CGRectMake(TPScreenWidth - TPAdaptedWidth(334), 34, messageImage.size.width, messageImage.size.height);
    
    UIImage *setImage = [UIImage imageNamed:@"personal_center_set_icon"];
    _navSetIcon.frame = CGRectMake(TPScreenWidth - TPAdaptedWidth(292), 34, setImage.size.width, setImage.size.height);
}
#pragma mark - getter / setter
- (UIScrollView *)scrolleView
{
    if (!_scrolleView) {
        _scrolleView = [[UIScrollView alloc]init];
        _scrolleView.delegate = self;
        _scrolleView.showsHorizontalScrollIndicator = NO;
        _scrolleView.showsVerticalScrollIndicator = NO;
        _scrolleView.backgroundColor = TPBackgroundColor;
        _scrolleView.scrollEnabled = YES;
        _scrolleView.bounces = YES;
        
    }
    return _scrolleView;
}
- (TPDProfileTopView *)topView {
    if (!_topView) {
        _topView = [[TPDProfileTopView alloc] init];
       
        @weakify(self);
        _topView.tapSetIconHandle = ^{
            @strongify(self);
            [self tapSetBtn];
        };
        _topView.tapMessageIconHandle = ^{
            @strongify(self);
            [self tapMessagetBtn];
        };
        _topView.tapItemHandle = ^(NSInteger index) {
            @strongify(self);
            [self tapTopViewItemWithIndex:index];
        };
        _topView.tapSignInHandle = ^{
            @strongify(self);
            [self tapSighInBtn];
        };
        _topView.tapHeaderIconHandle = ^{
            @strongify(self);
            [self tapHeaderIcon];
        };
        
    }
    return _topView;
}
- (UIImageView *)navMessageIcon{
    
    if (!_navMessageIcon) {
        _navMessageIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_center_message_icon"]];
        @weakify(self);
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            [self tapMessagetBtn];
        }];
        [_navMessageIcon addGestureRecognizer:tap];
    }
    return _navMessageIcon;
}
- (UIImageView *)navSetIcon {
    
    if (!_navSetIcon) {
        _navSetIcon =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_center_set_icon"]];
        @weakify(self);
        
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
             [self tapSetBtn];
        }];
        [_navSetIcon addGestureRecognizer:tap];
    }
    return _navSetIcon;
}

- (TPDProfileMiddleView *)middleView {
    
    if (!_middleView) {
        @weakify(self);
        _middleView = [[TPDProfileMiddleView alloc] initWithIcons:TPDProfileMiddleView_Icons titles:TPDProfileMiddleView_Titles handler:^(NSInteger index) {
            @strongify(self);
            [self tapMiddleItemWithIndex:index];
        }];
    }
    return _middleView;
    
}
- (TPDProfileCellView *)suspensionView {
    if (!_suspensionView) {
        _suspensionView = [[TPDProfileCellView alloc]init];
        _suspensionView.viewType = PersonalCenterCellViewType_Swicth;
        _suspensionView.titleStr = @"悬浮菜单";
        @weakify(self);
        _suspensionView.tapSwitchHandle = ^(BOOL isON) {
            @strongify(self);
            [self openSuspensionView:isON];
        };
    }
    return _suspensionView;
}


- (TPDProfileCellView *)serviceView {
    if (!_serviceView) {
        _serviceView = [[TPDProfileCellView alloc]init];
        _serviceView.viewType = PersonalCenterCellViewType_Arrow;
        _serviceView.titleStr = @"客服热线";
        _serviceView.detailStr = TPServiceTel;
        _serviceView.tapArrowHandle = ^{
            [[TPCallCenter shareInstance]callUpWithTel:TPServiceTel];
        };
    }
    return _serviceView;
}
- (TPDProfileViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[TPDProfileViewModel alloc] init];
    }
    return _viewModel;
    
}
#pragma mark - private
-(void)updateNavigationBar:(BOOL)hide {
    if (hide) self.navigationItem.title = @"";
    [self.navigationController.navigationBar setBackgroundImage:hide ? [UIImage imageNamed:@"personal_center_navgation_bg"] : nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = !hide;
    _navSetIcon.hidden = !hide;
    _navMessageIcon.hidden = !hide;
    [self.topView showIcon:hide];
   
}
- (void)addRefreshHeader {
    self.scrolleView.mj_header = [TPGlobalRefreshGifHeader headerWithRefreshingBlock:^{
        [self requestParmterAPI];
    }];
}
@end


