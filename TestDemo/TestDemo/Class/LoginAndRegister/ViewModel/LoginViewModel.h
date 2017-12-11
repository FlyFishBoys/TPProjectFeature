//
//  LoginViewModel.h
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewModel.h"
#import "LoginViewModel.h"
#import "LoginView.h"


typedef void(^LoginViewModel_Login)(BOOL sucess, id viewModel);
typedef void(^LoginViewModel_CitySelect)(void);


@interface LoginViewModel : BaseViewModel

#pragma mark- outer
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * password;

#pragma mark- inner
@property (nonatomic,strong) LoginView * loginView;
@property (nonatomic,copy) LoginViewModel_Login  login_bind;
@property (nonatomic,copy) LoginViewModel_CitySelect  citySelect_bind;

//登录
-(void)userPassWordLoginRequest;


@end
