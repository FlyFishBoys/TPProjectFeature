//
//  TPDAddSubscribeRouteController.m
//  TopjetPicking
//
//  Created by lish on 2017/8/29.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//添加订阅路线

#import "TPDAddSubscribeRouteController.h"
#import "NSObject+CurrentController.h"
#import "TPDAddSubscribeRouteCustomView.h"
#import "UIImage+Gradient.h"
#import "TPDSubscribeRouteDataManager.h"
#import "TPAddressModel.h"
#import "TPLocationServices.h"
#import "TPCitySelectView.h"
#import "TPFilterView.h"
#import "TPDAddSubscribeRouteViewModel.h"
#import "TPDSubscribeRouteEntry.h"
@interface TPDAddSubscribeRouteController ()

@property (nonatomic , strong) TPDAddSubscribeRouteCustomView *departView;//出发地

@property (nonatomic , strong) TPDAddSubscribeRouteCustomView *destinationView;//目的地

@property (nonatomic , strong) TPDAddSubscribeRouteCustomView *vehicleTypeView;//车型车长

@property (nonatomic , strong) UIButton *confirmBtn;//确认按钮

@property (nonatomic , strong) TPDSubscribeRouteDataManager *dataManager;

@property (nonatomic , strong) TPDAddSubscribeRouteViewModel *viewModel;

@property (nonatomic , strong) NSMutableArray <NSNumber *>*selectItems;

@end

@implementation TPDAddSubscribeRouteController
+ (void)load {
   
    [TPDSubscribeRouteEntry registerAddSubscribeRoute];
    
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = TPWhiteColor;
    self.navigationItem.title = @"添加订阅路线";
    self.selectItems = [NSMutableArray array];
    [self location];
    [self addSubviews];
    [self setFrame];
}
#pragma mark - request methods
- (void)requestAddSubscribeRouteAPI {
    
    [self.dataManager requestAddSubscribeRouteAPIWithDepartCode:self.viewModel.departCityCode destinationCityCode:self.viewModel.destintionCityCode truckTypeId:self.viewModel.truckTypeId truckLengthId:self.viewModel.truckLengthId completeBlock:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success) {
            TPShowToast(@"添加成功！");
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            TPShowToast(error.business_msg);
        }
    }];
}

#pragma mark - Event Response
//点击确认添加按钮
- (void)tapConfirmAddBtn {
    [self requestAddSubscribeRouteAPI];
}
//点击出发地view
- (void)tapDepartView {
     @weakify(self);
    [TPCitySelectView citySelectViewWithType:SELECTVIEW_Cloab_ALL_AREA block:^(TPAddressModel *selectCityModel) {
         @strongify(self);
        [self.viewModel blindDepartModel:selectCityModel];
        self.departView.textFieldText =  self.viewModel.departAddress;
    }dismissBlock:^{
        
    }];
}
//点击目的地view
- (void)tapDestinationView {
     @weakify(self);
    [TPCitySelectView citySelectViewWithType:SELECTVIEW_Cloab_ALL_AREA block:^(TPAddressModel *selectCityModel) {
         @strongify(self);
        [self.viewModel blindDestintionModel:selectCityModel];
        self.destinationView.textFieldText =  self.viewModel.destintionAddress;
    }dismissBlock:^{
        
    }];
}
//点击车型车长viw
- (void)tapVehicleTypeLengthView {
    
    TPFilterView *filter = [TPFilterView initWithShowRentType:NO title:@""];
    filter.trucktypeNumber = 0;
    filter.trucklengthNumber = 0;
    filter.didSelectItems = self.selectItems;
    @weakify(self);
    [filter showFilterViewInWindowHandleComplete:^(NSArray<TrucklengthModel *> *trucklength, NSArray<TrucktypeModel *> *trucktype, NSInteger rentType, NSArray<NSArray<NSNumber *> *> *selectItems) {
        @strongify(self);
        if (trucktype.count>0) {
            [self.viewModel blindTruckTypeModel:trucktype[0]];
        }
        if (trucklength.count > 0) {
            [self.viewModel blindTruckLengthModel:trucklength[0]];
        }
        self.selectItems = selectItems.mutableCopy;
        self.vehicleTypeView.textFieldText = self.viewModel.truckLengthType;
    } filterDismiss:^{
        
    }];
}

