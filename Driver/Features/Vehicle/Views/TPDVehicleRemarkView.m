//
//  TPDVehicleRemarkView.m
//  Driver
//
//  Created by Mr.mao on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleRemarkView.h"
#import "NSString+Regular.h"
#import "TXLimitedTextField.h"

@interface TPDVehicleRemarkView ()<UITextFieldDelegate>
{
    NSString * _title;
    NSString * _placeholder;
    NSString * _limitedRegEx;
    BOOL _isHasSeprate;
    TPDVehicleRemarkViewType _type;
}
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIView   * separateLine;
@property (nonatomic, strong) TXLimitedTextField  *textField;

@end

@implementation TPDVehicleRemarkView
- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder limitedRegEx:(NSString *)limitedRegEx isHasSeprate:(BOOL)isHasSeprate {
    if (self = [super init]) {
        _title = title;
        _placeholder = placeholder;
        _limitedRegEx = limitedRegEx;
        _isHasSeprate = isHasSeprate;
        self.backgroundColor = TPWhiteColor;
        [self vr_setupSubviews];
    }
    return self;
}

- (instancetype)initWithType:(TPDVehicleRemarkViewType)type {
    if (self = [super init]) {
        self.backgroundColor = TPWhiteColor;
        _type = type;
        [self vr_setupSubviews];
        [self vr_setTextFieldWithType:type];
    }
    return self;
}

#pragma mark UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    //判断车牌号是否正确
    if (textField.text.isNotBlank && _type == TPDVehicleRemarkViewType_Mobile) {
        BOOL isValidateNumberPlate = [textField.text checkPhoneNumber];
        if (!isValidateNumberPlate) {
            TPShowToast(@"请输入正确的电话号码!");
        }
    }
    
    if (self.completeBlock) {
        self.completeBlock(textField.text);
    }
}

- (BOOL)np_textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

#pragma mark Events
- (void)vr_textFieldValueChanged:(UITextField *)textField {
    if (textField.text.length > 11 && _type == TPDVehicleRemarkViewType_Mobile) {
        textField.text = [textField.text substringToIndex:11];
    }
}

#pragma mark - Privates
- (void)vr_setTextFieldWithType:(TPDVehicleRemarkViewType)type {
    switch (type) {
        case TPDVehicleRemarkViewType_Name:
            {
                self.textField.placeholder = @"请填写司机姓名";
                self.titleLabel.text = @"开车司机";
                self.separateLine.hidden = NO;
            }
            break;

        case TPDVehicleRemarkViewType_Mobile:
        {
            self.textField.placeholder = @"请填写司机电话";
            self.titleLabel.text = @"联系电话";
            self.textField.keyboardType = UIKeyboardTypePhonePad;
            self.separateLine.hidden = YES;
            self.textField.limitedNumber = 11;
        }
            break;
    }
}

- (void)vr_setupSubviews {
    [self addSubview:self.separateLine];
    [self addSubview:self.textField];
    [self addSubview:self.titleLabel];
    [self vr_setupConstraints];
}

- (void)vr_setupConstraints {
    [self.separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.top.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right).offset(TPAdaptedWidth(22));
    }];
}

#pragma mark - Getters
- (void)setContent:(NSString *)content {
    self.textField.text = content;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc]init];
        _separateLine.backgroundColor = TPUNEnbleColor_LineColor;
        _separateLine.hidden = !_isHasSeprate;
    }
    return _separateLine;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = _title.isNotBlank ? _title : @"";
        _titleLabel.font = TPAdaptedFontSize(15);
        _titleLabel.textColor = TPTitleTextColor;
    }
    return _titleLabel;
}

- (TXLimitedTextField *)textField {
    if (!_textField) {
        _textField = [[TXLimitedTextField alloc]init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(vr_textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.limitedType = TXLimitedTextFieldTypeDefault;
    }
    return _textField;
}

@end
