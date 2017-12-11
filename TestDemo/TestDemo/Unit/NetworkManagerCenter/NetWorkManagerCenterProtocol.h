//
//  NetWorkManagerCenterProtocol.h
//  TestDemo
//
//  Created by sunwf on 2017/11/24.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetWorkManagerCenterProtocol <NSObject>

/**
 具体的接口请求
 
 @param destination  业务常量 如 BusinessLogin
 @param viewModel 负责调用接口的对象
 @param completionHandler 接口的回调
 
 */
-(void)requestWithDestination:(NSString*)destination forViewModel:(id)viewModel completionHandler:(void (^)(NSData *  data, NSURLResponse *  response, NSError *  error))completionHandler;

@end
