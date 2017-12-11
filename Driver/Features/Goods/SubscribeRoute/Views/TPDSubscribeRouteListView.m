//
//  TPDSubscribeRouteListView.m
//  TopjetPicking
//
//  Created by lish on 2017/9/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteListView.h"
#import "TPDAllSubscribeRouteView.h"
#import "TPBaseTableView.h"
#import "TPDSubscribeRouteDataSource.h"
#import "UIImage+Gradient.h"
@interface TPDSubscribeRouteListView()<TPBaseTableViewDelegate>

@property (nonatomic , strong) TPDAllSubscribeRouteView *allSubscribeRouteView;
@property (nonatomic , strong) TPBaseTableView *tableView;
@property (nonatomic , strong) UIButton *bottomBtn;

@property (nonatomic , strong) TPDSubscribeRouteDataSource *dataSource;

@property (nonatomic , strong) NSMutableArray *deleteSubscribeRouteArr;
@property (nonatomic , strong) NSMutableArray *deleteSubscribeRouteCellModelArr;
@end

@implementation TPDSubscribeRouteListView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
        [self setFrame];
    }
    return self;
    
}
- (void)addSubviews {

    [self addSubview:self.tableView];
    [self addSubview:self.bottomBtn];
   
}
- (void)setFrame {

    [_bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.mas_offset(TPScreenWidth);
        make.height.mas_offset(TPAdaptedHeight(45));
        make.bottom.equalTo(self);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(_bottomBtn.mas_top);
    }];
    
}
//更新布局
- (void)updateFrame {
    if (self.bottomBtn.hidden) {
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
        }];
    }else{
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bottomBtn.mas_top);
        }];
    }
    [self layoutIfNeeded];
}
- (void)reloadData {
    
    [self.tableView reloadDataSource];
}
- (void)blindViewModel:(TPDSubscribeRouteViewModel *)viewModel {

    [self.dataSource clearAllItems];
    [self.dataSource appendItems:viewModel.subscribeRouteCellModelArr];
    [self.tableView reloadDataSource];
    self.allSubscribeRouteView.badge = viewModel.allBadge;
    self.bottomBtn.hidden = viewModel.subscribeRouteCellModelArr.count == 0 ? YES:NO;
    self.allSubscribeRouteView.hidden = self.bottomBtn.hidden;
    [self updateFrame];
    [self setBottomBtnTitle:@"添加订阅路线"];
    [self.tableView stopRefreshingAnimation];
}

#pragma mark - Event Response
- (void)tapBottomBtn {
    
    if (self.tapBottomBlock) {
        self.tapBottomBlock();
    }
    
}
- (void)noResultViewActionHandler {
    
    if (self.noResultBlock) {
        self.noResultBlock();
    }
    
}
- (void)tapAllSubscribeRoute {
    if (self.tapAllSubscribeRouteBLock) {
        self.tapAllSubscribeRouteBLock();
    }
}
#pragma mark - Custom Delegate
- (void)didSelectObject:(TPDSubscribeRouteCellViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(didSelectObject:atIndexPath:)]) {
        [self.delegate didSelectObject:object atIndexPath:indexPath];
    }    
}

- (CGFloat)headerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
  
    return TPAdaptedHeight(48);
}
- (UIView *)headerViewForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
    return self.allSubscribeRouteView;
}
- (void)setBottomBtnTitle:(NSString *)title {
    
    [_bottomBtn setTitle:title forState:0];
}
#pragma mark - Getters and Setters
- (TPDAllSubscribeRouteView *)allSubscribeRouteView {
    
    if (!_allSubscribeRouteView) {
        _allSubscribeRouteView = [[TPDAllSubscribeRouteView alloc]init];
        _allSubscribeRouteView.hidden = YES;
        @weakify(self);
        _allSubscribeRouteView.tapAllSubscribeRouteView = ^{
            @strongify(self);
            [self tapAllSubscribeRoute];
        };
    }
    return _allSubscribeRouteView;
}
- (TPBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
        _tableView.bounces = NO;
    }
    return _tableView;
}
- (TPDSubscribeRouteDataSource *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [[TPDSubscribeRouteDataSource alloc]init];
    }
    return _dataSource;
}
- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setTitle:@"添加订阅路线" forState:0];
        [_bottomBtn setTitleColor:TPWhiteColor forState:0];
        [_bottomBtn setBackgroundImage:[UIImage createGradientImageWithSize:CGSizeMake(TPScreenWidth, TPAdaptedHeight(45)) startColor:TPGradientStartColor endColor:TPGradientEndColor] forState:0];
        [_bottomBtn addTarget:self action:@selector(tapBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomBtn;
}

@end
