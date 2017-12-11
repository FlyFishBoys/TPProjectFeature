//
//  TPDVehicleDetailView.h
//  Driver
//
//  Created by Mr.mao on 2017/10/23.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TPDVehicleDetailViewLayoutType) {
    TPDVehicleDetailViewLayoutType_Right = 100,//靠右布局
    TPDVehicleDetailViewLayoutType_Left,//靠左布局
};

@interface TPDVehicleDetailView : UIView

@property (nonatomic, copy) NSString * content;

/**
 初始化

 @param title 标题
 @param content 内容
 @param layoutType 布局类型
 @return 初始化对象
 */
- (instancetype)initWithTitle:(NSString *)title content:(NSString *)content layoutType:(TPDVehicleDetailViewLayoutType)layoutType isHasSeprate:(BOOL)isHasSeprate;
@end
