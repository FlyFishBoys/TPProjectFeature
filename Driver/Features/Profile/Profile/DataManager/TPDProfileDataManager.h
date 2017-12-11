//
//  TPDProfileDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/10/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^TPDProfileDataManagerRequestComplete)(BOOL succeed,id _Nullable responseObject,TPBusinessError * _Nullable error);
@interface TPDProfileDataManager : NSObject

+ (void)requestPersonCenterParameterWithComplete:(TPDProfileDataManagerRequestComplete)complete;


/**
 签到接口

 @param complete 完成
 */
+ (void)requestSignInAPIWithComplete:(TPDProfileDataManagerRequestComplete)complete;
@end
