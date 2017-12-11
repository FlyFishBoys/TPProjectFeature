//
//  TPDJudgeFreighAgentAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDJudgeFreighAgentAPI.h"

@implementation TPDJudgeFreighAgentAPI {
    
    NSString *_beginCity,*_endCity;
}
- (instancetype)initWithBeginCity:(NSString *)beginCity endCity:(NSString *)endCity {
    
    self = [super init];
    if (self) {
        _beginCity = beginCity;
        _endCity = endCity;
    }
    return self;
    
}
- (id)businessParameters {
    return @{
             @"begin_city":_beginCity?_beginCity:@"",
             @"end_city":_endCity?_endCity:@""
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/transport/iseconomic";
}

- (NSString *)destination {
    
    return @"transport.iseconomic";
}
@end
