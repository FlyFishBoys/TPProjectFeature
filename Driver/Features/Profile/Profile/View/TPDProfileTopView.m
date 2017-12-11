//
//  TPDProfileTopView.m
//  TopjetPicking
//
//  Created by lish on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileTopView.h"
#import "UIButton+ResetContent.h"
#import "UIImageView+TPWebCache.h"
@interface TPDProfileTopItem()

//上面
@property (nonatomic , strong) UILabel *topLabel;

//下面
@property (nonatomic , strong) UILabel *bottomLabel;

@end
@implementation TPDProfileTopItem

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TPWhiteColor;
        [self addSubviews];
        [self setFrame];
        [self addGestureRecognizer];
       
    }
    return self;
}

- (void)addGestureRecognizer {
    self.userInteractionEnabled = YES;
    @weakify(self);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.tapItemHandle) {
            self.tapItemHandle();
        }
        
    }];
    
    [self addGestureRecognizer:tap];
    
}
- (void)addSubviews {
     [self addSubview:self.topLabel];
     [self addSubview:self.bottomLabel];
}

- (void)setFrame {
    
    [_topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(TPAdaptedHeight(12));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(TPAdaptedHeight(25));

    }];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).offset(TPAdaptedHeight(7));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-12));
    }];
    
    
}

- (UILabel *)topLabel {
    
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.text = @"0.0";
        _topLabel.font = TPAdaptedBoldFontSize(17);
        _topLabel.textColor = UIColorHex(#666666);
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
    
}

- (UILabel *)bottomLabel {
    
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.font = TPAdaptedFontSize(12);
        _bottomLabel.textColor = UIColorHex(#666666);
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
    
}
- (void)setTopStr:(NSString *)topStr {
    
    if ([topStr isNotBlank] && ![topStr isEqualToString:@"null"]) {
        _topStr = topStr;
        _topLabel.text = _topStr;
    }
}

- (void)setBottomStr:(NSString *)bottomStr {
    _bottomStr = bottomStr;
    _bottomLabel.text = _bottomStr;
    
}
@end
@interface TPDProfileTopView()

//背景
@property (nonatomic, strong) UIImageView *topImage;

//白色背景
@property (nonatomic , strong) UIView *whiteBg;

//消息图标
@property (nonatomic , strong) UIImageView *messageIcon;

//设置图标
@property (nonatomic , strong) UIImageView *setIcon;

//头像
@property (nonatomic , strong) UIImageView *headImage;

//审核图标
@property (nonatomic , strong) UIImageView *auditIcon;

//姓名
@property (nonatomic , strong) UILabel *nameLabel;

//认证图标
@property (nonatomic , strong) UIImageView *authenticationIcon;

//签到
@property (nonatomic , strong) UIButton *signInBtn;

//签到箭头
@property (nonatomic , strong) UIImageView *signInArrow;

//积分动态
@property (nonatomic , strong) UILabel *integralStateLabel;

//评价
@property (nonatomic , strong) TPDProfileTopItem *evaluateItem;

//积分
//@property (nonatomic , strong) TPDProfileTopItem *integralItem;

//钱包余额
@property (nonatomic , strong) TPDProfileTopItem *walletBalanceItem;

@end

@implementation TPDProfileTopView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubviews];
        [self setFrame];
    }
    return self;
}
- (void)addSubviews {
   
     [self addSubview:self.topImage];
     [self addSubview:self.whiteBg];
     [self addSubview:self.messageIcon];
     [self addSubview:self.setIcon];
     [self addSubview:self.headImage];
     [self addSubview:self.nameLabel];
     [self addSubview:self.auditIcon];
     [self addSubview:self.authenticationIcon];
//     [self addSubview:self.signInBtn];
//     [self addSubview:self.signInArrow];
    // [self addSubview:self.integralStateLabel];
    // [self addSubview:self.integralItem];
     [self addSubview:self.walletBalanceItem];
     [self addSubview:self.evaluateItem];
    
  
}
- (void)setFrame {
    
    
    [_topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.equalTo(self);
    }];
    
    [_whiteBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(64));
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-12));
    }];
    
    [_messageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.whiteBg.mas_top).offset(TPAdaptedHeight(-10));
        make.right.equalTo(self).offset(TPAdaptedWidth(-21));
    }];
    
    [_setIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_messageIcon);
        make.right.equalTo(self.messageIcon.mas_left).offset(TPAdaptedWidth(-21));
    }];
    
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(76));
        make.left.equalTo(self).offset(TPAdaptedWidth(24));
        make.width.height.mas_equalTo(TPAdaptedWidth(70));
    }];
    
    [_auditIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(125));
        make.left.equalTo(self).offset(TPAdaptedWidth(77));
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(110));
           make.top.equalTo(self).offset(TPAdaptedHeight(86));
    }];
    
    [_authenticationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(110));
        make.top.equalTo(self).offset(TPAdaptedHeight(120));
    }];
    
    [_signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.top.equalTo(self).offset(TPAdaptedHeight(95));
        make.width.mas_equalTo(TPAdaptedWidth(88));
        make.height.mas_equalTo(TPAdaptedHeight(28));
    }];
    
    [_signInArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-15));
        make.centerY.equalTo(self.signInBtn);
    }];
    
    [_integralStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_signInBtn);
        make.top.equalTo(_signInBtn.mas_bottom).offset(TPAdaptedHeight(6));
    }];
    
    [_evaluateItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(-12));
        make.width.mas_equalTo(TPAdaptedWidth(176));
        make.height.mas_equalTo(TPAdaptedHeight(72));
      
    }];
    
    [_walletBalanceItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.evaluateItem.mas_right);
        make.bottom.equalTo(self.evaluateItem);
        make.width.height.equalTo(self.evaluateItem);
    }];
    
