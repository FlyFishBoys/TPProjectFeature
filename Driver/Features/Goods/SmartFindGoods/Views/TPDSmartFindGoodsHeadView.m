//
//  TPDSmartFindGoodsHeadView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSmartFindGoodsHeadView.h"
#import "UIButton+ResetContent.h"
#import "TPLocationServices.h"
#import "TPCitySelectView.h"
#import "TPCityAdressService.h"

#import "UIView+Gradient.h"
static NSString * const TPDSmartFindGoodsHeadView_Button_Image = @"smart_find_goods_arrows_down_nor";
static NSString * const TPDSmartFindGoodsHeadView_Button_Image_Selsected = @"smart_find_goods_arrows_up_highlight";
@interface TPDSmartFindGoodsHeadView()

@property (nonatomic , strong) UIButton *fromBtn;//开始
@property (nonatomic , strong) UIButton *arriveBtn;//到达
@property (nonatomic , strong) UIButton *vehicleStandardBtn;//车行车长
@property (nonatomic , strong) UIButton *subscribeBtn;//订阅
@property (nonatomic , strong) UILabel *badgeLabel;//角标

@property (nonatomic , strong) UIView *firstLine;
@property (nonatomic , strong) UIView *secondLine;
@property (nonatomic , strong) UIView *thirdLine;

@property (nonatomic , strong) UIView *grayBg;
@property (nonatomic , strong) NSMutableArray <NSNumber *>*selectItems;
@property (nonatomic , strong) TPFilterView *filter ;
@end

@implementation TPDSmartFindGoodsHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPWhiteColor;
        _selectItems = [NSMutableArray array];
        [self addSubviews];
    }
    return self;
}

- (void)addSubviews {
    
    [self addSubview:self.fromBtn];
    [self addSubview:self.arriveBtn];
    [self addSubview:self.vehicleStandardBtn];
    [self addSubview:self.subscribeBtn];
    [self addSubview:self.firstLine];
    [self addSubview:self.secondLine];
    [self addSubview:self.thirdLine];
    [self addSubview:self.badgeLabel];
    [self addSubview:self.grayBg];
    
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    [_fromBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-8));
        make.width.mas_equalTo(TPAdaptedWidth(102));
        
    }];
    
    [_firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_fromBtn.mas_right);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(TPAdaptedHeight(16));
        make.centerY.equalTo(self.fromBtn);
        
    }];
    
    [_arriveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_firstLine.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.fromBtn);
        make.width.mas_equalTo(TPAdaptedWidth(102));
        
    }];
    [_secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_arriveBtn.mas_right);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(TPAdaptedHeight(16));
        make.centerY.equalTo(self.fromBtn);
        
    }];
    [_vehicleStandardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_secondLine.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.fromBtn);
        make.width.mas_equalTo(TPAdaptedWidth(90));
        
    }];
    [_thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_vehicleStandardBtn.mas_right);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(TPAdaptedHeight(16));
        make.centerY.equalTo(self.fromBtn);
        
    }];
    
    [_subscribeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_thirdLine.mas_right);
        make.top.equalTo(self);
        make.bottom.equalTo(self.fromBtn);
        make.right.equalTo(self);
    }];
    
    [_badgeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(TPAdaptedHeight(3));
        make.right.equalTo(self).offset(TPAdaptedWidth(-6));
        make.width.mas_equalTo(TPAdaptedWidth(16));
        make.height.mas_equalTo(TPAdaptedWidth(16));
        
    }];
    
    [_grayBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.height.mas_equalTo(TPAdaptedHeight(8));
        make.bottom.equalTo(self.mas_bottom);
        make.right.equalTo(self);
        
    }];
    
    [_fromBtn horizontalCenterTitleAndImage];
    [_arriveBtn horizontalCenterTitleAndImage];
    [_vehicleStandardBtn horizontalCenterTitleAndImage];
    [_subscribeBtn horizontalCenterTitleAndImage];
}

