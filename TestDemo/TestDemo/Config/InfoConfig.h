//
//  InfoConfig.h
//  TestDemo
//
//  Created by sunwf on 2017/11/20.
//  Copyright © 2017年 sunwf. All rights reserved.
//

#import <UIKit/UIKit.h>


#ifdef DEBUG
#define DDLog(format, ...) printf("class: <%p %s:(%d) > method: %s \n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:(format), ##__VA_ARGS__] UTF8String] )
#else
#define DDLog(format, ...)
#endif



//网络请求服务端地址
#define kBASE_URL @"https://test2jyph.566560.com/560v2/call200"

