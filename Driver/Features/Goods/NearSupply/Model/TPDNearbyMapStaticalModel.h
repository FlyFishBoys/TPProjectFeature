//
//  TPDNearbyMapStaticalModel.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDGoodsModel.h"

@interface TPDNearbyMapStaticalModel : NSObject

@property (nonatomic,copy) NSString * total;

@property (nonatomic,strong) NSArray <TPDGoodsModel *> * near_goods_response_list;

@end