//    [_walletBalanceItem mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
//        make.bottom.equalTo(self.evaluateItem);
//        make.width.height.equalTo(self.evaluateItem);
//    }];
    
}
#pragma mark - Event Response
- (void)tapSignInBtn {
    if (self.tapSignInHandle) {
        self.tapSignInHandle();
    }
    
}
- (void)showIcon:(BOOL)show {
    _setIcon.hidden = show;
    _messageIcon.hidden = show;
    
}
- (void)blindViewModel:(TPDProfileViewModel *)viewModel {
    //头像
   [self.headImage tp_setOriginalImageWithURL:[NSURL URLWithString:viewModel.model.icon_image_url]  md5Key:viewModel.model.icon_image_key placeholderImage:[UIImage imageNamed:@"common_user_image"] roundCornerRadius:TPAdaptedWidth(70)/2];
    
    //图标
    self.auditIcon.image = viewModel.usericonAuditImage;
    
    //姓名
    self.nameLabel.text = viewModel.name;
    
    //认证状态
    self.authenticationIcon.image = viewModel.userStatusIcon;
    
    //签到
    [_signInBtn setTitle:viewModel.signStatus forState:0];
    _signInBtn.userInteractionEnabled = !viewModel.isSignIn;
    [_signInBtn setBackgroundImage:[UIImage imageNamed:@"personal_center_sign_in_bg"] forState:0];
    //签到箭头
    _signInArrow.hidden = viewModel.isSignIn;
    
    //签到积分
    self.integralStateLabel.text = viewModel.obtainIntegral;
    
    //评价
    _evaluateItem.topStr = viewModel.model.degree_of_praise;
    _evaluateItem.bottomStr = @"评价";
    
    //钱包
    _walletBalanceItem.topStr = viewModel.model.wallet_balance;
    _walletBalanceItem.bottomStr = @"钱包余额";
    
//    //积分
//    _integralItem.topStr = viewModel.model.integral_amount;
//    _integralItem.bottomStr = @"积分";
    
}
- (UIImageView *)topImage
{
    if (!_topImage) {
        _topImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"personal_center_bg"]];
    }
    return _topImage;
}

- (UIView *)whiteBg
{
    if (!_whiteBg) {
        _whiteBg = [[UIView alloc] init];
        _whiteBg.backgroundColor = TPWhiteColor;
        _whiteBg.layer.cornerRadius = 3;
        _whiteBg.layer.masksToBounds = YES;
    }
    return _whiteBg;
}

