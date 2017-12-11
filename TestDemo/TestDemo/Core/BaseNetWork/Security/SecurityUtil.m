//
//  SecurityUtil.m
//  Shipper
//
//  Created by Topjet on 16/7/21.
//  Copyright © 2016年 Topject. All rights reserved.
//

#import "SecurityUtil.h"
#import "Base64.h"
#import "NSData+AES128.h"
#define Iv          @"aaaaaaaaaa" //偏移量,可自行修改
#define KEY         @"bbbbbbbbbb" //key，可自行修改

@implementation SecurityUtil

#pragma mark - base64
+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [Base64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
    
}

+ (NSString*)decodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [Base64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [Base64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
    data = [Base64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

#pragma mark - AES加密
+(NSString *)encryptAESRequestParam:(NSDictionary *)requestParam {
    
    if (requestParam == nil) return @"";
    
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestParam options:NSJSONWritingPrettyPrinted error:nil];
    NSString *requestString = [[NSString alloc] initWithData:requestData encoding:NSUTF8StringEncoding];
    //将nsstring转化为nsdata
    NSData *data = [requestString dataUsingEncoding:NSUTF8StringEncoding];
    //使用密码对nsdata进行加密
    NSData *encryptedData = [data AES128EncryptWithKey:KEY gIv:Iv];
    //返回进行base64进行转码的加密字符串
    return [self encodeBase64Data:encryptedData];
}

#pragma mark - AES解密
+(NSDictionary *)decryptAESData:(NSData *)responseData {
    
    if (responseData == nil) return @{};
    
    NSString *Base64String = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    Base64String  = [Base64String stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\""]];
    //base64解密
    NSData *decodeBase64Data = [Base64 decodeString:Base64String];
    //使用密码对data进行解密
    NSData *decryData = [decodeBase64Data AES128DecryptWithKey:KEY gIv:Iv];
    //将解了密码的nsdata转化为nsstring
    NSDictionary *responseDic ;
    if (decryData) {
       responseDic = [NSJSONSerialization JSONObjectWithData:decryData options:NSJSONReadingMutableContainers error:nil];
    }
    
    return responseDic;
}


@end
