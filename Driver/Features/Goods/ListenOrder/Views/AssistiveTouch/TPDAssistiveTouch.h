//
//  TPDAssistiveTouch.h
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/26.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TPDAssistiveTouchDefines.h"
#import "TPDListenOrderToolDefine.h"
typedef void (^AssistiveTouchTapBlock)(void);

@interface TPDAssistiveTouch : NSObject

@property (nonatomic , copy) AssistiveTouchTapBlock openListenOrderBlock;//开启订单
@property (nonatomic , copy) AssistiveTouchTapBlock closeListenOrderBlock;//关闭订单
@property (nonatomic , copy) AssistiveTouchTapBlock setRouteBlock;//设置路线

@property (nonatomic , assign)ListenOrderSwicthStatus listenOrderStatus;//听单状态
/**
 单例

 @return AssistiveTouch
 */
+ (instancetype)sharedInstance;

/**
 初始化AssistiveTouch
 */
- (void)initialAssistiveTouch;

/**
 移除AssistiveTouch
 */
- (void)removeAssistiveTouch;

/**
 隐藏AssistiveTouch
 */
- (void)hideAssistiveTouch;

/**
 展示AssistiveTouch
 */
- (void)showAssistiveTouch;


@end
