//
//  TPDFreighAgentListAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreighAgentListAPI.h"

@implementation TPDFreighAgentListAPI
{
    
    NSString *_beginCity,*_endCity,*_page;
}
- (instancetype)initWithBeginCity:(NSString *)beginCity endCity:(NSString *)endCity page:(NSString *)page{
    
    self = [super init];
    if (self) {
        _beginCity = beginCity;
        _endCity = endCity;
        _page = page;
    }
    return self;
    
}
- (id)businessParameters {
    return @{
             @"begin_city":_beginCity?_beginCity:@"",
             @"end_city":_endCity?_endCity:@"",
             @"page":_page?_page:@""
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/transport/economiclist";
}

- (NSString *)destination {
    
    return @"transport.economiclist";
}


@end
