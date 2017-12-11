//
//  TPDIntegralRecordController.m
//  TopjetPicking
//
//  Created by lish on 2017/10/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//
#import "TPDIntegralRecordController.h"
#import "TPWebView.h"
#import "TPAlertView.h"
#import "TPRefundModuleBridgeConst.h"
@interface TPDIntegralRecordController ()

@property (nonatomic, strong) TPWebView *webView;

@end

@implementation TPDIntegralRecordController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = TPWhiteColor;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    [self addSubviews];
    [self setFrame];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setStatusBarBackgroundColor:[UIColor whiteColor]];
}
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setStatusBarBackgroundColor:[UIColor clearColor]];
}

#pragma mark - Private Methods
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}



#pragma mark - Event Response
//返回关闭页面
- (void)closePage {
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark - custom UI
- (void)addSubviews{
    [self.view addSubview:self.webView];
}
- (void)setFrame {
    @weakify(self);
    [_webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self);
        
    }];
}


#pragma mark - Getters and Setters
- (TPWebView *)webView {
    if (!_webView) {
        _webView = [[TPWebView alloc]initWithProgressTopMargin:64];
        NSLog(@"TPWEB_URL_Refund == %@",TPWEB_URL_Refund);
        [_webView loadRequestWithURLString:@"http://192.168.20.122:8087/"];
        _webView.isBackArrow = YES;
        @weakify(self);
        _webView.didFailNavigation = ^(WKWebView *webView, WKNavigation *navigation, NSError *error) {
            @strongify(self);
            self.navigationController.navigationBar.hidden = NO;
        };

        _webView.closePageHandler = ^{
            @strongify(self);
            [self closePage];
        };

        
    }
    return _webView;
    
}

@end
