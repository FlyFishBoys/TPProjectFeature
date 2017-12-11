//
//  NSData+AES128.h
//
//  Created by Topjet on 16/7/21.
//  Copyright © 2016年 Topject. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES128)
- (NSData *)AES128EncryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //加密
- (NSData *)AES128DecryptWithKey:(NSString *)key gIv:(NSString *)Iv;   //解密
@end