#pragma mark - Event Response
- (void)tapFromBtn:(UIButton *)tapFromBtn {
   
    tapFromBtn.selected = !tapFromBtn.selected;
    @weakify(self);
    [TPCitySelectView citySelectViewWithType:SELECTVIEW_Cloab_ALL_AREA block:^(TPAddressModel *selectCityModel) {
        @strongify(self);
        
        [tapFromBtn setTitle:[TPCityAdressService dealLastAddressWithAddressModel:selectCityModel] forState:0];
        
        if (self.tapFromAdressBtnBlock) {
            self.tapFromAdressBtnBlock(selectCityModel);
        }
        [self.fromBtn setTitleColor:TPTitleTextColor forState:0];
        
        [self.fromBtn horizontalCenterTitleAndImage];
        
    }dismissBlock:^{
       self.fromBtn.selected = NO;
    }];
}

- (void)tapArriveBtn:(UIButton *)tapArriveBtn {
 
    tapArriveBtn.selected = !tapArriveBtn.selected;
    [TPCitySelectView citySelectViewWithType:SELECTVIEW_Cloab_ALL_AREA block:^(TPAddressModel *selectCityModel) {
    
         [tapArriveBtn setTitle:[TPCityAdressService dealLastAddressWithAddressModel:selectCityModel] forState:0];
        if (self.tapReceiveAdressBtnBlock) {
            self.tapReceiveAdressBtnBlock(selectCityModel);
        }
       
        [self.arriveBtn setTitleColor:TPTitleTextColor forState:0];
        [_arriveBtn horizontalCenterTitleAndImage];
      
    }dismissBlock:^{
         tapArriveBtn.selected = NO;
    }];

}
- (void)removeFilterView {
    
    [_filter disMissFilterView];
}
- (void)tapVehicleStandardBtn:(UIButton *)tapVehicleStandardBtn {
   
    tapVehicleStandardBtn.selected = !tapVehicleStandardBtn.selected;
    tapVehicleStandardBtn.userInteractionEnabled = NO;
    _filter = [TPFilterView initWithShowRentType:NO title:@""];
    _filter.trucktypeNumber = 0;
    _filter.trucklengthNumber = 0;
    _filter.didSelectItems = self.selectItems;
    @weakify(self);
    [_filter showFilterViewInWindowWithCollectionViewTop:self.bottom handleComplete:^(NSArray<TrucklengthModel *> *trucklength, NSArray<TrucktypeModel *> *trucktype, NSInteger rentType, NSArray<NSArray<NSNumber *> *> *selectItems) {
        @strongify(self);
        if (self.tapVehicleStandardBtnBlock) {
            self.tapVehicleStandardBtnBlock(trucklength, trucktype);
        }
        self.selectItems = selectItems.mutableCopy;
    } filterDismiss:^{
         tapVehicleStandardBtn.selected = NO;
         tapVehicleStandardBtn.userInteractionEnabled = YES;
    }];

}
- (void)tapSubscribeBtn:(UIButton *)tapSubscribeBtn {
   
    if (self.tapSubscribeBtnBlock) {
        self.tapSubscribeBtnBlock();
    }
}
#pragma mark - Getters and Setters
- (UIButton *)fromBtn {
    
    if (!_fromBtn) {
        _fromBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_fromBtn setTitleColor:TPTitleTextColor forState:UIControlStateSelected];
        [_fromBtn setTitleColor:TPMainTextColor forState:0];
        [_fromBtn setImage:[UIImage imageNamed:TPDSmartFindGoodsHeadView_Button_Image] forState:0];
        [_fromBtn setImage:[UIImage imageNamed:TPDSmartFindGoodsHeadView_Button_Image_Selsected] forState:UIControlStateSelected];
        [_fromBtn addTarget:self action:@selector(tapFromBtn:) forControlEvents:UIControlEventTouchUpInside];
        _fromBtn.titleLabel.font = TPSystemFontSize(14);
        [_fromBtn setTitle:@"出发" forState:0];
    }
    return _fromBtn;
}
- (UIButton *)arriveBtn {
    
    if (!_arriveBtn) {
        _arriveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_arriveBtn setTitleColor:TPTitleTextColor forState:UIControlStateSelected];
        [_arriveBtn setTitleColor:TPMainTextColor forState:0];
        [_arriveBtn setImage:[UIImage imageNamed:TPDSmartFindGoodsHeadView_Button_Image] forState:0];
          [_arriveBtn setImage:[UIImage imageNamed:TPDSmartFindGoodsHeadView_Button_Image_Selsected] forState:UIControlStateSelected];
        [_arriveBtn addTarget:self action:@selector(tapArriveBtn:) forControlEvents:UIControlEventTouchUpInside];
         [_arriveBtn setTitle:@"到达" forState:0];
         _arriveBtn.titleLabel.font = TPSystemFontSize(14);
    }
    return _arriveBtn;
}
- (UIButton *)vehicleStandardBtn {
    
    if (!_vehicleStandardBtn) {
        _vehicleStandardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vehicleStandardBtn setTitleColor:TPMainColor forState:UIControlStateSelected];
        [_vehicleStandardBtn setTitleColor:TPTitleTextColor forState:0];
        [_vehicleStandardBtn setImage:[UIImage imageNamed:TPDSmartFindGoodsHeadView_Button_Image] forState:0];
         [_vehicleStandardBtn setImage:[UIImage imageNamed:TPDSmartFindGoodsHeadView_Button_Image_Selsected] forState:UIControlStateSelected];
        [_vehicleStandardBtn addTarget:self action:@selector(tapVehicleStandardBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_vehicleStandardBtn setTitle:@"车型车长" forState:0];
        
        _vehicleStandardBtn.titleLabel.font = TPSystemFontSize(14);
    }
    return _vehicleStandardBtn;
}
- (UIButton *)subscribeBtn {
    
    if (!_subscribeBtn) {
        _subscribeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subscribeBtn setTitleColor:TPTitleTextColor forState:0];
        [_subscribeBtn setTitleColor:TPMainColor forState:UIControlStateSelected];
        [_subscribeBtn setImage:[UIImage imageNamed:TPDSmartFindGoodsHeadView_Button_Image] forState:0];
        [_subscribeBtn addTarget:self action:@selector(tapSubscribeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_subscribeBtn setTitle:@"订阅" forState:0];
        _subscribeBtn.titleLabel.font = TPSystemFontSize(14);
    }
    return _subscribeBtn;
}
- (UILabel *)badgeLabel {
    if (!_badgeLabel) {
        _badgeLabel = [[UILabel alloc]init];
        _badgeLabel.backgroundColor = [UIColor clearColor];
        _badgeLabel.font = TPSystemFontSize(10);
        _badgeLabel.textColor = TPWhiteColor;
        _badgeLabel.layer.cornerRadius = (TPAdaptedWidth(16)) /2;
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _badgeLabel;
}

- (UIView *)firstLine {
    if (!_firstLine) {
        _firstLine = [[UIView alloc]init];
        _firstLine.backgroundColor = TPMinorTextColor;
    }
    return _firstLine;
}
- (UIView *)secondLine {
    if (!_secondLine) {
        _secondLine = [[UIView alloc]init];
        _secondLine.backgroundColor = TPMinorTextColor;
    }
    return _secondLine;
}
- (UIView *)thirdLine {
    if (!_thirdLine) {
        _thirdLine = [[UIView alloc]init];
        _thirdLine.backgroundColor = TPMinorTextColor;
    }
    return _thirdLine;
}

- (UIView *)grayBg {
    if (!_grayBg) {
        _grayBg = [[UIView alloc]init];
        _grayBg.backgroundColor = TPBackgroundColor;
    }
    return _grayBg;
}
- (void)setBadgeNum:(NSString *)badgeNum {
    
    _badgeNum = badgeNum;
  
    if ([_badgeNum isNotBlank] && ![_badgeNum isEqualToString:@"0"]) {
        _badgeLabel.backgroundColor  = UIColorHex(#FF0000);
        _badgeLabel.hidden = NO;
    }else{
        _badgeLabel.hidden = YES;
    }
    _badgeLabel.textColor = TPWhiteColor;
    _badgeLabel.text = _badgeNum;
 
}

- (void)setLocationCityAddress:(NSString *)locationCityAddress {
    if ([locationCityAddress isNotBlank]) {
        _locationCityAddress = locationCityAddress;
        [self.fromBtn setTitle:locationCityAddress forState:0];
        [self.fromBtn setTitleColor:TPTitleTextColor forState:0];
        self.fromBtn.selected = NO;
        [_fromBtn horizontalCenterTitleAndImage];
    }
 
}

@end
