//
//  TPDModifyAuthenticationAPI.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"
@class TPDAuthenticationModel;
@interface TPDModifyAuthenticationAPI : TPBaseAPI
- (instancetype)initWithModel:(TPDAuthenticationModel *)model;
@end
