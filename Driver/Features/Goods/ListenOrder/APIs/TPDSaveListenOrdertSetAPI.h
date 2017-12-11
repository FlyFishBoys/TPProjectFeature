//
//  TPDSaveListenOrdertSetAPI.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseAPI.h"

@interface TPDSaveListenOrdertSetAPI : TPBaseAPI


/**
 保存听单设置

 @param depart 出发地设置
 @param optional 自选目的地设置
 @param commonArr 常跑目的地设置
 @return object
 */
- (instancetype)initWithDepartObject:(id)depart optional:(id)optional commonArr:(NSMutableArray *)commonArr ;
@end
