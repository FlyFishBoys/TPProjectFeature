//
//  TPDFreightAgrentViewModel.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreightAgrentViewModel.h"
@implementation TPDFreightAgrentItemViewModel


- (instancetype)initWithFreightAgrentModel:(TPDFreightAgrentModel *)model target:(id)target {
    
    self = [super init];
    if (self) {
        self.target = target;
        _model = model;
        _name = _model.name;
        //头像
        UIImageView *headerImage = [[UIImageView alloc]init];
        [headerImage tp_setOriginalImageWithURL:[NSURL URLWithString:_model.icon_url] md5Key:_model.icon_key placeholderImage:[UIImage imageNamed:@"smart_find_goods_user_image"]];
        _avatarImage = headerImage.image;
        
        //线下认证
        _authenticationIcon = [UIImage imageNamed:@"smart_find_goods_offline_approve_blue"];
        
        _title = @"经营路线:";
        
        _firstBrokerRoute = [[_model.broker_route_begin_city_1 stringByAppendingString:@"--"]stringByAppendingString:_model.broker_route_end_city_1];
        
        _secondBrokerRoute = [[_model.broker_route_begin_city_2 stringByAppendingString:@"--"]stringByAppendingString:_model.broker_route_end_city_2];
        
        _thirdBrokerRoute = [[_model.broker_route_begin_city_3 stringByAppendingString:@"--"]stringByAppendingString:_model.broker_route_end_city_3];
        
        //打电话图标
        _callIcon = [UIImage imageNamed:@"smart_find_goods_call_nor"];
        
        //聊天图标
        _messageIcon = [UIImage imageNamed:@"smart_find_goods_message_blue"];
    }
    return self;
}

@end
@implementation TPDFreightAgrentViewModel
- (instancetype)initWithFreightAgrentModels:(NSArray <TPDFreightAgrentModel *>*)models target:(id)target {
    self = [super init];
    if (self) {
        _viewModels = [NSMutableArray array];
        [models enumerateObjectsUsingBlock:^(TPDFreightAgrentModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TPDFreightAgrentItemViewModel *item = [[TPDFreightAgrentItemViewModel alloc]initWithFreightAgrentModel:obj target:target];
            [_viewModels addObject:item];
        }];
        
    }
    return self;
}

@end
