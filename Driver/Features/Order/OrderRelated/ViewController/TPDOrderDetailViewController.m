//
//  TPDOrderDetailViewController.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDOrderDetailViewController.h"
#import "NSObject+CurrentController.h"
#import "TPTipsView.h"
#import "TPSenderReceiverInfoView.h"
#import "TPNormalRefreshGifHeader.h"
#import "UIImageView+TPWebCache.h"
#import "TPOrderBottomButtonsView.h"
#import "TPDOrderDefines.h"
#import "TPDropdownMenu.h"
#import "TPDOrderDetailViewModel.h"
#import "TPDOrderDetailModel.h"
#import "TPProgressView.h"
#import "TPOrderFreightView.h"
#import "TPOrderDepositView.h"
#import "TPDOrderDetailDataManager.h"
#import "TPOrerDetailExpandView.h"
#import "TPDOrderDetailShipperInfoView.h"
#import "TPOrerDetailFreightViewModel.h"
#import "TPOrerDetailExpandViewModel.h"
#import "TPDEnterCodeView.h"
#import "TPAlertView.h"
#import "TPDOrderRouterEntry.h"
#import "TPDropdownMenuModel.h"
#import "TPUserServices.h"
#import "TPCallCenter.h"
#import "TPUserServices.h"
#import "TPShareManager.h"

@interface TPDOrderDetailViewController ()<TPDropdownMenuDelegate,TPOrderBottomButtonsViewDelegate,TPOrerDetailExpandViewDelegate,TPOrderFreightViewDelegate>

@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) TPTipsView * tipsView;
@property (nonatomic, strong) TPProgressView * progressView;
@property (nonatomic, strong) TPDOrderDetailShipperInfoView * shipperInfoView;
@property (nonatomic, strong) TPSenderReceiverInfoView * receiverInfoView;
@property (nonatomic, strong) TPSenderReceiverInfoView * senderInfoView;
@property (nonatomic, strong) TPOrderFreightView * freightView;
@property (nonatomic, strong) TPOrderDepositView * depositView;
@property (nonatomic, strong) TPOrderBottomButtonsView * bottomButtonsView;
@property (nonatomic, strong) TPDOrderDetailViewModel * viewModel;
@property (nonatomic, strong) TPDropdownMenu * dropdownMenu;
@property (nonatomic, strong) TPOrerDetailExpandView * expandView;
@property (nonatomic, strong) TPDOrderDetailDataManager * dataManager;
@property (nonatomic, assign) BOOL isAddSubviews;

@end

@implementation TPDOrderDetailViewController

+ (void)load {
    
    [TPDOrderRouterEntry registerOrderDetail];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.title = @"订单详情";
    [self  od_loadOrderDetail];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scrollView.mj_header beginRefreshing];
}

#pragma mark - TPDropdownMenuDelegate
//点击了下拉菜单
- (void)dropdownMenu:(TPDropdownMenu *)menu selectedCellIndexType:(NSInteger)indexType {
    switch (indexType) {
        case TPDOrderDetailDropdownMenuType_ShareGoods:
        {
            [TPShareManager shareGoodsWithGoodsIds:@[self.viewModel.model.goods_id] ownerId:self.viewModel.model.owner_info.owner_id shareCompletion:nil];
        }
            break;
            
        case TPDOrderDetailDropdownMenuType_RefundDetail:
        {
            [self od_goToRrefund];
        }
            break;
            
        case TPDOrderDetailDropdownMenuType_ViewContract:
        {
            [self od_viewContract];
        }
            break;
            
        case TPDOrderDetailDropdownMenuType_RefundByMyself:
        {
            [self od_goToRrefund];
        }
            break;
            
        case TPDOrderDetailDropdownMenuType_omplainByMyself:
        {
            @TODO("我要投诉");
             [self od_complain];
        }
            break;
    }
}

#pragma mark - TPOrderBottomButtonsViewDelegate
- (void)didClickOrderBottomButtonsView:(TPOrderBottomButtonsView *)orderBottomButtonsView buttonType:(NSInteger)buttonType {
    switch (buttonType) {
        case TPDOrderDetailButtonType_GiveUpTake:
        {
            [self od_cancelDeal];
        }
            break;

        case TPDOrderDetailButtonType_ToTake:
        {
             [self od_confirmDeal];
        }
            break;

        case TPDOrderDetailButtonType_ConfirmPickUp:
        {
            [self od_confirmPickUp];
        }
            break;
        case TPDOrderDetailButtonType_MapNavigation:
        {
            [self od_mapNavigation];
        }
            break;

        case TPDOrderDetailButtonType_ConfirmSignUp:
        {
            [self od_goodsSignIn];
        }
            break;

        case TPDOrderDetailButtonType_Evaluation:
        {
            [self od_evaluation];
        }
            break;
        case TPDOrderDetailButtonType_ViewEvaluation:
        {
            [self od_viewEvaluation];
        }
            break;

        case TPDOrderDetailButtonType_Share:
        {
            [TPShareManager shareGoodsWithGoodsIds:@[self.viewModel.model.goods_id] ownerId:TPCurrentUser.user_id shareCompletion:nil];
        }
            break;
    }
}

