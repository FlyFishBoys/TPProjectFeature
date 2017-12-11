//
//  TPDProfileViewModel.h
//  TopjetPicking
//
//  Created by lish on 2017/10/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDProfileModel.h"
@interface TPDProfileViewModel : NSObject

@property (nonatomic , strong) TPDProfileModel *model;

@property (nonatomic , copy) NSString *name;

//用户实名认证状态
@property (nonatomic , copy) NSString *userStatus;

//实名认证图标
@property (nonatomic , strong) UIImage *userStatusIcon;

//用户头像审核状态
@property (nonatomic , copy) NSString *iconImageStatus;

//用户头像审核图标
@property (nonatomic , strong) UIImage *usericonAuditImage;

//身份认证状态
@property (nonatomic , copy) NSString *userAuthStatus;

//匿名状态
@property (nonatomic , copy) NSString *anonymityStatus;

//签到状态
@property (nonatomic , copy) NSString *signStatus;

//是否签到
@property (nonatomic , assign) BOOL isSignIn;

//车辆认证状态
@property (nonatomic , copy) NSString *vehicleStatus;

//获得的积分
@property (nonatomic , copy) NSString *obtainIntegral;

- (void)blindViewModel:(TPDProfileModel *)model;


@end
