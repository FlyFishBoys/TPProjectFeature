//
//  TPDAssitiveTouchRootController.m
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/26.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import "TPDAssitiveTouchRootController.h"
#import "TPDAssistiveTouchDefines.h"
@interface TPDAssitiveTouchRootController ()

@property (nonatomic, strong) UIImageView *contentItem;
@property (nonatomic, strong) UIImageView *contentView;
@property (nonatomic, assign) CGFloat contentAlpha;
@property (nonatomic, assign) CGPoint contentPoint;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isShow;

@property (nonatomic , strong) NSMutableArray *btnArr;
@end

@implementation TPDAssitiveTouchRootController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, [TPDAssistiveTouchLayoutAttributes ATItemImageWidth], [TPDAssistiveTouchLayoutAttributes ATItemImageWidth]);
    
    _contentPoint = [TPDAssistiveTouchLayoutAttributes cotentViewDefaultPoint];

    [self addSubViews];
    [self addGesture];
    
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (void)addSubViews {
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.contentItem];
    [self addContentItem];
   
    
}
- (void)addContentItem {
    
    _btnArr = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        TPDAssistiveTouchItem *item;
        item = [TPDAssistiveTouchItem creatItemWithFrame:CGRectMake(0, 0, [TPDAssistiveTouchLayoutAttributes ATContenItmeWidth], [TPDAssistiveTouchLayoutAttributes ATContenItmeheight])];
        item.center = _contentView.center;
        item.alpha = 0;
        item.hidden = YES;
        item.btnTag = 51 + i;
        item.tag = item.btnTag;
        [self.view addSubview:item];
        [_btnArr addObject:item];
        item.tapBlock = ^(UIButton *btn) {
            switch (btn.tag) {
                case 51:
                    if (self.tapOpenBtnBlock) {
                        self.tapOpenBtnBlock(btn);
                    }
                    break;
                case 52:
                    if (self.tapSetRouteBtnBlock) {
                        self.tapSetRouteBtnBlock(btn);
                    }
                    
                    break;
                case 53:
                    if (self.tapCloseBtnBlock) {
                        self.tapCloseBtnBlock(btn);
                    }
                    break;
            }
        };
    }
}
- (void)addGesture {
    UITapGestureRecognizer *spreadGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(spread)];
    UITapGestureRecognizer *shrinkGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(shrink)];
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [self.contentItem addGestureRecognizer:spreadGestureRecognizer];
    [self.view addGestureRecognizer:shrinkGestureRecognizer];
    [self.contentItem addGestureRecognizer:panGestureRecognizer];
}
#pragma mark - custom method
- (void)moveContentViewToPoint:(CGPoint)point {
    self.contentPoint = point;
}

#pragma mark - GestureAction
//放大
- (void)spread {
    if (self.isShow) {
        return;
    }
    [self stopTimer];
    [self invokeActionBeginDelegate];
    self.isShow = YES;
    
    [_btnArr enumerateObjectsUsingBlock:^(TPDAssistiveTouchItem *button, NSUInteger idx, BOOL * _Nonnull stop) {
        button.center = _contentView.center;
        button.alpha = 0;
        [UIView animateWithDuration:[TPDAssistiveTouchLayoutAttributes animationDuration] animations:^{
            button.center = [TPDAssistiveTouchLayoutAttributes getCenterWithIndex:idx];
            button.hidden = NO;
            button.alpha = 1;
        }];
        
    }];
    
    [UIView animateWithDuration:[TPDAssistiveTouchLayoutAttributes animationDuration] animations:^{
        _contentView.frame = [TPDAssistiveTouchLayoutAttributes spreadContentViewFrame];
        _contentItem.alpha = 0;
        _contentView.alpha = 1;
        _contentItem.center = _contentView.center;
        _contentView.hidden = NO;
      
    }];
    
}

//缩小
- (void)shrink {
    if (!self.isShow) {
        return;
    }
    [self beginTimer];
    self.isShow = NO;
    
    [_btnArr enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        [UIView animateWithDuration:[TPDAssistiveTouchLayoutAttributes animationDuration] animations:^{
            btn.center = _contentPoint;
            btn.alpha = 0;
            btn.hidden = YES;
            }];
    }];
    [UIView animateWithDuration:[TPDAssistiveTouchLayoutAttributes animationDuration] animations:^{
        _contentView.frame = CGRectMake(0, 0, [TPDAssistiveTouchLayoutAttributes ATItemImageWidth], [TPDAssistiveTouchLayoutAttributes ATItemImageWidth]);
        _contentView.center = _contentPoint;
        _contentItem.alpha = 1;
        _contentView.alpha = 0;
        _contentItem.center = _contentPoint;
    } completion:^(BOOL finished) {
        _contentView.hidden = YES;
        [self invokeActionEndDelegate];
    }];
}

