//
//  TPDSaveListenOrderSwitchStatusAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSaveListenOrderSwitchStatusAPI.h"

@implementation TPDSaveListenOrderSwitchStatusAPI{
    NSString *_status;
}

- (instancetype)initWithStatus:(NSString *)status {
    
    self = [super init];
    if (self) {
        _status = status;
    }
    return self;
}

- (id)businessParameters {
    return @{
             @"status":_status
             };
    
}

- (NSString *)requestMethod {
    
    return @"/order-service/listengoods/updatestatus";
}

- (NSString *)destination {
    
    return @"listengoods.updatestatus";
}

@end
