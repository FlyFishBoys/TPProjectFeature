//
//  TPDEnterCodeView.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDEnterCodeView.h"
#import "UIImage+Gradient.h"
#import "IQKeyboardManager.h"
#import "TPCallCenter.h"
#import "TXLimitedTextField.h"

@interface TPDEnterCodeView ()
@property (nonatomic,strong) UIView * contentView;
@property (nonatomic,strong) UIView * topView;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) UIImageView * codeBackgroundView;
@property (nonatomic,strong) UIImageView * bottomBackgroundView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * closeButton;
@property (nonatomic,strong) UIButton * confirmButton;
@property (nonatomic, strong) UILabel * messageLabel;
@property (nonatomic,strong) UIButton * callButton;
@property (nonatomic, strong) UILabel * callTitleLabel;
@property (nonatomic, strong) TXLimitedTextField * textField;

@property (nonatomic, copy) NSString * code;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * moblie;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * callTitle;

@property (nonatomic, strong) NSMutableArray <UILabel *> * codeLabels;

@end


@implementation TPDEnterCodeView
- (instancetype)initWithCode:(NSString *)code name:(NSString *)name moblie:(NSString *)mobile title:(NSString *)title callTitle:(NSString *)callTitle {
    if (self = [super init]) {
        _code = code;
        _name = name;
        _moblie = mobile;
        _title = title;
        _callTitle = callTitle;
        [self ec_addSubviews];
    }
    return self;
}

- (instancetype)init {
    return [self initWithCode:nil name:nil moblie:nil title:nil callTitle:nil];
}

#pragma mark - Events
- (void)callButtonEvent {
    [self.textField  endEditing:YES];
    if (self.callBlock) {
        self.callBlock();
    }
}

- (void)confirmButtonEvent {
    if (self.completeBlock) {
        self.completeBlock(self, _code);
    }
    [self dismiss];
}

- (void)ec_textFieldDidChange:(UITextField *)textField {
    if (textField.text.length == 6) {
        [self dismiss];
    }
    
    [self.codeLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (textField.text.length > idx) {
            obj.text = [textField.text substringWithRange:NSMakeRange(idx, 1)];
        } else {
            obj.text = @"";
        }
    }];
}

#pragma mark - Privata
- (UILabel *)ec_createCodeLabel {
    UILabel * codeLabel = [[UILabel alloc]init];
    codeLabel.textAlignment = NSTextAlignmentCenter;
    codeLabel.textColor = TPTitleTextColor;
    codeLabel.font = TPAdaptedFontSize(28);
    return codeLabel;
}

- (void)ec_addCodeLabels {
    UILabel * lastLabel;
    for (int i = 0; i < 6; i ++) {
        UILabel * codeLabel = [self ec_createCodeLabel];
        if (_code.length == 6) {
            codeLabel.text = [_code substringWithRange:NSMakeRange(i, 1)];
        }

        [self.codeBackgroundView addSubview:codeLabel];
        if (lastLabel) {
            [codeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastLabel.mas_right);
                make.top.bottom.equalTo(self.codeBackgroundView);
                make.width.equalTo(self.codeBackgroundView.mas_width).multipliedBy(1.0f/6);
            }];
        } else {
            [codeLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.codeBackgroundView.mas_left);
                make.top.bottom.equalTo(self.codeBackgroundView);
                make.width.equalTo(self.codeBackgroundView.mas_width).multipliedBy(1.0f/6);
            }];
        }
        [self.codeLabels addObject:codeLabel];
        lastLabel = codeLabel;
    }
}

- (void)ec_addSubviews {
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.bottomBackgroundView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.closeButton];
    [self.contentView addSubview:self.codeBackgroundView];
    [self.contentView addSubview:self.confirmButton];
    [self.contentView addSubview:self.messageLabel];
    [self.contentView addSubview:self.callButton];
    [self.contentView addSubview:self.callTitleLabel];
    if (_code.length != 6) {
        [self.contentView addSubview:self.textField];
        [self.textField becomeFirstResponder];
        //键盘弹起
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    }
    [self ec_addCodeLabels];

    [self ec_addConstraints];
}

- (void)ec_addConstraints {
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(38));
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-38));
        make.height.mas_equalTo(_code.length == 6 ? TPAdaptedHeight(340) : TPAdaptedHeight(272));
    }];
    
    [self.bottomBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.contentView);
    }];
    
    [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.bottomBackgroundView.mas_top);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.centerX.equalTo(self.contentView);
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.titleLabel.mas_bottom);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.closeButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.titleLabel.mas_bottom);
        make.width.mas_equalTo(TPAdaptedWidth(46));
    }];
    
    [self.codeBackgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(69));
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(16));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-16));
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.confirmButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeBackgroundView.mas_bottom).offset(TPAdaptedHeight(24));
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(16));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-16));
        make.height.mas_equalTo(_code.length == 6 ? TPAdaptedHeight(44) : TPAdaptedHeight(0));
    }];
    
    [self.callTitleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(TPAdaptedHeight(-16));
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.callButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.callTitleLabel.mas_top).offset(TPAdaptedHeight(-6));
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.messageLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.callButton.mas_top).offset(TPAdaptedHeight(-16));
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(16));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-16));
    }];
    
    if (_code.length != 6) {
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.codeBackgroundView);
        }];
    }
}

