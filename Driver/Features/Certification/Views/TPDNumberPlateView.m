//
//  TPDNumberPlateView.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNumberPlateView.h"
#import "UIButton+ResetContent.h"
#import "NSString+Regular.h"
#import "TXLimitedTextField.h"
#import "TPDSelectProvinceView.h"

static NSString * const kalphNum = @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
@interface TPDNumberPlateView ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * addressButton;
@property (nonatomic,strong) TXLimitedTextField * plateNumberTextField;


@end

@implementation TPDNumberPlateView
#pragma mark - LifeCycle
- (instancetype)init {
    if (self = [super init]) {
        _isEnble = YES;
        [self np_addSubviews];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField {
    //判断车牌号是否正确
    if (textField.text.isNotBlank) {
        BOOL isValidateNumberPlate = [textField.text checkNumberPlate];
        if (!isValidateNumberPlate) {
            TPShowToast(@"请输入正确的车牌号!");
        }
    }
    
    NSString * plateNo2;
    NSString * plateNo3;
    if (textField.text.isNotBlank) {
        plateNo2 = [_plateNumberTextField.text substringToIndex:1];
        plateNo3 = [_plateNumberTextField.text substringFromIndex:1];
    }
    if (self.numberPlateCompleteBlock) {
        self.numberPlateCompleteBlock(plateNo2, plateNo3);
    }
}

//只能输入字母和数字
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kalphNum] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

#pragma mark - Events
- (void)np_choosePlaceNo:(UIButton *)button {
    TPDSelectProvinceView * view = [[TPDSelectProvinceView alloc] init];
    @weakify(self);
    view.selectedBolck = ^(NSString *province) {
        @strongify(self);
        [button setTitle:province forState:UIControlStateNormal];
        if (self.addressPlateCompleteBlock) {
            self.addressPlateCompleteBlock(province.isNotBlank ? province : @"沪");
        }
    };
    [view show];
}

-(void)np_textFieldValueChanged:(UITextField *)textField {
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
}

#pragma mark - Private
- (void)np_addSubviews {
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = TPAdaptedFontSize(15);
    [_titleLabel setText:@"车牌照"];
    _titleLabel.textColor = TPTitleTextColor;
    [self addSubview:_titleLabel];
    
    _addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addressButton setImage:[UIImage imageNamed:@"certification_vehiclecertification_numberplate_arrow_down"] forState:UIControlStateNormal];
    [_addressButton setTitle:@"沪" forState:UIControlStateNormal];
    _addressButton.titleLabel.font = TPAdaptedFontSize(15);
    [_addressButton setTitleColor:TPTitleTextColor forState:UIControlStateNormal];
    [_addressButton addTarget:self action:@selector(np_choosePlaceNo:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addressButton];
    
    _plateNumberTextField = [[TXLimitedTextField alloc] init];
    _plateNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _plateNumberTextField.limitedNumber = 6;
    _plateNumberTextField.textAlignment = NSTextAlignmentRight;
    _plateNumberTextField.limitedType = TXLimitedTextFieldTypeDefault;
    _plateNumberTextField.keyboardType = UIKeyboardTypeASCIICapable;
    _plateNumberTextField.placeholder = @"请输入您的车牌号";
    _plateNumberTextField.delegate = self;
    _plateNumberTextField.textColor = TPTitleTextColor;
    _plateNumberTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    [_plateNumberTextField addTarget:self action:@selector(np_textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
    _plateNumberTextField.font = TPAdaptedFontSize(15);
    _plateNumberTextField.borderStyle = UITextBorderStyleNone;
    [self addSubview:_plateNumberTextField];
    
    [self np_setupConstraints];
}

- (void)np_setupConstraints {
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.top.bottom.equalTo(self);
    }];
    
    CGFloat plateNumberTextFieldWidth = [_plateNumberTextField.placeholder widthForFont:_plateNumberTextField.font];
    [_plateNumberTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(TPAdaptedWidth(-12));
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(plateNumberTextFieldWidth + TPAdaptedWidth(5));
    }];
    
    UIView * separateLine = [[UIView alloc]init];
    separateLine.backgroundColor = TPUNEnbleColor_LineColor;
    [self addSubview:separateLine];
    [separateLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_plateNumberTextField.mas_left).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(TPAdaptedHeight(20));
        make.width.mas_equalTo(0.5);
    }];
    
    [_addressButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(separateLine.mas_left).offset(TPAdaptedWidth(-16));
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(TPAdaptedWidth(45));
    }];
    [_addressButton horizontalCenterTitleAndImage:TPAdaptedWidth(7)];
    
    UIView * bottomLine = [[UIView alloc]init];
    bottomLine.backgroundColor = TPUNEnbleColor_LineColor;
    [self addSubview:bottomLine];
    [bottomLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(12));
        make.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - Override
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self resignFirstResponder];
}

#pragma mark - Setter
- (void)setIsEnble:(BOOL)isEnble {
    _isEnble = isEnble;
    _plateNumberTextField.enabled = isEnble;
    _addressButton.enabled = isEnble;
}

- (void)setPlateNo:(NSString *)plateNo {
    _plateNo = plateNo;
    _plateNumberTextField.text = plateNo;
}

- (void)setPlateCity:(NSString *)plateCity {
    _plateCity = plateCity;
    [_addressButton setTitle:plateCity forState:UIControlStateNormal];
}

@end
