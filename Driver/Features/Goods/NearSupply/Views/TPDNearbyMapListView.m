//
//  TPDNearbyMapListView.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearbyMapListView.h"
#import "TPDNearbyMapListHeaderView.h"
#import "TPBaseTableView.h"
#import "TPDNearbyGoodsDataSource.h"
#import "TPDGoodsViewModel.h"

#import "TPCallCenter.h"

@interface TPDNearbyMapListView () <TPBaseTableViewDelegate>

@property (nonatomic,strong) UIView * contentView;

@property (nonatomic,strong) TPBaseTableView * tableView;

@property (nonatomic,strong) TPDNearbyMapListHeaderView * headerView;

@property (nonatomic,strong) TPDNearbyGoodsDataSource * dataSource;

@property (nonatomic,weak) id target;
@end

@implementation TPDNearbyMapListView

- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.target = target;
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}
- (void)showOnView:(UIView *)view {
    [view addSubview:self];
    self.frame = view.bounds;
    self.contentView.transform = CGAffineTransformMakeTranslation(0, self.height);
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.contentView.transform = CGAffineTransformIdentity;
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.contentView.transform = CGAffineTransformMakeTranslation(0, self.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)addSubviews {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.headerView];
    [self.contentView addSubview:self.tableView];
}
- (void)addConstraints {
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(TPAdaptedHeight(160), 0, 0, 0));
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.top.equalTo(self.headerView.mas_bottom);
    }];
}
- (void)setGoodsArray:(NSArray *)goodsArray {
    _goodsArray = goodsArray;
    self.tableView.isNeedPullUpToRefreshAction = NO;
    self.tableView.isNeedPullDownToRefreshAction = NO;
    self.headerView.titleLable.text = [NSString stringWithFormat:@"（共%ld辆）",goodsArray.count];
    [TPHUD showLoadingHUDOnView:self.contentView];
    @weakify(self);
    [self.dataSource loadStaticalDataWithArray:goodsArray callBack:^(BOOL success, TPBusinessError *error) {
        @strongify(self);
    [TPHUD hiddenLoadingHUDOnView:self.contentView];
        if (success) {
         [self.tableView reloadData];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}
- (void)setRequestParams:(NSDictionary *)requestParams {
    _requestParams = requestParams;
    self.dataSource.requestParams = requestParams;
    self.tableView.isNeedPullUpToRefreshAction = NO;
    self.tableView.isNeedPullDownToRefreshAction = YES;
    [TPHUD showLoadingHUDOnView:self.contentView];
    @weakify(self);
    [self.dataSource fetchDataWithCallBack:^(BOOL success, TPBusinessError *error, NSString *count) {
        @strongify(self);
        [TPHUD hiddenLoadingHUDOnView:self.contentView];
        self.headerView.titleLable.text = [NSString stringWithFormat:@"（共%@辆）",count];
        if (success) {
            [self.tableView reloadDataSource];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}
#pragma mark - event

#pragma mark - TPBaseTableViewDelegate
- (void)didSelectObject:(TPDGoodsViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
//    [TPRouterAnalytic openURLWithPushType:PUSHCONTROLLERTYPE_PUSH urlString:TPRouter_Vehicle_Detail parameter:@{@"driverTruckId" : object.item.driver_truck_id ?: @""}];
    
}
- (void)pullUpToRefreshAction {
    @weakify(self);
    [self.dataSource loadNextPageDataWithCallBack:^(BOOL success, TPBusinessError *error, NSString *count) {
        @strongify(self);
        self.headerView.titleLable.text = [NSString stringWithFormat:@"（共%@辆）",count];
        if (success && !error) {
            [self.tableView reloadDataSource];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.anyObject.view == self) {
        [self dismiss];
    }
}
#pragma mark - getter
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = TPWhiteColor;
    }
    return _contentView;
}
- (TPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] init];
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (TPDNearbyMapListHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TPDNearbyMapListHeaderView alloc] init];
        [_headerView.dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _headerView;
}
- (TPDNearbyGoodsDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TPDNearbyGoodsDataSource alloc] initWithTarget:self.target];
    }
    return _dataSource;
}
@end