//定位
- (void)location {
    @weakify(self);
    [[TPLocationServices locationService]requestSingleLocationWithReGeocode:YES completionHandler:^(TPAddressModel *addressModel, NSError *error) {
        @strongify(self);
        if (addressModel && !error) {
            if (![self.viewModel.departCityCode isNotBlank]) {
                [self.viewModel blindDepartModel:addressModel];
                _departView.textFieldText =  [addressModel.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }
        }
    }];
}

#pragma mark - Getters and Setters
- (TPDAddSubscribeRouteCustomView *)departView {
    if (!_departView) {
        _departView = [[TPDAddSubscribeRouteCustomView alloc]init];
        _departView.leftTitle = @"出发地";
        _departView.placeholder = @"请选择";
        @weakify(self);
        _departView.tapBlock = ^{
            @strongify(self);
            [self tapDepartView];
        };
    }
    return _departView;
}
- (TPDAddSubscribeRouteCustomView *)destinationView {
    if (!_destinationView) {
        _destinationView = [[TPDAddSubscribeRouteCustomView alloc]init];
        _destinationView.leftTitle = @"目的地";
        _destinationView.placeholder = @"请选择";
         @weakify(self);
        _destinationView.tapBlock = ^{
             @strongify(self);
            [self tapDestinationView];
        };
    }
    return _destinationView;
}
- (TPDAddSubscribeRouteCustomView *)vehicleTypeView {
    if (!_vehicleTypeView) {
        _vehicleTypeView = [[TPDAddSubscribeRouteCustomView alloc]init];
        _vehicleTypeView.leftTitle = @"车型车长";
        _vehicleTypeView.placeholder = @"不限";
        @weakify(self);
        _vehicleTypeView.tapBlock = ^{
            @strongify(self);
            [self tapVehicleTypeLengthView];
        };
    }
    return _vehicleTypeView;
}
- (UIButton *)confirmBtn {
    
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认添加" forState:0];
        [_confirmBtn setTitleColor:TPWhiteColor forState:0];
        _confirmBtn .layer.cornerRadius = TPAdaptedHeight(20);
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn setBackgroundImage:[UIImage createGradientImageWithSize:CGSizeMake(TPAdaptedWidth(351), TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor] forState:0];
        [_confirmBtn addTarget:self action:@selector(tapConfirmAddBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

- (TPDSubscribeRouteDataManager *)dataManager {
    
    if (!_dataManager) {
        _dataManager = [[TPDSubscribeRouteDataManager alloc]init];
    }
    return _dataManager;
    
}
- (TPDAddSubscribeRouteViewModel *)viewModel {
    
    if (!_viewModel) {
        _viewModel = [[TPDAddSubscribeRouteViewModel alloc]init];
    }
    return _viewModel;
}
#pragma mark - custom UI
- (void)addSubviews {
    
    [self.view addSubview:self.departView];
    [self.view addSubview:self.destinationView];
    [self.view addSubview:self.vehicleTypeView];
    [self.view addSubview:self.confirmBtn];
    
}
- (void)setFrame {
    
    [_departView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(64);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(TPAdaptedHeight(48));
    }];
    
    [_destinationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(TPAdaptedHeight(48));
    }];
    
    [_vehicleTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_destinationView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_offset(TPAdaptedHeight(48));
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(TPAdaptedWidth(351));
        make.height.mas_offset(TPAdaptedHeight(44));
        make.top.equalTo(_vehicleTypeView.mas_bottom).offset(TPAdaptedHeight(16));
        make.centerX.equalTo(self);
    }];
    
}

@end
