//
//  MainPageViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/23.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "MainPageViewController.h"
#import "MainPageViewModel.h"

@interface MainPageViewController ()

@property (nonatomic,strong) MainPageViewModel * mainPageViewModel;

@end

@implementation MainPageViewController

#pragma mark- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- Public Methods


#pragma mark- Private Methods


#pragma mark- Override
-(UIBaseViewControllerNavgationBarStyle)navgationBarStyle
{
    return UIBaseViewControllerNavgationBarStyle_Custom;
}

-(void)subViewLoad
{
    self.mainPageViewModel.mainPageView.frame = self.view.bounds;
}

-(void)viewModelBind
{
    
}


-(UIButton *)backItem
{
    UIButton * butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame = CGRectMake(0, 0, 65, 30);
    [butt setTitle:@"454" forState:UIControlStateNormal];
    [butt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return butt;
}

#pragma mark- Events

-(void)backItemAction:(UIButton*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)backAction:(UIButton*)sedner
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- ViewModel
-(MainPageViewModel *)mainPageViewModel
{
    if (!_mainPageViewModel) {
        _mainPageViewModel = [[MainPageViewModel alloc]init];
        [self.view addSubview:_mainPageViewModel.mainPageView];
    }
    
    return _mainPageViewModel;
}

@end
