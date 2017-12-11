//
//  TPDVehicleCertificationDataManager.h
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPVerifiedDefines.h"
@class TPDVehicleCertificationModel;

@interface TPDVehicleCertificationDataManager : NSObject

- (void)modifyVehicleCertificationWithModel:(TPDVehicleCertificationModel * _Nonnull)model completeBlock:(RequestCompleteBlock _Nonnull )completeBlock;

- (void)getVehicleCertificationWithCompleteBlock:(RequestViewModelCompleteBlock _Nonnull )completeBlock;

@end
