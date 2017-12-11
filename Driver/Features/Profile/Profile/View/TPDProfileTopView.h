//
//  TPDProfileTopView.h
//  TopjetPicking
//
//  Created by lish on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDProfileViewModel.h"
typedef void (^TPDProfileTopViewTapButton)();
typedef void (^TPDProfileTopViewTapItem)(NSInteger index);
@interface TPDProfileTopItem : UIView

@property (nonatomic , copy) NSString *topStr;

@property (nonatomic , copy) NSString *bottomStr;

@property (nonatomic , copy) TPDProfileTopViewTapButton tapItemHandle;

@end
@interface TPDProfileTopView : UIView

@property (nonatomic , copy) TPDProfileTopViewTapButton tapSetIconHandle;

@property (nonatomic , copy) TPDProfileTopViewTapButton tapMessageIconHandle;

//点击中间item 返回的index  0评价 1是积分 2是钱包余额
@property (nonatomic , copy) TPDProfileTopViewTapItem tapItemHandle;

//点击签到
@property (nonatomic , copy) TPDProfileTopViewTapButton tapSignInHandle;

//点击头像
@property (nonatomic , copy)  TPDProfileTopViewTapButton tapHeaderIconHandle;

- (void)showIcon:(BOOL)show;

- (void)blindViewModel:(TPDProfileViewModel *)viewModel;

@end
