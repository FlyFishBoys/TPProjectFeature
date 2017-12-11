//
//  NetWorkManagerCenter.m
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "NetWorkManagerCenter.h"
#import "BusinessConstants.h"
#import "LoginDataRequest.h"

@implementation NetWorkManagerCenter

+(id)shareInstance
{
    static NetWorkManagerCenter * netWorkManagerCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWorkManagerCenter = [[NetWorkManagerCenter alloc]init];
    });
    return netWorkManagerCenter;
}


-(void)requestWithDestination:(NSString*)destination forViewModel:(id)viewModel  completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
    //登录
    if ([destination isEqualToString:Business_Login]) {
        
        [[[LoginDataRequest alloc]init]requestForViewModel:viewModel completionHandler:completionHandler];

    }
    
    
    
}



@end
