//
//  TPDEnterCodeView.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPDEnterCodeView;

typedef void(^TPDEnterCodeViewCompleteBlock)(TPDEnterCodeView * view,NSString * code);

@interface TPDEnterCodeView : UIView

/**
 完成的block
 */
@property (nonatomic,copy) TPDEnterCodeViewCompleteBlock completeBlock;


/**
打电话的block
 */
@property (nonatomic,copy) void(^callBlock)(void);

/**
 初始化

 @param code 提货码/签收码
 @param name 姓名
 @param mobile 电话号码
 @param title 标题
 @param callTitle 呼叫标题
 @return 初始化对象
 */
-(instancetype)initWithCode:(NSString *)code name:(NSString *)name moblie:(NSString *)mobile title:(NSString *)title callTitle:(NSString *)callTitle;

/**
 显示
 */
-(void)show;


/**
 消失
 */
-(void)dismiss;
@end
