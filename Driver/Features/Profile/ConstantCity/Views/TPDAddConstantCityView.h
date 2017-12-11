//
//  TPDAddConstantCityView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//
//添加常跑城市view
#import <UIKit/UIKit.h>
#import "TPDAddConstantCityDefines.h"
typedef void(^AddConstantCityDismissBlock)();
@interface TPDAddConstantCityView : UIView

- (instancetype)initWithSelectViewType:(SELECTVIEW_TYPE)selectView_type;

@property (nonatomic,copy) AddConstantCityDismissBlock dismissBlock;

- (void)show;

@end
