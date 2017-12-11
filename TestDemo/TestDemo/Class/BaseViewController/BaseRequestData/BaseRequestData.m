//
//  BaseRequestData.m
//  TestDemo
//
//  Created by sunwf on 2017/12/7.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import "BaseRequestData.h"

@implementation BaseRequestData

-(void)requestWithDestination:(NSString*)destination paramDic:(NSDictionary*)paramDic finishBlock:(RequstDataHandle)handle
{
    self.destination = destination;
    self.paramDic = paramDic;
    
    NSURL * url = [NSURL URLWithString:@"https://www.baidu.com"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    NSURLSession * session = [NSURLSession sharedSession];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"destination --- %@\n paramDic = %@",destination,paramDic);
            
            if (handle) {
                handle(data,response,error);
            }
        });
        
    }];
    
    [dataTask resume];
    
}

@end
