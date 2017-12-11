//
//  TPDIntegrityInquiryAPI.h
//  Driver
//
//  Created by Mr.mao on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDIntegrityInquiryAPI : TPBaseAPI


/**
 诚信查询

 @param mobile 电话号码
 @return 初始化对象
 */
- (instancetype)initWithMobile:(NSString *)mobile;
@end