#pragma mark - TPOrderFreightViewDelegate
- (void)orderFreightView:(TPOrderFreightView *)orderFreightView isExpand:(BOOL)isExpand {
    if (isExpand) {
        [self.freightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.viewModel.freightViewModel.freightExpandHeight);
        }];
        [self.scrollView layoutIfNeeded];
        [self.scrollView scrollToBottom];
    } else {
        [self.freightView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.viewModel.freightViewModel.freightHeight);
        }];
    }
}

#pragma mark - TPOrerDetailExpandViewDelegate
- (void)orerDetailExpandView:(TPOrerDetailExpandView *)orerDetailExpandView isExpand:(BOOL)isExpand {
    if (isExpand) {
        [self.expandView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.viewModel.expandViewModel.height);
        }];
        [self.scrollView layoutIfNeeded];
        [self.scrollView scrollToBottom];
    } else {
        [self.expandView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(TPAdaptedHeight(48));
        }];
    }
}

#pragma mark - Events
- (void)od_pullDownToRefreshAction {
    
    @weakify(self);
    [self.dataManager requestGoodsDetailWithOrderId:self.orderId completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, TPDOrderDetailModel *  _Nullable model) {
        @strongify(self);
        [self.scrollView.mj_header endRefreshing];
        if (succeed) {
            self.viewModel  = [[TPDOrderDetailViewModel alloc]initWithModel:model];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

//导航条右按钮点击事件
- (void)od_rightBarButtonItemAction:(UIBarButtonItem *)button {
    if (self.viewModel.dropdownMenuModels.count > 1) {
        [self.dropdownMenu showDropDown];
    } else if (self.viewModel.dropdownMenuModels.count > 0) {
        if (button.tag == TPDOrderDetailNavRightButtonType_ViewContract) {
            [self od_viewContract];
        } else if (button.tag == TPDOrderDetailNavRightButtonType_ViewContract) {
            [TPShareManager shareGoodsWithGoodsIds:@[self.viewModel.model.goods_id] ownerId:self.viewModel.model.owner_info.owner_id shareCompletion:nil];
        }
    }
}

#pragma mark - Privates
- (void)od_loadOrderDetail {
    TPShowLoading;
    @weakify(self);
    [self.dataManager requestGoodsDetailWithOrderId:self.orderId completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error, TPDOrderDetailModel *  _Nullable model) {
        @strongify(self);
        TPHiddenLoading;
        if (succeed) {
            [self od_setupSubviews];
            self.viewModel  = [[TPDOrderDetailViewModel alloc]initWithModel:model];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

//确认签收
- (void)od_goodsSignIn {
    NSString * callTitle = self.viewModel.model.receiver_info.mobile.isNotBlank ? @"呼叫收货人" : @"呼叫货主";
    NSString * mobile = self.viewModel.model.receiver_info.mobile.isNotBlank ? self.viewModel.model.receiver_info.mobile : self.viewModel.model.owner_info.owner_mobile;
    NSString * name = self.viewModel.model.receiver_info.name.isNotBlank ? self.viewModel.model.receiver_info.name : self.viewModel.model.owner_info.owner_name;
    TPDEnterCodeView * codeView = [[TPDEnterCodeView alloc]initWithCode:nil name:name moblie:mobile title:@"请输入签收码" callTitle:callTitle];
    @weakify(self);
    codeView.completeBlock = ^(TPDEnterCodeView *view, NSString *code) {
        @strongify(self);
        [self.dataManager goodsSignUpWithOrderId:self.viewModel.model.order_id orderVersion:self.viewModel.model.order_version unloadCode:code completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
            if (succeed) {
                [self od_pullDownToRefreshAction];
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };
    
    codeView.callBlock = ^{
        [[TPCallCenter shareInstance]recordWithCalledUserMobile:mobile userName:self.viewModel.model.owner_info.owner_name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:self.viewModel.model.goods_id goodsStatus:nil callUpRecordBlock:nil];
    };
    [codeView show];
    
}

//确认提货
- (void)od_confirmPickUp {
    
    NSString * callTitle = self.viewModel.model.sender_info.mobile.isNotBlank ? @"呼叫发货人" : @"呼叫货主";
    NSString * mobile = self.viewModel.model.sender_info.mobile.isNotBlank ? self.viewModel.model.sender_info.mobile : self.viewModel.model.owner_info.owner_mobile;
    NSString * name = self.viewModel.model.sender_info.name.isNotBlank ? self.viewModel.model.sender_info.name : self.viewModel.model.owner_info.owner_mobile;
    TPDEnterCodeView * codeView = [[TPDEnterCodeView alloc]initWithCode:self.viewModel.model.pickup_code  name:name moblie:mobile title:@"请输入提货码" callTitle:callTitle];
    @weakify(self);
    codeView.completeBlock = ^(TPDEnterCodeView *view, NSString *code) {
        @strongify(self);
        [self.dataManager confirmPickUpWithOrderId:self.viewModel.model.order_id orderVersion:self.viewModel.model.order_version pickupCode:code completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
            if (succeed) {
                [TPHUD showAlertViewWithText:@"提货成功，配送途中注意安全哦" handler:^{
                    @strongify(self);
                    [self od_pullDownToRefreshAction];
                }];
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };
    
    codeView.callBlock = ^{
        [[TPCallCenter shareInstance]recordWithCalledUserMobile:mobile userName:self.viewModel.model.owner_info.owner_name callupBtnTitle:@"呼叫货主" advertTipType:AdvertTipType_SupplyOfGoods goodsId:self.viewModel.model.goods_id goodsStatus:nil callUpRecordBlock:nil];
    };
    [codeView show];
}

//确认承接
- (void)od_confirmDeal {
    @weakify(self);
    void(^tapAgree)(void)= ^{
        @strongify(self);
        [self.dataManager confirmDealWithOrderId:self.viewModel.model.order_id orderVersion:self.viewModel.model.order_version completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
            @strongify(self);
            if (succeed) {
                [self od_pullDownToRefreshAction];
            } else {
                TPShowToast(error.business_msg);
            }
        }];
    };
    [TPRouterAnalytic openInteriorURL:TPRouter_Contract_Controller parameter:@{@"viewType" : @"1",
                                                                              @"goodsId" : self.viewModel.model.goods_id ? : @"",
                                                                               MGJRouterParameterCompletion:tapAgree} type:PUSHCONTROLLERTYPE_PUSH];
    
    
}


//放弃承接
- (void)od_cancelDeal {
    [self.dataManager cancelDealWithOrderId:self.viewModel.model.order_id orderVersion:self.viewModel.model.order_version completeBlock:^(BOOL succeed, TPBusinessError * _Nullable error) {
        if (succeed) {
            [self od_pullDownToRefreshAction];
        } else {
            TPShowToast(error.business_msg);
        }
    }];
}

//查看合同
- (void)od_viewContract {

    [TPRouterAnalytic openInteriorURL:TPRouter_Contract_Controller parameter: @{
                                                                               @"viewType" : @"2",
                                                                               @"goodsId" : self.viewModel.model.goods_id.isNotBlank ? self.viewModel.model.goods_id : @""
                                                                               } type:PUSHCONTROLLERTYPE_PUSH];
}

//去退款相关的页面
- (void)od_goToRrefund {
    [TPRouterAnalytic openInteriorURL:TPRouter_Refund_Controller parameter: @{
                                                                              @"orderParamter":@{
                                                                                      @"order_id" : self.viewModel.model.order_id.isNotBlank ? self.viewModel.model.order_id : @"",
                                                                                      @"order_status" : self.viewModel.model.order_status.isNotBlank ? self.viewModel.model.order_status : @"",
                                                                                      @"version" : self.viewModel.model.order_version.isNotBlank ? self.viewModel.model.order_version : @"",
                                                                                      @"trigger_id" : [TPUserServices currentUserModel].user_id .isNotBlank ? [TPUserServices currentUserModel].user_id : @"",
                                                                                      @"freight":self.viewModel.model.freight?[self.viewModel.model.freight yy_modelToJSONObject]:@{},
                                                                                      @"refund_info" : self.viewModel.model.refund_info ? [self.viewModel.model.refund_info yy_modelToJSONObject]:@{},
                                                                                      }
                                                                              } type:PUSHCONTROLLERTYPE_PUSH];
  
}

//评价
- (void)od_evaluation {
   
    
    UIViewController *vc = [TPRouterAnalytic interiorObjectForURL:TPRouter_Evaluate parameter:@{@"parameter":
                                                                                                    @{
                                                                                                        @"order_id":self.viewModel.model.order_id.isNotBlank ? self.viewModel.model.order_id : @"",
                                                                                                        @"version":self.viewModel.model.order_version.isNotBlank ? self.viewModel.model.order_version : @"",
                                                                                                        @"commented_user":self.viewModel.model.owner_info.owner_id.isNotBlank ? self.viewModel.model.owner_info.owner_id : @"",
                                                                                                        @"commented_name":self.viewModel.model.owner_info.owner_name.isNotBlank ? self.viewModel.model.owner_info.owner_name : @"",
                                                                                                        },
                                                                                                @"loadURL":TPWEB_URL_Evaluate
                                                                                                }];
    [self cyl_pushViewController:vc animated:YES];

}

//查看评价
- (void)od_viewEvaluation {

    
    UIViewController *vc =[TPRouterAnalytic interiorObjectForURL:TPRouter_Evaluate parameter:@{@"parameter":
                                                                                                        @{
                                                                                                            @"order_id":self.viewModel.model.order_id.isNotBlank ? self.viewModel.model.order_id : @"",
                                                                                                            @"version":self.viewModel.model.order_version.isNotBlank ? self.viewModel.model.order_version : @"",
                                                                                                            },
                                                                                                    @"loadURL":TPWEB_URL_ExamineEvaluate
                                                                                                    }];
    [self cyl_pushViewController:vc animated:YES];
}

//我要投诉
- (void)od_complain {
    
    UIViewController *vc = [TPRouterAnalytic interiorObjectForURL:TPRouter_Evaluate parameter:@{@"parameter":
                                                                                                    @{@"order_id":self.viewModel.model.order_id.isNotBlank ? self.viewModel.model.order_id : @"",@"version":self.viewModel.model.order_version.isNotBlank ? self.viewModel.model.order_version : @"",},
                                                                                                @"loadURL":TPWEB_URL_Complain}];
    [self cyl_pushViewController:vc animated:YES];
    
}

//地图导航
- (void)od_mapNavigation {
    TPSenderReceiverModel * model = self.viewModel.model.sender_info;
    NSString * pickupStatus = @"1";
    if (self.viewModel.model.order_status.integerValue > 5) {
        model = self.viewModel.model.receiver_info;
        pickupStatus = @"2";
    }
    [TPRouterAnalytic openInteriorURL:TPRouter_Order_PathPlanning parameter:@{
                                                                             @"latitude":model.latitude ? : @"",
                                                                             @"longitude":model.longitude ? : @"",
                                                                             @"mobile":model.mobile ? : @"",
                                                                             @"pickupStatus":pickupStatus
                                                                             } type:PUSHCONTROLLERTYPE_PUSH];
}

- (void)od_setupSubviews {
    if (self.isAddSubviews) return;
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.bottomButtonsView];
    [self.scrollView addSubview:self.tipsView];
    [self.scrollView addSubview:self.progressView];
    [self.scrollView addSubview:self.shipperInfoView];
    [self.scrollView addSubview:self.freightView];
    [self.scrollView addSubview:self.depositView];
    [self.scrollView addSubview:self.senderInfoView];
    [self.scrollView addSubview:self.receiverInfoView];
    [self.scrollView addSubview:self.expandView];
    
    self.isAddSubviews = YES;
    [self  od_setupConstraints];
}

//设置导航条
- (void)od_setupNavigationBar {
    
    if (self.viewModel.dropdownMenuModels.count > 1) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"order_detail_navigationbutton_more"] style:UIBarButtonItemStylePlain target:self action:@selector(od_rightBarButtonItemAction:)];
        self.dropdownMenu.modelArray = self.viewModel.dropdownMenuModels;
    } else if (self.viewModel.dropdownMenuModels.count > 0) {
        TPDropdownMenuModel * dropdownMenuModel = self.viewModel.dropdownMenuModels.firstObject;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:dropdownMenuModel.title style:UIBarButtonItemStylePlain target:self action:@selector(od_rightBarButtonItemAction:)];
        self.navigationItem.rightBarButtonItem.tag = dropdownMenuModel.indexType;

    }
}

- (void) od_setupConstraints {
    [self.bottomButtonsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomButtonsView.mas_top);
    }];
    
    [self.tipsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(40));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipsView.mas_bottom);
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.height.mas_equalTo(TPAdaptedHeight(60));
    }];
    
    [self.shipperInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.progressView.mas_bottom).offset(TPAdaptedHeight(8));
        make.height.mas_equalTo(TPAdaptedHeight(80));
    }];
    
    [self.senderInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.shipperInfoView.mas_bottom).offset(TPAdaptedHeight(8));
        make.height.mas_equalTo(TPAdaptedHeight(72));
    }];
    
    [self.receiverInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.senderInfoView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(72));
    }];
    
    [self.freightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.receiverInfoView.mas_bottom).offset(TPAdaptedHeight(8));
        make.height.mas_equalTo(TPAdaptedHeight(52));
    }];
    
    [self.depositView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.equalTo(self.scrollView);
        make.top.equalTo(self.freightView.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(52));
    }];
    
    [self.expandView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(0);
        make.width.bottom.equalTo(self.scrollView);
        make.top.equalTo(self.depositView.mas_bottom).offset(TPAdaptedHeight(8));
        make.height.mas_equalTo(TPAdaptedHeight(48));
    }];
}

