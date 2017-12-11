//
//  TPDQuotesListAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDQuotesListAPI : TPBaseAPI

- (instancetype)initWithPage:(NSInteger)page longitude:(NSString *)longitude latitude:(NSString *)latitude;

@end
