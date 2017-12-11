//
//  TPDGoodsDetailViewController.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/29.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsDetailViewController.h"
#import "NSObject+CurrentController.h"
#import "TPTipsView.h"
#import "TPOrderSerialView.h"
#import "TPSenderReceiverInfoView.h"
#import "TPOrderMapView.h"
#import "TPNormalRefreshGifHeader.h"
#import "TPOrderGoodsInfoView.h"
#import "TPOrderRemarksView.h"
#import "TPDOrderDetailShipperInfoView.h"
#import "TPOrderBottomButtonsView.h"
#import "TPQuotesAmountView.h"
#import "TPDGoodsDetailDataManager.h"
#import "TPDGoodsDetailModel.h"
#import "TPDGoodsDetailViewModel.h"
#import "TPDReceiveOrderView.h"
#import "TPUserServices.h"
#import "TPDGoodsRouterEntry.h"
#import "TPUserServices.h"
#import "TPShareManager.h"

@interface TPDGoodsDetailViewController ()<TPOrderBottomButtonsViewDelegate>
@property (nonatomic, strong) TPTipsView * tipsView;
@property (nonatomic, strong) TPOrderSerialView * serialView;
@property (nonatomic, strong) TPSenderReceiverInfoView * receiverInfoView;
@property (nonatomic, strong) TPSenderReceiverInfoView * senderInfoView;
@property (nonatomic, strong) TPOrderMapView * mapView;
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) TPOrderGoodsInfoView * goodsInfoView;
@property (nonatomic, strong) TPOrderRemarksView * remarksView;
@property (nonatomic, strong) TPDOrderDetailShipperInfoView * contactCell;
@property (nonatomic, strong) TPOrderBottomButtonsView * bottomButtonsView;
@property (nonatomic, strong) TPQuotesAmountView * quotesAmountView;
@property (nonatomic, strong) TPDGoodsDetailViewModel * viewModel;
@property (nonatomic, strong) TPDGoodsDetailDataManager * dataManager;
@property (nonatomic, assign) BOOL isAddSubviews;

@end

@implementation TPDGoodsDetailViewController

+ (void)load {
    [TPDGoodsRouterEntry registerGoodsDetail];
}

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"货源详情";
    self.view.backgroundColor = TPBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享货源" style:UIBarButtonItemStylePlain target:self action:@selector(gd_rightBarButtonItemAction)];
    [self gd_loadGoodsDetail];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scrollView.mj_header beginRefreshing];
}

#pragma mark TPOrderBottomButtonsViewDelegate
- (void)didClickOrderBottomButtonsView:(TPOrderBottomButtonsView *)orderBottomButtonsView buttonType:(NSInteger)buttonType {
    switch (buttonType) {
        case TPDGoodsDetailButtonType_TakeOrder:
        {
            [self pd_PayDepositWithType:WalletPayViewType_PayOffer];
        }
            break;
            
        case TPDGoodsDetailButtonType_RevokedQuotes:
        {
            [self gd_revokedQuotes];
        }
            break;
            
        case TPDGoodsDetailButtonType_ModifyQuotes:
        {
            [self pd_PayDepositWithType:WalletPayViewType_ModifyOffer];
        }
            break;
    }
}



