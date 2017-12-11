//
//  TPDFreightAgentView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreightAgentView.h"
#import "TPDFreightAgentCell.h"
#import "TPBaseTableView.h"
#import "TPDFreightAgentDataSource.h"
#import "TPDFreightAgentHeaderView.h"
#import "TPDFreightAgentDataManager.h"
#import "TPDFreightAgentCell.h"
#import "TPCallCenter.h"
@interface TPDFreightAgentView()<TPBaseTableViewDelegate,TPDFreightAgentCellDelegate> {
    
    NSString *_departCode,*_destinationCode;
}

@property (nonatomic , strong) UIView *contentBg;
@property (nonatomic , strong) TPBaseTableView *tableView;
@property (nonatomic , strong) TPDFreightAgentHeaderView *headerView;
@property (nonatomic , strong) TPDFreightAgentDataManager *dataManager;

@end

@implementation TPDFreightAgentView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        [self setFrame];

    }
    return self;
}
- (instancetype)initWithFreightAgentViewDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode {
    
    self = [super init];
    if (self) {
        
        _departCode = departCode;
        _destinationCode = destinationCode;
        [self fetchData];
    }
    return self;
    
}
#pragma mark - request methods
- (void)fetchData {
    
    [self pullDownToRefreshAction];
}
- (void)pullUpToRefreshAction {
    @weakify(self);
    [self.dataManager pullUpFreightAgentListWithDepartCode:_departCode destinationCode:_destinationCode];
    self.dataManager.fetchListComplete = ^{
        @strongify(self);
        [self.tableView reloadDataSource];
        [self.tableView stopRefreshingAnimation];
    };
}

- (void)pullDownToRefreshAction {
     @weakify(self);
    [self.dataManager pullDownFreightAgentListWithDepartCode:_departCode destinationCode:_destinationCode];
    self.dataManager.fetchListComplete = ^{
        @strongify(self);
        [self.tableView reloadDataSource];
          [self.tableView stopRefreshingAnimation];
    };
}
#pragma mark - Custom Delegate
- (void)didClickFreightAgentCellButton:(FreightAgentCellButtonType)type object:(TPDFreightAgrentItemViewModel *)object {
    
    switch (type) {
        case FreightAgentCellButtonType_Call:{
            [[TPCallCenter shareInstance]callupWithCalledUserMobile:object.model.mobile userName:object.model.name  callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods];
            break;
        }
           
            
        case FreightAgentCellButtonType_Message:
            
            break;
    }
    
    
}


#pragma mark - custom UI
- (void)setFrame {

    self.frame = [UIScreen mainScreen].bounds;
    _contentBg.frame = CGRectMake(0, TPAdaptedHeight(222), TPScreenWidth, TPAdaptedHeight(444));
    
    [_headerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_contentBg.mas_top);
        make.height.mas_equalTo(TPAdaptedHeight(44));
        make.left.equalTo(self);
        make.right.equalTo(self);
    }];
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self.contentBg.mas_bottom);
    }];
    
    
}
- (void)addSubviews {

    [self addSubview:self.contentBg];
    [self.contentBg addSubview:self.tableView];
    [self.contentBg addSubview:self.headerView];
    
}

#pragma mark - Public Methods
- (void)show {

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.contentBg.top = TPScreenHeight;
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0/1.0];
    [UIView animateWithDuration:0.3 animations:^{
        self.contentBg.top = TPAdaptedHeight(222);
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4/1.0];
        [self layoutIfNeeded];
    }];
   
}
- (void)close {
    
   
    [UIView animateWithDuration:0.3 animations:^{
        self.contentBg.top = TPScreenHeight;
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0/1.0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
       [self removeFromSuperview];
    }];
   
}

#pragma mark - Getters and Setters
- (TPDFreightAgentDataManager *)dataManager {
    
    if (!_dataManager) {
        _dataManager = [[TPDFreightAgentDataManager alloc]initWithTarget:self];
    }
    return _dataManager;
}
- (TPBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc]init];
        _tableView.backgroundColor = TPWhiteColor;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataManager.dataSource;
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.isNeedPullUpToRefreshAction = YES;
        _tableView.isNeedPullDownToRefreshAction = YES;
    }
    return _tableView;
}
- (UIView *)contentBg {
    
    if (!_contentBg) {
        _contentBg = [[UIView alloc]init];
        _contentBg.backgroundColor = TPWhiteColor;
     
    }
    return _contentBg;
}

- (TPDFreightAgentHeaderView *)headerView {
    
    if (!_headerView) {
        _headerView = [[TPDFreightAgentHeaderView alloc]init];
        @weakify(self);
        _headerView.tapCloseBtnBlock = ^{
            @strongify(self);
            //关闭弹框
            [self close];
        };
    }
    return _headerView;
    
}
@end
