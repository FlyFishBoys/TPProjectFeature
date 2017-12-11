//
//  TPDAssistiveTouchLayoutAttributes.m
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/26.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import "TPDAssistiveTouchLayoutAttributes.h"

@implementation TPDAssistiveTouchLayoutAttributes
+ (CGRect)spreadContentViewFrame {
    CGFloat spreadWidth = TPAdaptedWidth(268);
    CGFloat spreadHeight = TPAdaptedHeight(238);
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    CGRect frame = CGRectMake((CGRectGetWidth(screenFrame) - spreadWidth) / 2,
                              (CGRectGetHeight(screenFrame) - spreadHeight-64) / 2,
                              spreadWidth, spreadHeight);
    return frame;
}

+ (CGPoint)cotentViewDefaultPoint {
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    CGPoint point = CGPointMake(CGRectGetWidth(screenFrame)
                                - [self ATItemImageWidth] / 2
                                - [self margin],
                                CGRectGetMidY(screenFrame));
    return point;
}
+ (CGFloat)ATContenItmeWidth {


    return TPAdaptedWidth(60);
}
+ (CGFloat)ATContenItmeheight {
   

    return  TPAdaptedHeight(74);
}

+ (CGFloat)ATItemImageWidth {
    return  TPAdaptedWidth(60)>60?60:TPAdaptedWidth(60);
}

+ (CGFloat)margin {
    return 2;
}


+ (CGFloat)inactiveAlpha {
    return 0.4;
}

+ (CGFloat)animationDuration {
    return 0.25;
}

+ (CGFloat)activeDuration {
    return 4;
}

+ (CGPoint)getCenterWithIndex:(NSInteger)index {

    CGFloat angle = 5 * M_PI_2 - M_PI * 2 / 3 * index;
    CGFloat k = tan(angle);
    CGFloat x;
    CGFloat y;
    if (M_PI_4 * 9 < angle || angle <= M_PI_4 * 3) {
        y = [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] + TPAdaptedWidth(17) ;
        if (angle == M_PI_2 * 5 || angle == M_PI_2 * 3) {
            x = 0;
        } else {
            x = y / k;
        }
    } else if (M_PI_4 * 7 < angle && angle <= M_PI_4 * 9) {
        x = [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] + TPAdaptedWidth(10);
        y = k * x;
    } else if (M_PI_4 * 3 < angle && angle <= M_PI_4 * 5) {
        x = - [TPDAssistiveTouchLayoutAttributes ATItemImageWidth] - TPAdaptedWidth(10);
        y = k * x;
    }
    CGPoint center = [self coordinatesTransform:CGPointMake(x, y)];
    
    return center;
}



+ (CGPoint)coordinatesTransform:(CGPoint)point {
    CGRect rect = [UIScreen mainScreen].bounds;
    CGPoint screenCenter = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    point.y = -point.y;
    CGPoint transformPoint = CGPointMake(screenCenter.x + point.x,
                                         screenCenter.y + point.y);
    return transformPoint;
}

@end