- (void)dealloc{
    
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
    //移除监听
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

#pragma mark 键盘弹起的通知
-(void)keyboardWillShow:(NSNotification*)noti{
    //键盘弹起的时长
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];

    //键盘的高度
    CGFloat keyboardHeight = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;

    [UIView animateWithDuration:duration animations:^{
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).offset(-keyboardHeight);
            make.left.equalTo(self.mas_left).with.offset(TPAdaptedWidth(16));
            make.right.equalTo(self.mas_right).with.offset(TPAdaptedWidth(-16));
            make.height.mas_equalTo(TPAdaptedHeight(272));
        }];
    }];
    
}

#pragma mark - Public
-(void)show {
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;

    self.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }];
}

-(void)dismiss {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;

    [self.textField  endEditing:YES];
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    } completion:^(BOOL finished) {
        if (self.textField.text.length == 6) {
            if (self.completeBlock) {
                self.completeBlock(self, self.textField.text);
            }
        }
        [self removeFromSuperview];
    }];
}

#pragma mark - Getters
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.clipsToBounds = YES;
        _contentView.layer.cornerRadius = TPAdaptedWidth(4);
    }
    return _contentView;
}

- (UIImageView *)codeBackgroundView {
    if (!_codeBackgroundView) {
        _codeBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_entercode_inputbox_background"]];
    }
    return _codeBackgroundView;
}

- (UIImageView *)bottomBackgroundView {
    if (!_bottomBackgroundView) {
        _bottomBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_entercode_background"]];
    }
    return _bottomBackgroundView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = TPTitleTextColor;
        _titleLabel.font = TPAdaptedFontSize(18);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = _title;
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"smart_find_goods_scroll_text_close_icon"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        _closeButton.adjustsImageWhenHighlighted = NO;
    }
    return _closeButton;
}

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirmButton.clipsToBounds = YES;
        _confirmButton.layer.cornerRadius = TPAdaptedHeight(22);
        [_confirmButton setTitle:@"确认提货" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:TPWhiteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = TPAdaptedFontSize(18);
        UIImage * selectedBackgroundImage = [UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth - 2 * TPAdaptedWidth(38 + 16), TPAdaptedHeight(44)) startColor:UIColorHex(FF573B ) endColor:UIColorHex(FF5E5E)];
        [_confirmButton setBackgroundImage:selectedBackgroundImage forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        _confirmButton.adjustsImageWhenHighlighted = NO;
    }
    return _confirmButton;
}

- (UIButton *)callButton {
    if (!_callButton) {
        _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callButton setImage:[UIImage imageNamed:@"smart_find_goods_call_nor"] forState:UIControlStateNormal];
        [_callButton addTarget:self action:@selector(callButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        _callButton.adjustsImageWhenHighlighted = NO;
    }
    return _callButton;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.textColor = TPTitleTextColor;
        _messageLabel.font = TPAdaptedFontSize(12);
        _messageLabel.numberOfLines = 0;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        if ([_title containsString:@"提货码"]) {
            _messageLabel.text = @"如果现场无法索取提货码，请点击下面电话图标拨打电话询问。";
        } else if ([_title containsString:@"签收码"]) {
            _messageLabel.text = @"如果现场无法索取签收码，请点击下面电话图标拨打电话询问。";
        }
    }
    return _messageLabel;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = TPWhiteColor;
    }
    return _topView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _lineView;
}

- (UILabel *)callTitleLabel {
    if (!_callTitleLabel) {
        _callTitleLabel = [[UILabel alloc]init];
        _callTitleLabel.textColor = TPTitleTextColor;
        _callTitleLabel.font =  [UIFont fontWithName:@".PingFangSC-Semibold" size:TPAdaptedWidth(12)];;
        _callTitleLabel.textAlignment = NSTextAlignmentCenter;
        _callTitleLabel.text = _callTitle;
    }
    return _callTitleLabel;
}

- (NSMutableArray<UILabel *> *)codeLabels {
    if (!_codeLabels) {
        _codeLabels = [[NSMutableArray alloc]init];
    }
    return _codeLabels;
}

- (TXLimitedTextField *)textField {
    if (!_textField) {
        _textField = [[TXLimitedTextField alloc] init];
        _textField.limitedNumber = 6;
        //输入的文字颜色为白色
        _textField.textColor = [UIColor clearColor];
        //输入框光标的颜色为白色
        _textField.tintColor = [UIColor clearColor];
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.clearButtonMode = UITextFieldViewModeNever;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.returnKeyType = UIReturnKeyGo;
        [_textField addTarget:self action:@selector(ec_textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end
