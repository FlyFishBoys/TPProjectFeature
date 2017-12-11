//
//  TPDCallRecordsViewController.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCallRecordsViewController.h"
#import "TPBaseTableView.h"
#import "TPDCallRecordsDataSource.h"
#import "TPAlertView.h"
#import "TPDCallRecordsCell.h"
#import "TPDCallRecordsViewModel.h"
#import "TPCallCenter.h"

@interface TPDCallRecordsViewController () <TPBaseTableViewDelegate>

@property (nonatomic,strong) TPBaseTableView * tableView;

@property (nonatomic,strong) TPDCallRecordsDataSource * dataSource;

@end

@implementation TPDCallRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPBackgroundColor;
    
    self.navigationItem.title = @"通话记录";
    
    [self.view addSubview:self.tableView];
    
    [self layoutPageSubviews];
    
    [self.tableView triggerRefreshing];
    
}
#pragma mark - event
- (void)cleanRecords {
    @weakify(self);
    TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"确定要清空吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertView.otherButtonAction = ^{
        @strongify(self);
        [self.dataSource clearAllCallRecordsWithHandler:^(BOOL success, TPBusinessError *error) {
            if (success) {
                [self.tableView reloadDataSource];
                [self setupNavBar];
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };
    [alertView show];
}
- (void)didClickCallOnCell:(TPDCallRecordsCell *)cell {
    TPDCallRecordsItemViewModel *vm = (TPDCallRecordsItemViewModel *)cell.object;
    [[TPCallCenter shareInstance] recordWithCalledUserMobile:vm.mobile
                                                    userName:vm.name
                                              callupBtnTitle:@"呼叫货主"
                                               advertTipType:AdvertTipType_SupplyOfGoods
                                                     goodsId:vm.goods_id
                                                 goodsStatus:vm.goods_status
                                           callUpRecordBlock:nil];
}

- (void)didClickChatOnCell:(TPDCallRecordsCell *)cell {
    @TODO("IM聊天系统");
}
#pragma mark - TPBaseTableViewDelegate
- (void)pullDownToRefreshAction {
    @weakify(self);
    [self.dataSource fetchCallRecordsListDataWithHandler:^(BOOL success, TPBusinessError *error) {
        [self.tableView stopRefreshingAnimation];
        @strongify(self);
        if (success && !error) {
            [self.tableView reloadDataSource];
            [self setupNavBar];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)pullUpToRefreshAction {
    @weakify(self);
    [self.dataSource loadNextPageHandler:^(BOOL success, TPBusinessError *error) {
        [self.tableView stopRefreshingAnimation];
        @strongify(self);
        if (success && !error) {
            [self.tableView reloadDataSource];
            [self setupNavBar];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}
- (void)didSelectObject:(TPDCallRecordsItemViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    [self.dataSource fetchGoodsStatusWithGoodsId:object.goods_id Handler:^(BOOL shouldOperation) {
        if (shouldOperation) {
         
            [TPRouterAnalytic openInteriorURL:TPRouter_GoodsDetail_Controller parameter:@{@"goodsId":object.goods_id ? : @""} type:PUSHCONTROLLERTYPE_PUSH];

        } else {
            TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"很可惜，该订单已成交或撤销" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
            [alertView show];
        }
    }];
}
#pragma mark - UI
- (void)setupNavBar {
    if (self.dataSource.sections.count > 0) {
     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"清空" style:UIBarButtonItemStylePlain target:self action:@selector(cleanRecords)];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}
- (void)layoutPageSubviews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (TPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] init];
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
        _tableView.isNeedPullUpToRefreshAction = YES;
        _tableView.isNeedPullDownToRefreshAction = YES;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (TPDCallRecordsDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TPDCallRecordsDataSource alloc] init];
        _dataSource.target = self;
    }
    return _dataSource;
}
@end
