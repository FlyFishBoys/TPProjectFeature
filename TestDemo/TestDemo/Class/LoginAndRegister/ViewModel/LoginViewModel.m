//
//  LoginViewModel.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginViewModel.h"

@interface LoginViewModel()<UITextFieldDelegate>


@end

@implementation LoginViewModel

#pragma mark- override

-(void)loadView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc]init];
        _loginView.backgroundColor = [UIColor whiteColor];
        self.currentView = _loginView;
    }

    _loginView.userNameTextFiled.delegate = self;
    [_loginView.userNameTextFiled addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
    
    _loginView.passWordTextFiled.delegate = self;
    [_loginView.passWordTextFiled addTarget:self action:@selector(textFiledChanged:) forControlEvents:UIControlEventEditingChanged];
    
    [_loginView.loginButt addTarget:self action:@selector(loginButtAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_loginView.cityButt addTarget:self action:@selector(cityButtAction:) forControlEvents:UIControlEventTouchUpInside];

}


#pragma mark- Public


#pragma mark- Delegate

#pragma mark  UITextFieldDelegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"我才是真正的调用者");
    return YES;
}


#pragma mark- Events

-(void)textFiledChanged:(UITextField*)tf
{
    if ([tf  isEqual:_loginView.userNameTextFiled])
    {
        
        
    }else if ([tf isEqual:_loginView.passWordTextFiled])
    {
        
    }
}

-(void)loginButtAction:(UIButton*)sender
{
    [self userPassWordLoginRequest];
    
    [self showSuccessMessageWithContent:@"登录成功" enable:NO];
    if (self.login_bind) {
        self.login_bind(YES, self);
    }
}

-(void)cityButtAction:(UIButton*)sender
{
    if (self.citySelect_bind) {
        self.citySelect_bind();
    }
}


#pragma mark- NetWork
-(void)userPassWordLoginRequest
{
   [self showNetWorkProgressHUD];
    
    NSLog(@"%@",[self currentGroupFilePathWithMFilePath:__FILE__]);

    [self requestWithDestination:Business_Login forViewModel:self completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [self hidenNetWorkProgressHUD];
    }];
}


#pragma mark- Getter

-(NSString *)userName
{
    if (_userName==nil) {
        _userName = self.loginView.userNameTextFiled.text;
    }
    return _userName;
}

-(NSString *)password
{
    if (_password==nil) {
        _password = self.loginView.passWordTextFiled.text;
    }
    return _userName;
}

#pragma mark- UI


@end
