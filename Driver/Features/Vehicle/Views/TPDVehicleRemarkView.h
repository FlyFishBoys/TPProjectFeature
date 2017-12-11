//
//  TPDVehicleRemarkView.h
//  Driver
//
//  Created by Mr.mao on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDVehicleDefines.h"

@interface TPDVehicleRemarkView : UIView


/**
 输入完成后的回调
 */
@property (nonatomic, copy) void (^completeBlock)(NSString * text);

/**
 内容
 */
@property (nonatomic, copy) NSString * content;


/**
 初始化

 @param title 标题
 @param placeholder 提示
 @param limitedRegEx  限制的正则字符
 @param isHasSeprate  是否有分割线
 @return 初始化对象
 */
- (instancetype)initWithTitle:(NSString *)title placeholder:(NSString *)placeholder limitedRegEx:(NSString *)limitedRegEx isHasSeprate:(BOOL)isHasSeprate;

/**
 初始化
 
 @param type 类型
 @return 初始化对象
 */
- (instancetype)initWithType:(TPDVehicleRemarkViewType)type;
@end
