//
//  BaseViewController.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewController.h"
#import "PageControllerCenter.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark- Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self subViewLoad];
    [self viewModelBind];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //开启优化手势返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
   [self setUpNavgationBar];
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.navigationController.navigationBarHidden&&self.navgationBarStyle != UIBaseViewControllerNavgationBarStyle_Custom) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (self.navgationBarStyle==UIBaseViewControllerNavgationBarStyle_Custom) {
        [self setDefaultDisplay];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- Events
-(void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark- Lazy Load



#pragma mark- Public Methods
-(void)subViewLoad
{
    
}


-(void)viewModelBind
{
    
}


-(void)pageTurnToViewControllerClass:(NSString *)viewControllerClass fromCurrentViewController:(id)currentVC
{
    [[PageControllerCenter shareInstance]pageTurnToViewControllerClass:viewControllerClass fromCurrentViewController:currentVC];
}

#pragma amrk- Private Methods

-(void)setUpNavgationBar
{
    if (self.navgationBarStyle==UIBaseViewControllerNavgationBarStyle_Custom) {
        
        [self setCustomDisplay];
        if (self.navgationBarHiden) {
        }
        
    }else
    {
        [self setDefaultDisplay];
    }

    
    
}

-(void)setDefaultDisplay
{
    if (self.navigationController) {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationController.navigationBar.translucent = YES;
        [self.my_NavgationBar removeFromSuperview];
    }
    
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
}

-(void)setCustomDisplay
{
    CGRect screenBounds = [[UIScreen mainScreen]bounds];
    
    self.my_NavgationBar = nil;
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view addSubview:self.my_NavgationBar];
    
    if ([self.navigationController.childViewControllers count]>1) {

        UIBarButtonItem * backItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(backAction:)];
        self.my_NavgationItem = [[UINavigationItem alloc] initWithTitle:self.title];

        if (self.backItem) {

            UIView * customBack = [[UIView alloc]initWithFrame:self.backItem.bounds];
            customBack.backgroundColor = [UIColor redColor];
            [customBack addSubview:self.backItem];
            [self.my_NavgationItem setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:customBack]];

        }else
        {
            [self.my_NavgationItem setLeftBarButtonItem:backItem];
        }

        [self.my_NavgationBar pushNavigationItem:self.my_NavgationItem animated:YES];

    }
    
}

#pragma mark- Setter And Getter

-(void)setNavgationBarBackColor:(UIColor *)navgationBarBackColor
{
    self.my_NavgationBar.backgroundColor = navgationBarBackColor;
}

-(void)setNavgationBarBackImage:(UIImage *)navgationBarBackImage
{
    [self.my_NavgationBar setBackgroundImage:navgationBarBackImage forBarMetrics:UIBarMetricsDefault];
}


-(CustomNavgationBar *)my_NavgationBar
{
    if (!_my_NavgationBar) {
        _my_NavgationBar = [[CustomNavgationBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
        _my_NavgationBar.translucent = NO;
    }
    
    return _my_NavgationBar;
}

-(UIBaseViewControllerNavgationBarStyle)navgationBarStyle
{
    return UIBaseViewControllerNavgationBarStyle_Default;
}


#pragma mark- dealloc

-(void)dealloc
{
    NSLog(@"%@-------已经被释放了", NSStringFromClass([self class]));
}

@end
