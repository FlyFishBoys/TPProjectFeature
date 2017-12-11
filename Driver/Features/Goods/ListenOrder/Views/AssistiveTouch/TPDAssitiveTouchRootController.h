//
//  TPDAssitiveTouchRootController.h
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/26.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPDAssitiveTouchRootController;
#import "TPDListenOrderToolDefine.h"
typedef void (^RootControllerTapBtn)(UIButton *btn);
@protocol TPDAssitiveTouchRootControllerDelegate <NSObject>

- (void)rootController:(TPDAssitiveTouchRootController *)viewController actionBeginAtPoint:(CGPoint)point;
- (void)rootController:(TPDAssitiveTouchRootController *)viewController actionEndAtPoint:(CGPoint)point;

@end
@interface TPDAssitiveTouchRootController : UIViewController

@property (nonatomic, assign) id<TPDAssitiveTouchRootControllerDelegate> delegate;;

@property (nonatomic , copy) RootControllerTapBtn tapOpenBtnBlock;//打开听单
@property (nonatomic , copy) RootControllerTapBtn tapCloseBtnBlock;//关闭听单
@property (nonatomic , copy) RootControllerTapBtn tapSetRouteBtnBlock;//设置路线
@property (nonatomic , assign )ListenOrderSwicthStatus listenOrderStatus;//听单状态


- (void)moveContentViewToPoint:(CGPoint)point;
//缩小
- (void)shrink;
//放大
- (void)spread;
@end
