//
//  SwitchViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/22.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "SwitchViewController.h"
#import "CustomNavgationBar.h"
#import "PageControllerCenter.h"

@interface SwitchViewController ()

@end

@implementation SwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton * blueButt = [UIButton buttonWithType:UIButtonTypeCustom];
    blueButt.frame = CGRectMake(100, 100, 100, 100 );
    blueButt.backgroundColor = [UIColor blueColor];
    [blueButt addTarget:self action:@selector(blueButtAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blueButt];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.hidesBottomBarWhenPushed = YES;
    CustomNavgationBar * customNavBar = [[CustomNavgationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [self.view addSubview:customNavBar];
    
    UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(backAction:)];
    UINavigationItem * navgationItem = [[UINavigationItem alloc] initWithTitle:self.title];
    [navgationItem setLeftBarButtonItem:backItem];
    [customNavBar pushNavigationItem:navgationItem animated:YES];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    
}

-(void)backAction:(UIButton*)sedner
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    NSLog(@"SwitchViewController ---- 已经被释放了");
}

#pragma mark- Override





#pragma mark- Public

-(void)logLoginStyle
{
    if (_loginStyle) {
        NSLog(@"登录的方式是--------%@",_loginStyle);
    }
}

-(void)blueButtAction:(UIButton*)sender
{
    [[PageControllerCenter shareInstance] pageTurnToViewControllerClass:@"MainPageViewController" fromCurrentViewController:self];
}


@end
