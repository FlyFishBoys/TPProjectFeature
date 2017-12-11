//
//  TPDSubscribeRouteController.m
//  TopjetPicking
//
//  Created by lish on 2017/8/29.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//订阅路线

#import "TPDSubscribeRouteController.h"
#import "NSObject+CurrentController.h"
#import "TPBaseTableView.h"
#import "TPDSubscribeRouteDataSource.h"
#import "TPDSubscribeRouteViewModel.h"
#import "UIImage+Gradient.h"
#import "TPDSubscribeRouteDataManager.h"
#import "TPDSubscribeRouteViewModel.h"
#import "TPDSubscribeRouteListView.h"
#import "TPDSubscribeRouteEntry.h"
@interface TPDSubscribeRouteController ()<TPBaseTableViewDelegate,TPDSubscribeRouteListViewDelegate>

@property (nonatomic , strong) TPDSubscribeRouteListView *subscribeRoutelistView;

@property (nonatomic , strong) TPDSubscribeRouteViewModel *viewModel;

@property (nonatomic , strong) TPDSubscribeRouteDataManager *dataManager;

@end

@implementation TPDSubscribeRouteController
+ (void)load {
    
    [TPDSubscribeRouteEntry registerSubscribeRouteList];
}

#pragma mark - Life Cycle
- (void)viewWillAppear:(BOOL)animated {
    
     [super viewWillAppear:animated];
     [self requestSubcribrRouteListAPI];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = TPWhiteColor;
    self.navigationItem.title = @"订阅路线";
    [self addRightItem];
    [self addSubviews];
    [self setFrame];
}

#pragma mark - request methods
//请求订阅路线列表
- (void)requestSubcribrRouteListAPI {
    
    [self.dataManager requestSubscribeRouteListAPIWithCompleteBlock:^(BOOL success, id  _Nonnull goodsListResponseObject, NSString * _Nullable goodsCount, TPBusinessError * _Nullable error) {
        if (success) {
            [self.viewModel blindViewModel:goodsListResponseObject allBadge:goodsCount];
            [self.subscribeRoutelistView blindViewModel:self.viewModel];
           
        }else{
            TPShowToast(error.business_msg);
        }
         [self updateNavigationItemStatus];
    }];
}
//删除订阅路线
- (void)requestDeleteSubcribrRouteAPI {
    
    [self.dataManager requestDeleteSubscribeRouteAPIWithRouteList:self.viewModel.deleteSubscribeRouteIdArr completeBlock:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success) {
            self.viewModel.is_edit = NO;
            [self requestSubcribrRouteListAPI];
        }else{
            TPShowToast(error.business_msg);
        }
        
    }];
}

#pragma mark - Event Response
//编辑
- (void)tapRightBtn:(UIButton *)btn {
    
    self.viewModel.is_edit = !self.viewModel.is_edit;
    NSString *itemTitle = self.viewModel.is_edit ? @"完成":@"编辑";
    [self.subscribeRoutelistView setBottomBtnTitle:self.viewModel.is_edit ? @"删除":@"添加订阅路线"];
    [btn setTitle:itemTitle forState:UIControlStateNormal];
    [self.subscribeRoutelistView reloadData];
}
//点击底部btn
- (void)tapBottomBtn{
    
    if (self.viewModel.is_edit) {
        //编辑状态 - 删除操作
        [self requestDeleteSubcribrRouteAPI];
    }else{
        [self addSubscribeRoute];
    }
}
//添加订阅路线
- (void)addSubscribeRoute  {

    [TPRouterAnalytic openInteriorURL:TPRouter_AddSubscribeRoute_Controller parameter:@{} type:PUSHCONTROLLERTYPE_PUSH];
}
//点击全部的订阅路线->货源列表
- (void)tapAllSubcribeRoute {
       [TPRouterAnalytic openInteriorURL:TPRouter_SubscribeRouteGoodsList_Controller parameter:@{@"subscribeRouteId":@"0"} type:PUSHCONTROLLERTYPE_PUSH];
    
}
//更新NavigationItem状态
- (void)updateNavigationItemStatus {
    
   self.navigationItem.rightBarButtonItem.customView.hidden = self.viewModel.subscribeRouteCellModelArr.count == 0 ? YES:NO;
}
#pragma mark - Custom Delegate
- (void)didSelectObject:(TPDSubscribeRouteCellViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    
        //编辑
    if (self.viewModel.is_edit == YES) {
        [self.viewModel deleteObject:object atIndexPath:indexPath];
        [self.subscribeRoutelistView reloadData];
    }else{
        //进入货源列表详情
        [TPRouterAnalytic openInteriorURL:TPRouter_SubscribeRouteGoodsList_Controller parameter:@{
                                                                                                  @"subscribeRouteId":object.subscribeRouteModel.subscribe_line_id ? : @"",
                                                                                                  @"depart":object.subscribeRouteModel.depart_city ? : @"",
                                                                                                  @"destination":object.subscribeRouteModel.destination_city ? : @"",
                                                                                                  } type:PUSHCONTROLLERTYPE_PUSH];
        
    }
    
}

#pragma mark - Getters and Setters
- (TPDSubscribeRouteListView *)subscribeRoutelistView {
    
    if (!_subscribeRoutelistView) {
        _subscribeRoutelistView = [[TPDSubscribeRouteListView alloc]init];
        _subscribeRoutelistView.delegate = self;
        @weakify(self);
        _subscribeRoutelistView.tapBottomBlock = ^{
            @strongify(self);
            [self tapBottomBtn];
        };
        _subscribeRoutelistView.noResultBlock = ^{
            @strongify(self);
            [self addSubscribeRoute];
        };
        _subscribeRoutelistView.tapAllSubscribeRouteBLock = ^{
             @strongify(self);
            [self tapAllSubcribeRoute];
        };
    }
    return _subscribeRoutelistView;
    
}

- (TPDSubscribeRouteDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDSubscribeRouteDataManager alloc]init];
    }
    return _dataManager;
    
}
- (TPDSubscribeRouteViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel  = [[TPDSubscribeRouteViewModel alloc]init];
    }
    return _viewModel;
}

#pragma mark - custom UI
- (void)addSubviews {
    
    [self.view addSubview:self.subscribeRoutelistView];
}
- (void)setFrame {
    
    [_subscribeRoutelistView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
}
- (void)addRightItem {
    
    UIButton *rightBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBt setTitle:@"编辑" forState:UIControlStateNormal];
    rightBt.titleLabel.font = TPAdaptedFontSize(14);
    rightBt.titleLabel.textAlignment = NSTextAlignmentRight;
    rightBt.frame = CGRectMake(0, 0, TPAdaptedWidth(40), TPAdaptedHeight(18));
    [rightBt addTarget:self action:@selector(tapRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBt];
    [rightBt setTitleColor:UIColorHex(030303) forState:0];
    rightBt.titleLabel.textAlignment = NSTextAlignmentRight;
}
@end
