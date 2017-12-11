//
//  TPDDeleteSubscribeRoutetAPI.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDDeleteSubscribeRoutetAPI.h"

@implementation TPDDeleteSubscribeRoutetAPI {
    
    NSMutableArray *_listArr;
    
}

- (instancetype)initWithRouteIdList:(NSMutableArray *)list {
    
    if (self = [super init]) {
        
        _listArr = [NSMutableArray arrayWithArray:list];
    }
    
    return self;
}


- (id)businessParameters {
    return @{
             @"subscribe_line_id_list":_listArr
             };
    
}

- (NSString *)requestMethod {
    
    return @"order-service/subscribeline/deletesubscribeline";
}

- (NSString *)destination {
    
    return @"subscribeline.deletesubscribeline";
}
@end
