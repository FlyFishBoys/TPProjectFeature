//
//  TPSCertificationRouterEntry.h
//  TopjetPicking
//
//  Created by lish on 2017/9/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDCertificationRouterEntry : NSObject
//身份认知
+ (void)registerAuthentication;
//车辆认证
+ (void)registerVehicleCertification;
@end
