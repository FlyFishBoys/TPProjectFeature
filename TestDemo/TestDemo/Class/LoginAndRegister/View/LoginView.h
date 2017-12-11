//
//  LoginView.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
#import "TXLimitedTextField.h"

@interface LoginView : BaseView

@property (nonatomic,strong) TXLimitedTextField * userNameTextFiled;
@property (nonatomic,strong) UITextField * passWordTextFiled;
@property (nonatomic,strong) UILabel * userNameLabel;
@property (nonatomic,strong) UILabel * passwordLabel;
@property (nonatomic,strong) UIButton * loginButt;
@property (nonatomic,strong) UIButton * forgetButt;
@property (nonatomic,strong) UIButton * cityButt;

@end
