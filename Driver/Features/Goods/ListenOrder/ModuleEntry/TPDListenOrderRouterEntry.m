//
//  TPDListenOrderRouterEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/11/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderRouterEntry.h"
#import "TPDAssistiveTouch.h"
#import "TPDListenOrderDataManager.h"
#import "TPFindGoodsButton.h"
#import "TPAlertView.h"
@implementation TPDListenOrderRouterEntry
+ (void)load {
    [self registerInitialAssistiveTouch];
    [self registerRemoveAssistiveTouch];
    [self registerShowAssistiveTouch];
    [self registerHideAssistiveTouch];
}
+ (void)registerInitialAssistiveTouch {
    
   [MGJRouter registerURLPattern:TPRouter_AssistiveTouch_Initial toHandler:^(NSDictionary *routerParameters) {
       [[TPDAssistiveTouch sharedInstance]initialAssistiveTouch];
      
       //获取听单状态
       [[TPDListenOrderDataManager sharedInstance]fetchListenOrderSwitchStatus];
       //听单状态改变
       [TPDListenOrderDataManager sharedInstance].ATlistenOrderStausChanged = ^(ListenOrderSwicthStatus status) {
           [TPDAssistiveTouch sharedInstance].listenOrderStatus = status;
       };
       
       //关闭听单
       [TPDAssistiveTouch sharedInstance].closeListenOrderBlock = ^{
           if ([TPDListenOrderDataManager sharedInstance].listenOrderStatus == ListenOrderSwicthStatus_Off) {
               return ;
           }
           TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"为保证您能及时收到新货源，建议您打开听单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"暂停听单", nil];
           alertView.otherButtonAction = ^{
               [[TPDListenOrderDataManager sharedInstance]updateListenOrderSwitchStatus];
           };
           [alertView show];
           
       };
       
       //开启听单
       [TPDAssistiveTouch sharedInstance].openListenOrderBlock = ^{
           if ([TPDListenOrderDataManager sharedInstance].listenOrderStatus == ListenOrderSwicthStatus_On) {
               return ;
           }
         [[TPDListenOrderDataManager sharedInstance]updateListenOrderSwitchStatus];
       };
       
       //设置路线
       [TPDAssistiveTouch sharedInstance].setRouteBlock = ^{
           TPFindGoodsButton *btn = (TPFindGoodsButton *)CYLExternPlusButton;
           [btn selectPlusSelectedViewController];
       };
   }];
    
}
+ (void)registerRemoveAssistiveTouch {
    
    [MGJRouter registerURLPattern:TPRouter_AssistiveTouch_Remove toHandler:^(NSDictionary *routerParameters) {
        [[TPDAssistiveTouch sharedInstance]removeAssistiveTouch];
    }];
    
}
+ (void)registerShowAssistiveTouch {
    
    [MGJRouter registerURLPattern:TPRouter_AssistiveTouch_Show toHandler:^(NSDictionary *routerParameters) {
        [[TPDAssistiveTouch sharedInstance]showAssistiveTouch];
    }];
    
}

+ (void)registerHideAssistiveTouch {
    
    [MGJRouter registerURLPattern:TPRouter_AssistiveTouch_Hide toHandler:^(NSDictionary *routerParameters) {
        [[TPDAssistiveTouch sharedInstance]hideAssistiveTouch];
    }];
    
}
@end
