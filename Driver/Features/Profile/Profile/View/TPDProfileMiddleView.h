//
//  TPPersonalCenterMiddleCell.h
//  TopjetPicking
//
//  Created by lish on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDProfileDefines.h"
#import "TPDProfileViewModel.h"
@interface TPDProfileMiddleItem : UIView

//状态
@property (nonatomic , copy) NSString *statusStr;

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon gestureRecognizer:(void(^)(void))gestureRecognizer;

@end
@interface TPDProfileMiddleView : UIView

- (instancetype)initWithIcons:(NSArray *)icons titles:(NSArray *)titles handler:(TPDProfileMiddleItemHandler)handelr;


- (void)blindViewModel:(TPDProfileViewModel *)viewModel;

@end
