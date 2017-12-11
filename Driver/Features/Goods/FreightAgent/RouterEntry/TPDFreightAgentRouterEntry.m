//
//  TPDFreightAgentRouterEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreightAgentRouterEntry.h"
#import "TPDFreightAgentView.h"
#import "TPDFreightAgentDataManager.h"
@implementation TPDFreightAgentRouterEntry
+ (void)load {

    [self registerFreightAgentView];
    [self registerFetchFreightAgent];
}

+ (void)registerFreightAgentView {
    
    [MGJRouter registerURLPattern:TPRouter_FreightAgentView toHandler:^(NSDictionary *routerParameters) {
        
        NSString *departCode = routerParameters[MGJRouterParameterUserInfo][@"departCode"];
         NSString *destinationCode = routerParameters[MGJRouterParameterUserInfo][@"destinationCode"];
        
        TPDFreightAgentView *view = [[TPDFreightAgentView alloc]initWithFreightAgentViewDepartCode:departCode destinationCode:destinationCode];
        [view show];

    }];
}


//获取是否有货运经济人
+ (void)registerFetchFreightAgent {
    
    
    [MGJRouter registerURLPattern:TPRouter_Fetch_FreightAgent toHandler:^(NSDictionary *routerParameters) {
        NSString *departCode = routerParameters[MGJRouterParameterUserInfo][@"departCode"];
        NSString *destinationCode = routerParameters[MGJRouterParameterUserInfo][@"destinationCode"];
        
        TPDFreightAgentDataManager *dataManager = [[TPDFreightAgentDataManager alloc]init];
        [dataManager fetchHaveFreightAgentWithDepartCode:departCode destinationCode:destinationCode];
        dataManager.fetchFreightAgentComplete = routerParameters[MGJRouterParameterUserInfo][MGJRouterParameterCompletion];
    
    }];
    
}
@end
