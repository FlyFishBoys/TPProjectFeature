//
//  TPDProfileRouterEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileRouterEntry.h"
#import "TPDCallRecordsViewController.h"
#import "TPDIntegralRecordController.h"
@implementation TPDProfileRouterEntry
+ (void)load {
    [self registerCallRecords];
    [self registerIntegralRecord];
}
+ (void)registerCallRecords {
    
    [MGJRouter registerURLPattern:TPRouter_CallRecords toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDCallRecordsViewController *vc = [[TPDCallRecordsViewController alloc]init];
        return vc;
    }];
  
    
    
}
+ (void)registerIntegralRecord {
    
    [MGJRouter registerURLPattern:TPRouter_IntegralRecord toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDIntegralRecordController *vc = [[TPDIntegralRecordController alloc]init];
        return vc;
    }];
    
    
    
}
@end
