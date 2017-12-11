//
//  TPDHomeFunctionItemAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDHomeFunctionItemAPI : TPBaseAPI


/**
 首页中间 功能按钮选项

 @param version 版本号
 @return object
 */
- (instancetype)initWithVersion:(NSString *)version;

@end
