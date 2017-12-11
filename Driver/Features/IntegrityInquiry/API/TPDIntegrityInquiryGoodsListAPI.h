//
//  TPDIntegrityInquiryGoodsListAPI.h
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"


@interface TPDIntegrityInquiryGoodsListAPI : TPBaseAPI

/**
 初始化
 
 @param userId 订单状态  货主id
 @param page 页数       初始为1
 @return 初始化对象
 */
- (instancetype)initWithUserId:(NSString *)userId page:(NSInteger)page;

@end
