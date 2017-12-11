//
//  BaseViewModel.m
//  TestDemo
//
//  Created by sunwf on 2017/11/17.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseViewModel.h"
#import "NetWorkManagerCenter.h"
#import "CommonUnitCenter.h"

@implementation BaseViewModel

-(instancetype)init
{
    self = [super init];
    if (self) {
        [self loadView];
    }
    return self;
}

-(void)loadView
{
}

#pragma mark- Setter

-(void)setCurrentView:(UIView *)currentView
{
    _currentView = currentView;
    
    
}

#pragma mark- Override

-(void)requestWithDestination:(NSString *)destination forViewModel:(id)viewModel completionHandler:(void (^)(NSData *, NSURLResponse *, NSError *))completionHandler
{
    [[NetWorkManagerCenter shareInstance]requestWithDestination:destination forViewModel:viewModel completionHandler:completionHandler];
}



#pragma mark- Public

-(void)showSuccessMessageWithContent:(NSString *)message
{
    if (self.currentView) {
        [[CommonUnitCenter shareCommon]showSuccessMessageWithContent:message];
    }
}

-(void)showFailMessageWithContent:(NSString *)message
{
    if (self.currentView) {
        [[CommonUnitCenter shareCommon]showFailMessageWithContent:message];
    }
}


-(void)showSuccessMessageWithContent:(NSString *)message enable:(BOOL)enable
{
    if (self.currentView) {
        [[CommonUnitCenter shareCommon]showSuccessMessageWithContent:message enable:enable];
    }
}

-(void)showFailMessageWithContent:(NSString *)message enable:(BOOL)enable
{
    if (self.currentView) {
        [[CommonUnitCenter shareCommon]showFailMessageWithContent:message enable:enable];
    }
}


-(void)showNetWorkProgressHUD 
{
    if (self.currentView) {
        [[CommonUnitCenter shareCommon]showNetWorkProgressHUDforView:self.currentView];
    }
}

-(void)hidenNetWorkProgressHUD
{
    if (self.currentView) {
        [[CommonUnitCenter shareCommon]hidenNetWorkProgressHUDforView:self.currentView];
    }
}

-(void)showNetWorkProgressHUDforView:(UIView*)view
{
    if (view) {
        [[CommonUnitCenter shareCommon]showNetWorkProgressHUDforView:view];
    }
}

-(void)hidenNetWorkProgressHUDforView:(UIView*)view
{
    if (view) {
        [[CommonUnitCenter shareCommon]hidenNetWorkProgressHUDforView:view];
    }
}



-(void)dealloc
{
    NSLog(@"%@ 已经被释放了", NSStringFromClass([self class]));
}



-(NSString*)currentGroupFilePathWithMFilePath:(char[])path
{
    NSString * currentFilePath = [NSString stringWithFormat:@"%s",path];
    NSArray * pathArr = [currentFilePath componentsSeparatedByString:@"ViewModel"];
    currentFilePath = [[pathArr firstObject] stringByAppendingString:@"Model"];
    
    return currentFilePath;
}

@end
