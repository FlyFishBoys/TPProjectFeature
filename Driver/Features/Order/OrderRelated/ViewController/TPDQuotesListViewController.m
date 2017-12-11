//
//  TPDQuotesListViewController.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDQuotesListViewController.h"
#import "TPBaseTableView.h"
#import "TPDQuotesListDataSource.h"
#import "NSObject+CurrentController.h"
#import "TPDQuotesListViewModel.h"
#import "TPDQuotesListCell.h"
#import "UIImage+Gradient.h"
#import "TPDReceiveOrderView.h"
#import "TPDQuotesListModel.h"
#import "TPUserServices.h"
#import "TPDOrderRouterEntry.h"
#import "TPAlertView.h"
#import "TPBaseTableViewSectionObject.h"


@interface TPDQuotesListViewController ()<TPBaseTableViewDelegate,TPDQuotesListCellDelegate>
@property (nonatomic, strong) TPBaseTableView * tableView;
@property (nonatomic, strong) TPDQuotesListDataSource * dataSource;
@property (nonatomic,strong) UIView * bottomView;
@property (nonatomic,strong) UIButton * selectAllButton;
@property (nonatomic,strong) UIButton * revokedQuotesButton;
@property (nonatomic, strong) NSMutableArray <TPDQuotesListItemViewModel *> * selectedItemViewModels;
@property (nonatomic, strong) NSMutableArray <TPDQuotesListItemViewModel *> * itemViewModels;

@end

@implementation TPDQuotesListViewController

+ (void)load {
    
    [TPDOrderRouterEntry regisetrQuotesList];
}

#pragma mark - lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的报价";
    [self ql_setupSubviews];
    [self.tableView triggerRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - TPDQuotesListCellDelegate
/**
 点击了选中按钮

 @param quotesListCell 报价cell
 @param isSelected 是否选择
 */
- (void)quotesListCell:(TPDQuotesListCell *)quotesListCell isSelected:(BOOL)isSelected itemViewModel:(TPDQuotesListItemViewModel *)itemViewModel {
    if (isSelected) {
        [self.selectedItemViewModels addObject:itemViewModel];
        itemViewModel.isSelected = YES;
    } else {
        [self.selectedItemViewModels removeObject:itemViewModel];
        itemViewModel.isSelected = NO;
    }
    self.revokedQuotesButton.enabled = self.selectedItemViewModels.count;
    self.revokedQuotesButton.selected = self.selectedItemViewModels.count;
    self.selectAllButton.selected = self.selectedItemViewModels.count == self.dataSource.count;
}

/**
 支付/修改定金

 @param quotesListCell 报价cell
 */
- (void)didClickPayDepositWithQuotesListCell:(TPDQuotesListCell *)quotesListCell {
    
    TPDQuotesListItemViewModel * itemViewModel = (TPDQuotesListItemViewModel *)quotesListCell.object;
    TPDQuotesListModel * model = itemViewModel.model;

    TPDReceiveOrderViewModel * receiveOrderViewModel = [[TPDReceiveOrderViewModel alloc]init];
    receiveOrderViewModel.payViewType = WalletPayViewType_ModifyOffer;
    receiveOrderViewModel.depositFee = model.deposit_fee;
    receiveOrderViewModel.quotesFee = model.transport_fee;
    receiveOrderViewModel.goods_id = model.pre_goods_id;
    receiveOrderViewModel.goods_version = model.pre_goods_version;


    [TPDReceiveOrderView showViewWithModel:receiveOrderViewModel fromController:self requestBlock:^(BOOL isQuotesSuccess, BOOL isRequestSuccess) {
        if (isQuotesSuccess) {
            [self pullDownToRefreshAction];
        }
    } payResultBlock:^(BOOL success, NSString *resultMessage) {
       
       //支付回调
        
    }];
    
}

#pragma mark - TPBaseTableViewDelegate
- (void)didSelectObject:(TPDQuotesListItemViewModel *)object atIndexPath:(NSIndexPath *)indexPath {

    [TPRouterAnalytic openInteriorURL:TPRouter_GoodsDetail_Controller parameter:@{@"goodsId":object.model.goods_id ? : @""} type:PUSHCONTROLLERTYPE_PUSH];
}

- (void)pullDownToRefreshAction {
    @weakify(self);
    [self.dataSource refreshQuotesListWithCompleteBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];
        if (error == nil && succeed) {
            TPBaseTableViewSectionObject * section = self.dataSource.sections.firstObject;
            self.itemViewModels = [section.items mutableCopy];
            [self.selectedItemViewModels removeAllObjects];
            [self.tableView reloadDataSource];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)pullUpToRefreshAction {
    
    @weakify(self);
    [self.dataSource loadMoreQuotesListWithCompleteBlock:^(BOOL succeed, TPBusinessError * _Nullable error, NSInteger listCount) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];
        if (error == nil && succeed) {
            if (listCount) {
                TPBaseTableViewSectionObject * section = self.dataSource.sections.firstObject;
                self.itemViewModels = [section.items mutableCopy];
                [self.tableView reloadDataSource];
            } else {
                TPShowToast(@"已加载全部数据！");
            }
            
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

#pragma mark - Events
//全选
- (void)selectAllButtonAction:(UIButton *)button {
    button.selected = !button.selected;
    if (button.selected) {
        self.selectedItemViewModels = [self.itemViewModels mutableCopy];
        
        [self.itemViewModels enumerateObjectsUsingBlock:^(TPDQuotesListItemViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = YES;
        }];
        [self.tableView reloadDataSource];
        
    } else {
        [self.selectedItemViewModels removeAllObjects];
        [self.itemViewModels enumerateObjectsUsingBlock:^(TPDQuotesListItemViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isSelected = NO;
        }];
        [self.tableView reloadDataSource];
    }
    
    self.revokedQuotesButton.enabled = self.selectedItemViewModels.count;
    self.revokedQuotesButton.selected = self.selectedItemViewModels.count;
    
}

//撤销报价
- (void)revokedQuotesWithQuotesIds:(NSArray *)quotesIds {
    @weakify(self);
    void(^handler)(BOOL success,TPBusinessError * error) = ^(BOOL success,TPBusinessError * error){
        @strongify(self);
        if (success) {
            [self pullDownToRefreshAction];
        } else {
            TPShowToast(error.business_msg);
        }
    };

    [TPRouterAnalytic openInteriorURL:TPRouter_Goods_Operating_Revoked_Quotes parameter:@{
                                                                                         @"quotesIds" : quotesIds,
                                                                                         MGJRouterParameterCompletion : handler
                                                                                         } completeBlock:^(id result) {
                                                                                             
                                                                                         }];
    
}

//撤销报价弹框
- (void)showRevokedQuotesAlert {
    
    @weakify(self);
    TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"您确定要撤销报价吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alertView.cancelButtonAction = ^{
        @strongify(self);
        __block NSMutableArray * quotesIds = [NSMutableArray array];
        [self.selectedItemViewModels enumerateObjectsUsingBlock:^(TPDQuotesListItemViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [quotesIds addObject:obj.model.goods_id];
        }];
        [self revokedQuotesWithQuotesIds:quotesIds];
    };
    
    [alertView show];
}

#pragma mark - Privates
- (void)ql_setupSubviews {
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.selectAllButton];
    [self.bottomView addSubview:self.revokedQuotesButton];

    [self ql_setupConstraints];
}

- (void)ql_setupConstraints {
    
    [self.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.selectAllButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.bottomView);
        make.width.mas_equalTo(TPAdaptedWidth(80));
    }];
    
    [self.revokedQuotesButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.bottomView);
        make.width.mas_equalTo(TPAdaptedWidth(110));
    }];
    
}

