//
//  TPDColorPlateView.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDColorPlateView : UIView

/**
 车牌颜色代码：2：黄色  1：蓝色
 */
@property (nonatomic,copy) NSString * plateColor;

/**
 是否能修改
 */
@property (nonatomic,assign) BOOL isEnble;

/**
 选择车牌颜色后的回调
 */
@property (nonatomic, copy) void (^colorPlateCompleteBlock)(NSString * plateColor);
@end
