//
//  BeginGuideView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDBeginGuideView : UIView

/**
 新手引导页 -- 判断程序是不是第一次加载 是即运行新手指导页

 @param completeBlock YES 表示程序第一次加载并运行新手指导页
 */
+ (void)startBeginGuideCompleteBlock:(void(^)(BOOL isFirst))completeBlock;


/**
 加载新手指导页 无判断是不是第一次运行App

 @param completeBlock 加载完成
 @return 视图
 */
+ (instancetype)beginGuideViewCompleteBlock:(void(^)(void))completeBlock;

@end