#pragma mark - Setters and Getters
- (void)setViewModel:(TPDOrderDetailViewModel *)viewModel {
    _viewModel = viewModel;
    
    self.tipsView.contentString = viewModel.tips;
    self.progressView.highlightedIndex = viewModel.progressHighlightedIndex;
    self.shipperInfoView.viewModel = viewModel.shipperViewModel;
    self.senderInfoView.viewModel = viewModel.senderViewModel;
    self.receiverInfoView.viewModel = viewModel.receiverViewModel;
    self.freightView.viewModel = viewModel.freightViewModel;
    self.depositView.depositTitle = viewModel.depositTitle;
    self.depositView.depositPayStatus = viewModel.depositPayStatus;
    self.depositView.depositFee = viewModel.deposit;
    self.expandView.viewModel = viewModel.expandViewModel;
    self.bottomButtonsView.buttonModels = viewModel.buttonModels;
    [self od_setupNavigationBar];

    [self.tipsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.tipsHeight);
    }];
    
    [self.freightView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.freightViewModel.freightHeight);
    }];
    
    [self.expandView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(TPAdaptedHeight(48));
    }];
    
    [self.depositView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(viewModel.depositHeight);
    }];
}

- (TPTipsView *)tipsView {
    if (!_tipsView) {
        _tipsView = [[TPTipsView alloc]initWithContentString:@""];
        _tipsView.clipsToBounds = YES;
    }
    return _tipsView;
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

- (TPOrderBottomButtonsView *)bottomButtonsView {
    if (!_bottomButtonsView) {
        _bottomButtonsView = [[TPOrderBottomButtonsView alloc]init];
        _bottomButtonsView.delegate = self;
    }
    return _bottomButtonsView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.mj_header = [TPNormalRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector( od_pullDownToRefreshAction)];
    }
    return _scrollView;
}