#pragma mark - Setters and Getters
- (TPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] init];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.isNeedPullDownToRefreshAction = YES;
        _tableView.isNeedPullUpToRefreshAction = YES;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
    }
    return _tableView;
}

- (TPDQuotesListDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TPDQuotesListDataSource alloc] initWithTarget:self];
    }
    return _dataSource;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor = TPWhiteColor;
    }
    return _bottomView;
}

- (UIButton *)selectAllButton {
    if (!_selectAllButton) {
        _selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAllButton setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_normal"] forState:UIControlStateNormal];
        [_selectAllButton setImage:[UIImage imageNamed:@"certification_vehiclecertification_colorplate_box_selected"] forState:UIControlStateSelected];
        _selectAllButton.adjustsImageWhenHighlighted = NO;
        [_selectAllButton setTitle:@"  全选" forState:UIControlStateNormal];
        [_selectAllButton setTitleColor:TPTitleTextColor forState:UIControlStateNormal];
        _selectAllButton.titleLabel.font = TPAdaptedFontSize(15);
        [_selectAllButton addTarget:self action:@selector(selectAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllButton;
}

- (UIButton *)revokedQuotesButton {
    if (!_revokedQuotesButton) {
        _revokedQuotesButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _revokedQuotesButton.adjustsImageWhenHighlighted = NO;
        [_revokedQuotesButton setTitle:@"撤销报价" forState:UIControlStateNormal];
        [_revokedQuotesButton setTitleColor:TPWhiteColor forState:UIControlStateNormal];
        _revokedQuotesButton.titleLabel.font = TPAdaptedFontSize(17);
        [_revokedQuotesButton addTarget:self action:@selector(showRevokedQuotesAlert) forControlEvents:UIControlEventTouchUpInside];
        _revokedQuotesButton.enabled = NO;
        _revokedQuotesButton.backgroundColor = TPPlaceholderColor;
        UIImage * imageSelected = [UIImage createGradientImageWithSize:CGSizeMake(TPAdaptedWidth(110), TPAdaptedWidth(44)) startColor:UIColorHex(FF5E5E) endColor:UIColorHex(FF573B)];
        UIImage * imageNormal = [UIImage createGradientImageWithSize:CGSizeMake(TPAdaptedWidth(110), TPAdaptedWidth(44)) startColor:UIColorHex(CCCCCC) endColor:UIColorHex(CCCCCC)];
        [_revokedQuotesButton setBackgroundImage:imageSelected forState:UIControlStateSelected];
        [_revokedQuotesButton setBackgroundImage:imageNormal forState:UIControlStateNormal];
        _revokedQuotesButton.adjustsImageWhenHighlighted = NO;
    }
    return _revokedQuotesButton;
}

- (NSMutableArray<TPDQuotesListItemViewModel *> *)selectedItemViewModels {
    if (!_selectedItemViewModels) {
        _selectedItemViewModels = [[NSMutableArray alloc]init];
    }
    return _selectedItemViewModels;
}

- (NSMutableArray<TPDQuotesListItemViewModel *> *)itemViewModels {
    if (!_itemViewModels) {
        _itemViewModels = [[NSMutableArray alloc]init];
    }
    return _itemViewModels;
}

@end
