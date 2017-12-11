//
//  TPDRevokedQuotesAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDRevokedQuotesAPI : TPBaseAPI

- (instancetype)initWithQuotesIds:(NSArray <NSString *> *)quotesIds;
@end
