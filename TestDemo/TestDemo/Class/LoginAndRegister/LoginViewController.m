//
//  LoginViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "CityViewModel.h"

@interface LoginViewController ()

@property (nonatomic,strong) LoginViewModel * loginViewModel;
@property (nonatomic,strong) CityViewModel * cityViewModel;

@end

@implementation LoginViewController

#pragma mark- Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

   self.navigationController.navigationBarHidden = YES;
//    self.extendedLayoutIncludesOpaqueBars = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    self.navigationController.navigationBarHidden = NO;

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Override

-(UIBaseViewControllerNavgationBarStyle)navgationBarStyle
{
    return UIBaseViewControllerNavgationBarStyle_Default;
}

-(void)subViewLoad
{
    self.loginViewModel.loginView.frame = self.view.bounds;
    
}

-(void)viewModelBind
{
    __weak typeof(self) weakSelf = self;
    self.loginViewModel.login_bind = ^(BOOL sucess, id viewModel) {
        
        __strong typeof(self)  strongSelf = weakSelf;
        [strongSelf pageTurnToViewControllerClass:@"SwitchViewController" fromCurrentViewController:weakSelf];
        
    };
    

    self.loginViewModel.citySelect_bind = ^{
        
        [weakSelf.cityViewModel citySelectFinishHandle:^(CityModel *cityModel) {
           
            NSLog(@"已经完成城市选择！");
            NSLog(@"cityName---%@",cityModel.cityName);
            NSLog(@"cityId---%@",cityModel.cityCode);
            
        }];
    };
    
}



#pragma mark- Public Methods


#pragma mark- Privates Methods


#pragma mark- ViewModel

-(LoginViewModel *)loginViewModel
{
    if (!_loginViewModel) {
        _loginViewModel = [LoginViewModel new];
        [self.view addSubview:_loginViewModel.loginView];
    }
    
    return _loginViewModel;
}

-(CityViewModel *)cityViewModel
{
    if (!_cityViewModel) {
        _cityViewModel = [CityViewModel new];
    }
    return _cityViewModel;
}







@end
