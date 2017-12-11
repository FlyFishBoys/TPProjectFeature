//
//  TPDCallRecordItem.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCallRecordItem.h"

@implementation TPDCallRecordShippr
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy];}
@end

@implementation TPDCallRecordItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"shipprModel" : @"owner_info"};
}
@end
