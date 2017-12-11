//
//  TPDGoodsFontSettingController.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/9/27.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsFontSettingController.h"
#import "TPDGoodsFontContentView.h"
#import "TPDGoodsConst.h"
#import "TPUserModuleRouterEntry.h"

@interface TPDGoodsFontSettingController ()

@property (nonatomic,strong) TPDGoodsFontContentView * fontContentView;

@property (nonatomic,strong) UIView * sliderBackView;

@property (nonatomic,strong) UILabel * minLable;

@property (nonatomic,strong) UILabel * maxLable;

@property (nonatomic,strong) UIButton * switchButton;

@end

@implementation TPDGoodsFontSettingController

+ (void)load {
    [TPUserModuleRouterEntry registerFontSetting];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = TPBackgroundColor;
    self.navigationItem.title = @"字体大小";
    [self.view addSubview:self.fontContentView];
    [self.view addSubview:self.sliderBackView];
    [self.sliderBackView addSubview:self.switchButton];
    [self.sliderBackView addSubview:self.minLable];
    [self.sliderBackView addSubview:self.maxLable];
    [self.fontContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(GoodsListCellHeight));
    }];
    
    [self.sliderBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(TPAdaptedHeight(120));
    }];
    
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.sliderBackView);
    }];
    
    [self.minLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.switchButton.mas_left);
        make.top.equalTo(self.sliderBackView.mas_top).with.offset(TPAdaptedHeight(20));
    }];
    
    [self.maxLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.switchButton.mas_right);
        make.top.equalTo(self.minLable);
    }];
}
#pragma mark - event
- (void)changeFont:(UIButton *)sender {
    if (sender.selected) {
        GoodsAddressFontSize = 17;
        GoodsGoodsInfoFontSize = 13;
        GoodsTimeFontSize = 12;
        GoodsListCellHeight = 100;
    } else {
        GoodsAddressFontSize = 20;
        GoodsGoodsInfoFontSize = 16;
        GoodsTimeFontSize = 15;
        GoodsListCellHeight = 112;
    }
    self.switchButton.selected = !sender.isSelected;
    [self.fontContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(TPAdaptedHeight(GoodsListCellHeight));
    }];
    [self.fontContentView refresh];
}
#pragma mark - getter
-(TPDGoodsFontContentView *)fontContentView {
    if (!_fontContentView) {
        _fontContentView = [[TPDGoodsFontContentView alloc] init];
    }
    return _fontContentView;
}
- (UILabel *)minLable {
    if (!_minLable) {
        _minLable = [[UILabel alloc] init];
        _minLable.text = @"标准";
        _minLable.textColor = TPTitleTextColor;
        _minLable.font = TPAdaptedFontSize(15);
    }
    return _minLable;
}
- (UILabel *)maxLable {
    if (!_maxLable) {
        _maxLable = [[UILabel alloc] init];
        _maxLable.text = @"放大";
        _maxLable.textColor = TPTitleTextColor;
        _maxLable.font = TPAdaptedFontSize(18);
    }
    return _maxLable;
}
-(UIView *)sliderBackView {
    if (!_sliderBackView) {
        _sliderBackView = [[UIView alloc] init];
        _sliderBackView.backgroundColor = TPWhiteColor;
    }
    return _sliderBackView;
}
-(UIButton *)switchButton {
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchButton setImage:[UIImage imageNamed:@"goods_icon_standard"] forState:UIControlStateNormal];
        [_switchButton setImage:[UIImage imageNamed:@"goods_icon_enlarge"] forState:UIControlStateSelected];
        [_switchButton addTarget:self action:@selector(changeFont:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}
@end
