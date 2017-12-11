//
//  TPDOrderDetailShipperInfoModel.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/12.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDOrderDetailShipperInfoModel : NSObject
/*
 owner_id	货主id	是	string
 owner_name	货主姓名	是	string
 owner_mobile	货主手机号	是	string
 owner_icon_key	货主头像key	是	string
 owner_icon_url	货主头像URL	是	string
 owner_make_a_bargain_sum	货主成交总数	是	string
 owner_comment_level	货主发货好评度	是	string
 */

@property (nonatomic, copy) NSString * owner_id;
@property (nonatomic, copy) NSString * owner_name;
@property (nonatomic, copy) NSString * owner_mobile;
@property (nonatomic, copy) NSString * owner_icon_key;
@property (nonatomic, copy) NSString * owner_icon_url;
@property (nonatomic, copy) NSString * owner_make_a_bargain_sum;
@property (nonatomic, copy) NSString * owner_comment_level;

@end
