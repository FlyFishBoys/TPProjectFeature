//
//  TPDFreighAgentListAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDFreighAgentListAPI : TPBaseAPI
- (instancetype)initWithBeginCity:(NSString *)beginCity endCity:(NSString *)endCity page:(NSString *)page;
@end
