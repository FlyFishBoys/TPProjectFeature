//
//  TPDAssistiveTouchLayoutAttributes.h
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/26.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TPDAssistiveTouchLayoutAttributes : NSObject
+ (CGRect)spreadContentViewFrame;
+ (CGPoint)cotentViewDefaultPoint;
+ (CGFloat)ATContenItmeWidth;
+ (CGFloat)ATContenItmeheight;
+ (CGFloat)ATItemImageWidth;
+ (CGFloat)margin;
+ (CGFloat)inactiveAlpha;
+ (CGFloat)animationDuration;
+ (CGFloat)activeDuration;
+ (CGPoint)getCenterWithIndex:(NSInteger)index;
@end
