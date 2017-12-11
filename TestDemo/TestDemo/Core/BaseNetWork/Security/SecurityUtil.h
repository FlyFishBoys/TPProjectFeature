//
//  SecurityUtil.h
//  Shipper
//
//  Created by Topjet on 16/7/21.
//  Copyright © 2016年 Topject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecurityUtil : NSObject
#pragma mark - AES
/**
 *  将字典对象转换成字符串然后进行AES加密，在base64编码
 *
 *  @param requestParam 请求的字典对象
 *
 *  @return 加密后的base64字符串
 */
+(NSString *)encryptAESRequestParam:(NSDictionary *)requestParam;
/**
 *  将二进制数据转换成base64字符串然后解码base64，在进行AES解密
 *
 *  @param responseData 相应的二进制数据
 *
 *  @return json响应体
 */
+(NSDictionary *)decryptAESData:(NSData *)responseData;

#pragma mark - base64
/**
 *  base64编码
 *
 *  @param input 数据
 *
 *  @return 编码后的字符串
 */
+ (NSString*)encodeBase64String:(NSString *)input;
/**
 *  base64解码
 *
 *  @param input 数据
 *
 *  @return 编码后的字符串
 */
+ (NSString*)decodeBase64String:(NSString *)input;
/**
 *  base64编码
 *
 *  @param data 数据
 *
 *  @return 编码后的字符串
 */
+ (NSString*)encodeBase64Data:(NSData *)data;
/**
 *  base64解码
 *
 *  @param data 数据
 *
 *  @return 编码后的字符串
 */
+ (NSString*)decodeBase64Data:(NSData *)data;
@end
