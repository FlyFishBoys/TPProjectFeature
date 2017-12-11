//
//  TPDIntegrityInquiryResultViewController.m
//  Driver
//
//  Created by Mr.mao on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryResultViewController.h"
#import "TPDIntegrityInquiryEntry.h"
#import "TPBaseTableView.h"
#import "TPDIntegrityInquiryResultHeader.h"
#import "UIImage+Gradient.h"
#import "TPDIntegrityInquiryResultDataSource.h"
#import "TPDIntegrityInquiryViewModel.h"
#import "TPDIntegrityInquiryModel.h"
#import "TPCallCenter.h"
#import "TPDIntegrityInquiryGoodsCell.h"
#import "TPNoResultView.h"
#import "TPDReceiveOrderView.h"
#import "TPDIntegrityInquiryGoodsListViewModel.h"
#import "TPDIntegrityInquiryGoodsModel.h"

@interface TPDIntegrityInquiryResultViewController ()<TPBaseTableViewDelegate,TPDIntegrityInquiryGoodsCellDelegate>
@property (nonatomic, strong) TPBaseTableView * tableView;
@property (nonatomic, strong) TPDIntegrityInquiryResultHeader * header;
@property (nonatomic, strong) TPDIntegrityInquiryResultDataSource * dataSource;
@property (nonatomic, strong) UIButton * messageButton;
@property (nonatomic, strong) UIButton * callButton;

@end

@implementation TPDIntegrityInquiryResultViewController

+ (void)load {
    [TPDIntegrityInquiryEntry registerIntegrityInquiryResult];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self ir_setupSubviews];
}

#pragma mark - TPBaseTableViewDelegate
- (void)pullUpToRefreshAction {
    @weakify(self);
    [self.dataSource loadMoreGoodsListWithUserId:self.model.user_id completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, NSInteger listCount) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];
        if (error == nil && succeed) {
            if (listCount) {
                [self.tableView reloadDataSource];
            } else {
                TPShowToast(@"已加载全部数据！");
            }
            
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

- (void)pullDownToRefreshAction {
    @weakify(self);
    [self.dataSource refreshGoodsListWithUserId:self.model.user_id completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        @strongify(self);
        [self.tableView stopRefreshingAnimation];
        if (error == nil && succeed) {
            [self.tableView reloadDataSource];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

#pragma mark - TPDIntegrityInquiryGoodsCellDelegate
- (void)integrityInquiryResultCell:(TPDIntegrityInquiryGoodsCell *)integrityInquiryResultCell didClickButtonWithButtonType:(TPDIntegrityInquiryGoodsCellButtonType)buttonType {
    TPDIntegrityInquiryGoodsListItem * item = (TPDIntegrityInquiryGoodsListItem *)integrityInquiryResultCell.object;
    TPDIntegrityInquiryGoodsModel * model = item.model;
    switch (buttonType) {
        case TPDIntegrityInquiryGoodsCellButtonType_TakeOrder:
            {
                [self ir_PayDepositWithType:WalletPayViewType_PayOffer model:model];
            }
            break;
            
        case TPDIntegrityInquiryGoodsCellButtonType_ModifyQuotes:
        {
            [self ir_PayDepositWithType:WalletPayViewType_ModifyOffer model:model];
        }
            break;
            
        case TPDIntegrityInquiryGoodsCellButtonType_RevokedQuotes:
        {
            [self ir_revokedQuotesWithModel:model];
        }
            break;
    }
}

#pragma mark - Events
- (void)ir_messageButtonEvent {
    @TODO("发私信");
}

- (void)ir_callButtonEvent {
    NSString * title = @"呼叫货主";
    AdvertTipType advertTipType = AdvertTipType_AllocationOfCargo;
    if ([self.model.user_type isEqualToString:@"2"]) {//身份是货主可以查看货主货源
        title = @"呼叫货主";
        advertTipType = AdvertTipType_AllocationOfCargo;
    } else if ([self.model.user_type isEqualToString:@"1"]) {
        title = @"呼叫司机";
        advertTipType = AdvertTipType_SupplyOfGoods;
    }
     [[TPCallCenter shareInstance]recordWithCalledUserMobile:self.model.user_mobile userName:self.model.user_name callupBtnTitle:title advertTipType:advertTipType goodsId:nil goodsStatus:nil callUpRecordBlock:nil];
}

//查看评论
- (void)ir_viewEvaluate {
    UIViewController *vc = [TPRouterAnalytic interiorObjectForURL:TPRouter_Evaluate parameter:@{@"parameter":@{@"user_id":self.model.user_id ? : @""},
                                                                                                @"loadURL":TPWEB_URL_ExamineEvaluate
                                                                                                }];
    
    [self cyl_pushViewController:vc animated:YES];
}

#pragma mark - Privates
/**
 接单/修改报价
 
 @param type 类型
 */
- (void)ir_PayDepositWithType:(WalletPayViewType)type model:(TPDIntegrityInquiryGoodsModel *)model {
    
    TPDReceiveOrderViewModel * receiveOrderViewModel = [[TPDReceiveOrderViewModel alloc]init];
    if (model.pre_goods_id.isNotBlank) {
        receiveOrderViewModel.payViewType = WalletPayViewType_ModifyOffer;
        receiveOrderViewModel.depositFee = model.deposit_fee;
        receiveOrderViewModel.quotesFee = model.transport_fee;
        receiveOrderViewModel.goods_id = model.pre_goods_id;
        receiveOrderViewModel.goods_version = model.pre_goods_version;
    } else {
        receiveOrderViewModel.payViewType = WalletPayViewType_PayOffer;
        receiveOrderViewModel.goods_id = model.goods_id;
        receiveOrderViewModel.goods_version = model.goods_version;
    }
    
    [TPDReceiveOrderView showViewWithModel:receiveOrderViewModel fromController:self requestBlock:^(BOOL isQuotesSuccess, BOOL isRequestSuccess) {
        if (isQuotesSuccess) {
            [self.tableView triggerRefreshing];
        }
    } payResultBlock:^(BOOL success, NSString *resultMessage) {
        if (success) {
            TPShowToast(@"支付成功");
        } else {
            TPShowToast(@"支付失败");
        }
    }];
}

//撤销报价
- (void)ir_revokedQuotesWithModel:(TPDIntegrityInquiryGoodsModel *)model {
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
                                                                                         @"quotesIds" : @[model.pre_goods_id],
                                                                                         MGJRouterParameterCompletion : handler
                                                                                         } completeBlock:nil];
}

- (void)ir_setupSubviews {
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.messageButton];
    [self.view addSubview:self.callButton];

    [self ol_setupConstraints];
}

- (void)ol_setupConstraints {
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.height.mas_equalTo(TPAdaptedHeight(168));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.header.mas_bottom).offset(TPAdaptedHeight(8));
        make.bottom.equalTo(self.view.mas_bottom).offset(TPAdaptedHeight(-44));
    }];
    
    [self.messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(self.view.mas_width).multipliedBy(1 / 2.0);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.callButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.width.equalTo(self.view.mas_width).multipliedBy(1 / 2.0);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
}

