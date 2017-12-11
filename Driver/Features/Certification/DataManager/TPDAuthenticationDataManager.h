//
//  TPDAuthenticationDataManager.h
//  Driver
//
//  Created by Mr.mao on 2017/10/27.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPVerifiedDefines.h"

@class TPDAuthenticationModel;

@interface TPDAuthenticationDataManager : NSObject

/**
 修改身份认证

 @param model 身份认证model
 @param completeBlock 请求回调
 */
- (void)modifyAuthenticationWithModel:(TPDAuthenticationModel * _Nonnull)model completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;


/**
 获取身份认证

 @param completeBlock 请求回调
 */
- (void)getAuthenticationWithCompleteBlock:(RequestModelCompleteBlock _Nonnull )completeBlock;

@end
