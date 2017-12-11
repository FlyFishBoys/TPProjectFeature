//
//  TPDSaveListenOrderSwitchStatusAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDSaveListenOrderSwitchStatusAPI : TPBaseAPI

/**
 更改听单开关状态

 @param status 0:关闭 1:开启
 @return object
 */
- (instancetype)initWithStatus:(NSString *)status;
@end