#pragma mark - Setters and Getters
- (void)setModel:(TPDIntegrityInquiryModel *)model {
    _model = model;
    self.header.viewModel = [[TPDIntegrityInquiryViewModel alloc] initWithModel:model];
    self.navigationItem.title =  self.header.viewModel.name;

    if ([model.user_type isEqualToString:@"2"]) {//身份是货主可以查看货主货源
        self.tableView.isNeedPullDownToRefreshAction = YES;
        self.tableView.isNeedPullUpToRefreshAction = YES;
        [self.tableView triggerRefreshing];
    }
}

- (TPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] init];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.isNeedPullDownToRefreshAction = NO;
        _tableView.isNeedPullUpToRefreshAction = NO;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
    }
    return _tableView;
}

- (TPDIntegrityInquiryResultHeader *)header {
    if (!_header) {
        _header = [[TPDIntegrityInquiryResultHeader alloc] init];
        _header.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ir_viewEvaluate)];
        [_header addGestureRecognizer:tap];
    }
    return _header;
}

- (TPDIntegrityInquiryResultDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TPDIntegrityInquiryResultDataSource alloc] initWithTarget:self];
    }
    return _dataSource;
}

- (UIButton *)messageButton {
    if (!_messageButton) {
        _messageButton = [[UIButton alloc] init];
        _messageButton.clipsToBounds = YES;
        _messageButton.layer.borderWidth = 0.5;
        _messageButton.titleLabel.font = TPAdaptedFontSize(17);
        _messageButton.layer.borderColor = TPUNEnbleColor_LineColor.CGColor;
        [_messageButton setTitle:@"发私信" forState:UIControlStateNormal];
        [_messageButton setTitleColor:TPMainColor forState:UIControlStateNormal];
        _messageButton.backgroundColor = TPWhiteColor;
        [_messageButton addTarget:self action:@selector(ir_messageButtonEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageButton;
}

- (UIButton *)callButton {
    if (!_callButton) {
        _callButton = [[UIButton alloc] init];
        _callButton.titleLabel.font = TPAdaptedFontSize(17);
        [_callButton setTitle:@"打电话" forState:UIControlStateNormal];
        [_callButton setTitleColor:TPWhiteColor forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(ir_callButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        UIImage * backgroundImage = [UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth / 2.0f, TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor];
        [_callButton setBackgroundImage:backgroundImage forState:UIControlStateNormal];
        _callButton.adjustsImageWhenHighlighted = NO;
    }
    return _callButton;
}
@end
