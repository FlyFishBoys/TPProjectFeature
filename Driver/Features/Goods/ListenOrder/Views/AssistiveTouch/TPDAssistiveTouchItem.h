//
//  TPDAssistiveTouchItem.h
//  TPAssistiveTouch
//
//  Created by leeshuangai on 2017/8/27.
//  Copyright © 2017年 李爽. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TPDAssistiveTouchItemTapBlock)(UIButton *btn);
@interface TPDAssistiveTouchItem : UIButton
+ (instancetype)creatItemWithFrame:(CGRect)frame;
@property (nonatomic , copy) TPDAssistiveTouchItemTapBlock tapBlock;
@property (nonatomic , assign) NSInteger btnTag;
@end