#pragma mark - Events
- (void)gd_pullDownToRefreshAction {
    
    @weakify(self);
    [self.dataManager requestGoodsDetailWithGoodsId:self.goodId completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, id  _Nullable model) {
        @strongify(self);
        [self.scrollView.mj_header endRefreshing];
        if (succeed) {
            self.viewModel  = [[TPDGoodsDetailViewModel alloc]initWithModel:model];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

//分享货源
- (void)gd_rightBarButtonItemAction {
    
    [TPShareManager shareGoodsWithGoodsIds:@[self.viewModel.model.goods_id] ownerId:self.viewModel.model.owner_info.owner_id shareCompletion:nil];
}

#pragma mark - Privates
- (void)gd_loadGoodsDetail {
    TPShowLoading;
    @weakify(self);
    [self.dataManager requestGoodsDetailWithGoodsId:self.goodId completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, id  _Nullable model) {
        TPHiddenLoading;
        @strongify(self);
        if (succeed) {
            [self gd_setupSubviews];
            self.viewModel  = [[TPDGoodsDetailViewModel alloc]initWithModel:model];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

/**
 接单/修改报价
 
 @param type 类型
 */
- (void)pd_PayDepositWithType:(WalletPayViewType)type {
    
    TPDReceiveOrderViewModel * receiveOrderViewModel = [[TPDReceiveOrderViewModel alloc]init];
    if (self.viewModel.model.pre_goods_id.isNotBlank) {
        receiveOrderViewModel.payViewType = WalletPayViewType_ModifyOffer;
        receiveOrderViewModel.depositFee = self.viewModel.model.deposit_fee;
        receiveOrderViewModel.quotesFee = self.viewModel.model.transport_fee;
        receiveOrderViewModel.goods_id = self.viewModel.model.pre_goods_id;
        receiveOrderViewModel.goods_version = self.viewModel.model.pre_goods_version;
    } else {
        receiveOrderViewModel.payViewType = WalletPayViewType_PayOffer;
        receiveOrderViewModel.goods_id = self.viewModel.model.goods_id;
        receiveOrderViewModel.goods_version = self.viewModel.model.goods_version;
    }
    
    [TPDReceiveOrderView showViewWithModel:receiveOrderViewModel fromController:self requestBlock:^(BOOL isQuotesSuccess, BOOL isRequestSuccess) {
        if (isQuotesSuccess) {
            [self gd_pullDownToRefreshAction];
        }
    } payResultBlock:^(BOOL success, NSString *resultMessage) {
       //支付回调
    }];
}

//撤销报价
- (void)gd_revokedQuotes {
    @weakify(self);
    void(^handler)(BOOL success,TPBusinessError * error) = ^(BOOL success,TPBusinessError * error){
        @strongify(self);
        if (success) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            TPShowToast(error.business_msg);
        }
    };
    [TPRouterAnalytic openInteriorURL:TPRouter_Goods_Operating_Revoked_Quotes parameter:@{
                                                                                         @"quotesIds" : @[self.viewModel.model.pre_goods_id],
                                                                                         MGJRouterParameterCompletion : handler
                                                                                         }
                        completeBlock:nil];
}

- (void)gd_checkPath {
    [TPRouterAnalytic openInteriorURL:TPRouter_Order_CheckPath parameter:@{
                                                                          @"startLatitude":self.viewModel.model.sender_info.latitude ? : @"",
                                                                          @"startLongitude":self.viewModel.model.sender_info.longitude ? : @"",
                                                                          @"endLatitude":self.viewModel.model.receiver_info.latitude ? : @"",
                                                                          @"endLongitude":self.viewModel.model.receiver_info.longitude ? : @""
                                                                          } type:PUSHCONTROLLERTYPE_PUSH];

}

- (void)gd_setupSubviews {
    if (self.isAddSubviews) return;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomButtonsView];
    [self.view addSubview:self.quotesAmountView];
    [self.scrollView addSubview:self.tipsView];
    [self.scrollView addSubview:self.serialView];
    [self.scrollView addSubview:self.senderInfoView];
    [self.scrollView addSubview:self.receiverInfoView];
    [self.scrollView addSubview:self.mapView];
    [self.scrollView addSubview:self.goodsInfoView];
    [self.scrollView addSubview:self.remarksView];
    [self.scrollView addSubview:self.contactCell];

    self.isAddSubviews = YES;
    [self gd_setupConstraints];
}

- (void)gd_setupConstraints {
    [self.bottomButtonsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.quotesAmountView.mas_top);
    }];
    
    [self.tipsView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(40));
    }];
    
    [self.serialView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.tipsView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(40));
    }];
    
    [self.senderInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.serialView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(72));
    }];
    
    [self.receiverInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.senderInfoView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(72));
    }];
    
    [self.goodsInfoView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.mapView.mas_bottom).offset(TPAdaptedHeight(8));
        make.height.mas_equalTo(self.viewModel.goodsInfoHeight);
    }];
    
    [self.remarksView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.goodsInfoView.mas_bottom).offset(TPAdaptedHeight(8));
        make.height.mas_equalTo(0);
    }];
    
    [self.mapView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.receiverInfoView.mas_bottom);
        make.height.mas_equalTo(0);
    }];
    
    [self.contactCell mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.bottom.equalTo(self.scrollView);
        make.top.equalTo(self.remarksView.mas_bottom).offset(TPAdaptedHeight(8));
        make.height.mas_equalTo(0);
    }];
    
    [self.quotesAmountView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.bottomButtonsView.mas_top);
        make.height.mas_equalTo(0);
    }];
    
}

