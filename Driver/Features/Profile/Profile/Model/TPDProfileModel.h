//
//  TPDProfileModel.h
//  TopjetPicking
//
//  Created by lish on 2017/10/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDProfileModel : NSObject

//用户头像key
@property (nonatomic , copy) NSString *icon_image_key;

//用户头像url
@property (nonatomic , copy) NSString *icon_image_url;

//用户头像审核状态 0、未认证 1、认证中 2、认证失败 3、认证通过
@property (nonatomic , copy) NSString *icon_image_status;

//用户姓名
@property (nonatomic , copy) NSString *user_name;

//用户实名认证状态 0、未认证 1、待审核 2、审核通过 3、资料修改待审核 4、认证失败
@property (nonatomic , copy) NSString *use_status;

//车辆认证状态 1 未认证 2 已认证 3 认证中 4 认证失败
@property (nonatomic , copy) NSString *audit_status;

//签到状态
@property (nonatomic , copy) NSString *sign_status;

//获得的积分
@property (nonatomic , copy) NSString *obtain_integral;

//好评度
@property (nonatomic , copy) NSString *degree_of_praise;

//积分总额
@property (nonatomic , copy) NSString *integral_amount;

//钱包余额
@property (nonatomic , copy) NSString *wallet_balance;

//身份认证状态 0、未认证 1、认证中 2、认证失败 3、认证通过
@property (nonatomic , copy) NSString *user_auth_status;

//推荐人姓名
@property (nonatomic , copy) NSString *recommend_name;

@end