- (TPProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[TPProgressView alloc]initWithSelectedImageName:@"order_detail_progress_selected" defaultImageName:@"order_detail_progress_normal" highlightedImageName:@"order_detail_progress_highlighted" isBottomLine:NO margin:TPAdaptedWidth(34)];
        _progressView.titleArray = @[@"已承接",@"运费托管",@"已提货",@"已签收"];
        _progressView.highlightedColor = UIColorHex(FFB000);
    }
    return _progressView;
}

- (TPDOrderDetailShipperInfoView *)shipperInfoView {
    if (!_shipperInfoView) {
        _shipperInfoView = [[TPDOrderDetailShipperInfoView alloc]init];
    }
    return _shipperInfoView;
}



- (TPOrderFreightView *)freightView {
    if (!_freightView) {
        _freightView = [[TPOrderFreightView alloc]init];
        _freightView.clipsToBounds = YES;
        _freightView.delegate = self;
    }
    return _freightView;
}

- (TPOrderDepositView *)depositView {
    if (!_depositView) {
        _depositView = [[TPOrderDepositView alloc]init];
        _depositView.clipsToBounds = YES;
    }
    return _depositView;
}

- (TPOrerDetailExpandView *)expandView {
    if (!_expandView) {
        _expandView = [[TPOrerDetailExpandView alloc]init];
        _expandView.clipsToBounds = YES;
        _expandView.delegate = self;
    }
    return _expandView;
}

- (TPDropdownMenu *)dropdownMenu {
    if (!_dropdownMenu) {
        _dropdownMenu = [[TPDropdownMenu alloc] initWithShowViewFrame:CGRectMake(kScreenWidth - 32 - 20, 20, 32, 44)];
        _dropdownMenu.delegate = self;
    }
    return _dropdownMenu;
}

- (TPDOrderDetailDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDOrderDetailDataManager alloc] init];
    }
    return _dataManager;
}

@end