#pragma mark - Setters and Getters
- (void)setViewModel:(TPDGoodsDetailViewModel *)viewModel {
    _viewModel = viewModel;
    self.tipsView.contentString = viewModel.tips;
    self.tipsView.rightAttributedString = viewModel.tipsRightAttributed;
    self.serialView.serial = viewModel.orderSerial;
    self.serialView.createTime = viewModel.orderTime;
    self.senderInfoView.viewModel = viewModel.senderViewModel;
    self.receiverInfoView.viewModel = viewModel.receiverViewModel;
    self.goodsInfoView.goodsMessage = viewModel.goodsInfo;
    self.remarksView.text = viewModel.remarkText;
    self.bottomButtonsView.buttonModels = viewModel.buttonModels;
    self.quotesAmountView.attributedText = viewModel.quotesAmountAttributed;
    
    [self.remarksView.imageView tp_setSizeToFitImageWithURL:[NSURL URLWithString:viewModel.model.remark_img_url] md5Key:viewModel.model.remark_img_key placeholderImage:[UIImage imageNamed:@""] roundCornerRadius:4];
    
    [self.goodsInfoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.goodsInfoHeight);
    }];
    
    [self.remarksView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.remarkHeight);
    }];
    
    [self.remarksView.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(viewModel.remarkImageHeight);
    }];
    
    [self.mapView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.distanceHeight);
    }];
    
    [self.contactCell mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.shipperInfoHeight);
    }];
    
    [self.quotesAmountView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.quotesHeight);
    }];
}

- (TPTipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [[TPTipsView alloc]initWithContentString:@""];
        _tipsView.rightButtonHandle = ^{
        };
    }
    return _tipsView;
}

- (TPOrderSerialView *)serialView {
    if (!_serialView) {
        _serialView = [[TPOrderSerialView alloc]init];
    }
    return _serialView;
}

- (TPSenderReceiverInfoView *)senderInfoView {
    if (!_senderInfoView) {
        _senderInfoView = [[TPSenderReceiverInfoView alloc]initWithHasSeparateLine:YES currentType:TPSenderReceiverInfoView_Sender];
    }
    return _senderInfoView;
}

- (TPSenderReceiverInfoView *)receiverInfoView {
    if (!_receiverInfoView) {
        _receiverInfoView = [[TPSenderReceiverInfoView alloc]initWithHasSeparateLine:NO currentType:TPSenderReceiverInfoView_Receiver];
    }
    return _receiverInfoView;
}

- (TPOrderMapView *)mapView {
    if (!_mapView) {
        _mapView = [[TPOrderMapView alloc]init];
        _mapView.clipsToBounds = YES;
        _mapView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gd_checkPath)];
        [_mapView addGestureRecognizer:tap];
    }
    return _mapView;
}

- (TPOrderGoodsInfoView *)goodsInfoView {
    if (!_goodsInfoView) {
        _goodsInfoView = [[TPOrderGoodsInfoView alloc]init];
        _goodsInfoView.clipsToBounds = YES;
    }
    return _goodsInfoView;
}

- (TPOrderRemarksView *)remarksView {
    if (!_remarksView) {
        _remarksView = [[TPOrderRemarksView alloc]init];
        _remarksView.clipsToBounds = YES;
    }
    return _remarksView;
}

- (TPDOrderDetailShipperInfoView *)contactCell {
    if (!_contactCell) {
        _contactCell = [[TPDOrderDetailShipperInfoView alloc]init];
        _contactCell.clipsToBounds = YES;
    }
    return _contactCell;
}

- (TPOrderBottomButtonsView *)bottomButtonsView {
    if (!_bottomButtonsView) {
        _bottomButtonsView = [[TPOrderBottomButtonsView alloc]init];
        _bottomButtonsView.delegate = self;
    }
    return _bottomButtonsView;
}

- (TPQuotesAmountView *)quotesAmountView {
    if (!_quotesAmountView) {
        _quotesAmountView = [[TPQuotesAmountView alloc]init];
        _quotesAmountView.clipsToBounds = YES;
    }
    return _quotesAmountView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.mj_header = [TPNormalRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(gd_pullDownToRefreshAction)];
    }
    return _scrollView;
}

- (TPDGoodsDetailDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDGoodsDetailDataManager alloc] init];
    }
    return _dataManager;
}
@end
