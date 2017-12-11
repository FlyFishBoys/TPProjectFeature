//
//  TPDAssistiveTouch.m
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/26.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import "TPDAssistiveTouch.h"

@interface TPDAssistiveTouch()<TPDAssitiveTouchRootControllerDelegate>

@property (nonatomic, assign) CGPoint assistiveWindowPoint;

@property (nonatomic, assign) CGPoint coverWindowPoint;

@property (nonatomic, strong) UIWindow *assistiveWindow;

@property (nonatomic , strong) TPDAssitiveTouchRootController *rootController;

@end

@implementation TPDAssistiveTouch

+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
    return sharedInstance;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        [self addNotification];
           }
    return self;
}
#pragma mark - keyboard Notification
- (void)addNotification {
    
  [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
  
}
#pragma mark - public method
- (void)makeVisibleWindow {
    
      _assistiveWindowPoint = [TPDAssistiveTouchLayoutAttributes cotentViewDefaultPoint];
       self.assistiveWindow.hidden = NO;
    
}
- (void)initialAssistiveTouch {
    if (_assistiveWindow) {
        return;
    }
    [self makeVisibleWindow];
}
- (void)removeAssistiveTouch {
    
    if (!_assistiveWindow) {
        return;
    }
    [_assistiveWindow removeFromSuperview];
    _assistiveWindow = nil;
    [_rootController.view removeFromSuperview];
    _rootController = nil;
}

- (void)hideAssistiveTouch {
    
//    if (!_assistiveWindow.rootViewController.view.hidden || !_assistiveWindow) {
//        return;
//    }
    _assistiveWindow.rootViewController.view.hidden = YES;
    _rootController.view.hidden = YES;
}
- (void)showAssistiveTouch {
//    if (_assistiveWindow.rootViewController.view.hidden || _assistiveWindow) {
//        return;
//    }
    _assistiveWindow.rootViewController.view.hidden = NO;
    _rootController.view.hidden = NO;
}

- (void)closeListenOrder {
    if (self.closeListenOrderBlock) {
        self.closeListenOrderBlock();
    }
    [_rootController shrink];
}
- (void)openListenOrder {
   
    if (self.openListenOrderBlock) {
        self.openListenOrderBlock();
    }
    [_rootController shrink];
}


- (void)setRoute {
    
    if (self.setRouteBlock) {
        self.setRouteBlock();
    }
    [_rootController shrink];
}


#pragma mark - notification
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    
    /*因为动画过程中不能实时修改_assistiveWindowRect,
     *所以如果执行点击操作的话,_assistiveTouchView位置会以动画之前的位置为准.
     *如果执行拖动操作则会有跳动效果.所以需要禁止用户操作.*/
    //_assistiveWindow.userInteractionEnabled = NO;
    NSDictionary *info = [notification userInfo];
    CGFloat duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    //根据实时位置计算于键盘的间距
    CGFloat yOffset = endKeyboardRect.origin.y - CGRectGetMaxY(_assistiveWindow.frame);
    
    //如果键盘弹起给_coverWindowPoint赋值
    if (endKeyboardRect.origin.y < CGRectGetHeight([UIScreen mainScreen].bounds)) {
        _coverWindowPoint = _assistiveWindowPoint;
    }
    
    //根据间距计算移动后的位置viewPoint
    CGPoint viewPoint = _assistiveWindow.center;
    viewPoint.y += yOffset;
    //如果viewPoint在原位置之下,将viewPoint变为原位置
    if (viewPoint.y > _coverWindowPoint.y) {
        viewPoint.y = _coverWindowPoint.y;
    }
    //如果_assistiveWindow被移动,将viewPoint变为移动后的位置
    if (CGPointEqualToPoint(_coverWindowPoint, CGPointZero)) {
        viewPoint.y = _assistiveWindow.center.y;
    }
    
    //根据计算好的位置执行动画
    [UIView animateWithDuration:duration animations:^{
        _assistiveWindow.center = viewPoint;
    } completion:^(BOOL finished) {
        //将_assistiveWindowRect变为移动后的位置并恢复用户操作
        _assistiveWindowPoint = _assistiveWindow.center;
        _assistiveWindow.userInteractionEnabled = YES;
        //使其遮盖键盘
        if ([[UIDevice currentDevice].systemVersion integerValue] < 10) {
            [self makeVisibleWindow];
        }
    }];
}


#pragma mark custom delegate
- (void)rootController:(TPDAssitiveTouchRootController *)viewController actionBeginAtPoint:(CGPoint)point {
    _coverWindowPoint = CGPointZero;
    _assistiveWindow.frame = [UIScreen mainScreen].bounds;
    _rootController.view.frame = [UIScreen mainScreen].bounds;
    [_rootController moveContentViewToPoint:_assistiveWindowPoint];
}

- (void)rootController:(TPDAssitiveTouchRootController *)viewController actionEndAtPoint:(CGPoint)point {
    _assistiveWindowPoint = point;
    _assistiveWindow.frame = CGRectMake(0, 0, [TPDAssistiveTouchLayoutAttributes ATItemImageWidth], [TPDAssistiveTouchLayoutAttributes ATItemImageWidth]);
    _assistiveWindow.center = _assistiveWindowPoint;
    CGPoint contentPoint = CGPointMake([TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2, [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2);
    [_rootController moveContentViewToPoint:contentPoint];
}

#pragma mark - getter - setter
- (TPDAssitiveTouchRootController *)rootController {
    if (!_rootController) {
        _rootController = [[TPDAssitiveTouchRootController alloc] init];
        _rootController.delegate = self;
         __weak typeof(self) weakSelf = self;
        _rootController.tapSetRouteBtnBlock = ^(UIButton *btn) {
            [weakSelf setRoute];
        };
        _rootController.tapOpenBtnBlock = ^(UIButton *btn) {
            [weakSelf openListenOrder];
        };
        _rootController.tapCloseBtnBlock = ^(UIButton *btn) {
            [weakSelf closeListenOrder];
        };
    }
    return _rootController;
}

- (UIWindow *)assistiveWindow {
    if (!_assistiveWindow) {
        _assistiveWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] , [TPDAssistiveTouchLayoutAttributes ATItemImageWidth])];
        _assistiveWindow.center = _assistiveWindowPoint;
        _assistiveWindow.windowLevel = UIWindowLevelNormal;
        _assistiveWindow.backgroundColor = [UIColor clearColor];
        _assistiveWindow.rootViewController = self.rootController;
        _assistiveWindow.layer.masksToBounds = YES;
    }
    return _assistiveWindow;
}

- (void)setListenOrderStatus:(ListenOrderSwicthStatus)listenOrderStatus {
    
    _listenOrderStatus = listenOrderStatus;
    _rootController.listenOrderStatus = _listenOrderStatus;
    
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