#pragma mark - 拖拽
- (void)panGestureAction:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self.view];
    
    static CGPoint pointOffset;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pointOffset = [gestureRecognizer locationInView:self.contentItem];
    });
    
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self invokeActionBeginDelegate];
        [self stopTimer];
        [UIView animateWithDuration:[TPDAssistiveTouchLayoutAttributes animationDuration] animations:^{
            self.contentAlpha = 1;
        }];
    } else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.contentPoint = CGPointMake(point.x + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2 - pointOffset.x, point.y  + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth]/ 2 - pointOffset.y);
    } else if (gestureRecognizer.state == UIGestureRecognizerStateEnded
               || gestureRecognizer.state == UIGestureRecognizerStateCancelled
               || gestureRecognizer.state == UIGestureRecognizerStateFailed) {
        [UIView animateWithDuration:[TPDAssistiveTouchLayoutAttributes animationDuration] animations:^{
            self.contentPoint = [self stickToPointByHorizontal];
        } completion:^(BOOL finished) {
            [self invokeActionEndDelegate];
            onceToken = NO;
            [self beginTimer];
        }];
    }
}

//水平拖拽
- (CGPoint)stickToPointByHorizontal {
    CGRect screen = [UIScreen mainScreen].bounds;
    CGPoint center = self.contentPoint;
    if (center.y < center.x && center.y < -center.x + screen.size.width) {
        CGPoint point = CGPointMake(center.x, 2 + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2);
        point = [self makePointValid:point];
        return point;
    } else if (center.y > center.x + screen.size.height - screen.size.width
               && center.y > -center.x + screen.size.height) {
        CGPoint point = CGPointMake(center.x, CGRectGetHeight(screen) - [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2 - 2);
        point = [self makePointValid:point];
        return point;
    } else {
        if (center.x < screen.size.width / 2) {
            CGPoint point = CGPointMake(2 + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2, center.y);
            point = [self makePointValid:point];
            return point;
        } else {
            CGPoint point = CGPointMake(CGRectGetWidth(screen) - [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2 - 2, center.y);
            point = [self makePointValid:point];
            return point;
        }
    }
}
//竖直拖拽
- (CGPoint)makePointValid:(CGPoint)point {
    CGRect screen = [UIScreen mainScreen].bounds;
    if (point.x < 2 + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2) {
        point.x = 2 + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2;
    }
    if (point.x > CGRectGetWidth(screen) -[TPDAssistiveTouchLayoutAttributes ATItemImageWidth]/ 2 - 2) {
        point.x = CGRectGetWidth(screen) - [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2 - 2;
    }
    if (point.y < 2 + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2) {
        point.y = 2 + [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2;
    }
    if (point.y > CGRectGetHeight(screen) - [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2 - 2) {
        point.y = CGRectGetHeight(screen) - [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] / 2 - 2;
    }
    return point;
}

#pragma mark - custom delegate
- (void)invokeActionBeginDelegate {
    if ( _delegate && [_delegate respondsToSelector:@selector(rootController:actionBeginAtPoint:)]) {
        [_delegate rootController:self actionBeginAtPoint:self.contentPoint];
    }
}

- (void)invokeActionEndDelegate {
    if (_delegate && [_delegate respondsToSelector:@selector(rootController:actionEndAtPoint:)]) {
        [_delegate rootController:self actionEndAtPoint:self.contentPoint];
    }
}

#pragma mark - timer
- (void)beginTimer {
    _timer = [NSTimer timerWithTimeInterval:[TPDAssistiveTouchLayoutAttributes activeDuration] target:self selector:@selector(timerFired) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}
- (void)timerFired {
    [UIView animateWithDuration:[TPDAssistiveTouchLayoutAttributes animationDuration] animations:^{
        self.contentAlpha = [TPDAssistiveTouchLayoutAttributes inactiveAlpha
                             ];
    }];
    [self stopTimer];
}

#pragma mark - getter - setter
- (UIImageView *)contentView {
    if (!_contentView) {
        _contentView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [TPDAssistiveTouchLayoutAttributes ATItemImageWidth], [TPDAssistiveTouchLayoutAttributes ATItemImageWidth])];
        _contentView.image = [UIImage imageNamed:@"assistiveTouch_bg_black"];
        _contentView.center = _contentPoint;
        _contentView.backgroundColor = [UIColor clearColor];

    }
    return _contentView;
}
- (UIImageView *)contentItem {
    if (!_contentItem) {
        _contentItem = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"assistiveTouch_item_on_high"]];
        _contentItem.userInteractionEnabled = YES;
        _contentItem.frame = CGRectMake(0, 0, [TPDAssistiveTouchLayoutAttributes ATItemImageWidth], [TPDAssistiveTouchLayoutAttributes ATItemImageWidth]);
    }
    return _contentItem;
}
- (void)setContentPoint:(CGPoint)contentPoint {
    if (!self.isShow) {
        _contentPoint = contentPoint;
        _contentView.center = _contentPoint;
        _contentItem.center = _contentPoint;
    }
}

- (void)setContentAlpha:(CGFloat)contentAlpha {
    if (!self.isShow) {
        _contentAlpha = contentAlpha;
        _contentView.alpha = _contentAlpha;
        _contentItem.alpha = _contentAlpha;
        _contentView.hidden = YES;
    }
}

- (void)setListenOrderStatus:(ListenOrderSwicthStatus)listenOrderStatus {
    _listenOrderStatus = listenOrderStatus;
    switch (_listenOrderStatus) {
           case ListenOrderSwicthStatus_On:
               _contentItem.image = [UIImage imageNamed:@"assistiveTouch_item_on_high"];
                        break;
            
            case ListenOrderSwicthStatus_Off:
               _contentItem.image = [UIImage imageNamed:@"assistiveTouch_item_off_high"];
         }
    
}

@end
