//
//  TPDCallRecordItem.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPDCallRecordShippr : NSObject

@property (nonatomic,copy) NSString * owner_id;

@property (nonatomic,copy) NSString * owner_name;

@property (nonatomic,copy) NSString * owner_icon_url;

@property (nonatomic,copy) NSString * owner_icon_key;

@property (nonatomic,copy) NSString * owner_comment_level;

@property (nonatomic,copy) NSString * owner_mobile;

@property (nonatomic,copy) NSString * sex;

@property (nonatomic,copy) NSString * is_anonymous;

@end

@interface TPDCallRecordItem : NSObject

@property (nonatomic,copy) NSString * depart_city;

@property (nonatomic,copy) NSString * destination_city;

@property (nonatomic,copy) NSString * the_goods;

@property (nonatomic,copy) NSString * tuck_length_type;

@property (nonatomic,copy) NSString * goods_id;

@property (nonatomic,copy) NSString * goods_version;

@property (nonatomic,copy) NSString * goods_status;

@property (nonatomic,copy) NSString * call_time;

@property (nonatomic,copy) NSString * create_time;

@property (nonatomic,strong) TPDCallRecordShippr * shipprModel;

@end