- (UIImageView *)messageIcon {
    
    if (!_messageIcon) {
        _messageIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_center_message_icon"]];
        @weakify(self);
        _messageIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.tapMessageIconHandle) {
                self.tapMessageIconHandle();
            }
        }];
        [_messageIcon addGestureRecognizer:tap];
    }
    return _messageIcon;
}
- (UIImageView *)setIcon {
    
    if (!_setIcon) {
        _setIcon =  [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_center_set_icon"]];
        @weakify(self);
        _setIcon.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.tapSetIconHandle) {
                self.tapSetIconHandle();
            }
        }];
         [_setIcon addGestureRecognizer:tap];
    }
    return _setIcon;
}

- (UIImageView *)headImage {
    
    
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"common_user_image"];
        _headImage.layer.cornerRadius = TPAdaptedWidth(70)/2;
        _headImage.layer.masksToBounds = YES;
        @weakify(self);
        _headImage.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            @strongify(self);
            if (self.tapHeaderIconHandle) {
                self.tapHeaderIconHandle();
            }
        }];
        [_headImage addGestureRecognizer:tap];
    }
    return _headImage;
}
- (UIImageView *)auditIcon {
    
    
    if (!_auditIcon) {
        _auditIcon = [[UIImageView alloc]init];
        //_auditIcon.image = [UIImage imageNamed:@"personal_center_audit_icon"];
    }
    return _auditIcon;

}

- (UIImageView *)authenticationIcon {
    
    
    if (!_authenticationIcon) {
        _authenticationIcon = [[UIImageView alloc]init];
        //_authenticationIcon.image = [UIImage imageNamed:@"personal_center_have_authenticated_bg"];
        
    }
    return _authenticationIcon;
    
}

- (UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
       // _nameLabel.text = @"刘诗诗";
        _nameLabel.font = TPAdaptedBoldFontSize(18);
        _nameLabel.textColor = TPTitleTextColor;
    }
    return _nameLabel;
    
}
- (UILabel *)integralStateLabel {
    
    if (!_integralStateLabel) {
        _integralStateLabel = [[UILabel alloc]init];
        //_integralStateLabel.text = @"今日+2积分";
        _integralStateLabel.font = TPAdaptedFontSize(12);
        _integralStateLabel.textColor = UIColorHex(#FFB000);
    }
    return _integralStateLabel;
    
}

- (TPDProfileTopItem *)evaluateItem {
    
    if (!_evaluateItem) {
        _evaluateItem = [[TPDProfileTopItem alloc]init];
        @weakify(self);
        _evaluateItem.tapItemHandle = ^{
            @strongify(self);
            if (self.tapItemHandle) {
                self.tapItemHandle(0);
            }
        };
    }
    return _evaluateItem;
    
}
//- (TPDProfileTopItem *)integralItem {
//    
//    if (!_integralItem) {
//        _integralItem = [[TPDProfileTopItem alloc]init];
//         @weakify(self);
//        _integralItem.tapItemHandle = ^{
//            @strongify(self);
//            if (self.tapItemHandle) {
//                self.tapItemHandle(1);
//            }
//        };
//    }
//    return _integralItem;
//    
//}
- (TPDProfileTopItem *)walletBalanceItem {
    
    if (!_walletBalanceItem) {
        _walletBalanceItem = [[TPDProfileTopItem alloc]init];
        @weakify(self);
        _walletBalanceItem.tapItemHandle = ^{
            @strongify(self);
            if (self.tapItemHandle) {
                self.tapItemHandle(2);
            }
        };
    }
    return _walletBalanceItem;
    
}
- (UIButton *)signInBtn {
    
    if (!_signInBtn) {
        _signInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[_signInBtn setTitle:@"签到" forState:0];
        [_signInBtn setTitleColor:TPWhiteColor forState:0];
        _signInBtn.titleLabel.font = TPAdaptedFontSize(14);
        [_signInBtn addTarget:self action:@selector(tapSignInBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _signInBtn;
    
    
}

- (UIImageView *)signInArrow {
    
    
    if (!_signInArrow) {
        _signInArrow = [[UIImageView alloc]init];
        //_signInArrow.image = [UIImage imageNamed:@"personal_center_sign_in_arrow"];
        
    }
    return _signInArrow;
    
}
@end
