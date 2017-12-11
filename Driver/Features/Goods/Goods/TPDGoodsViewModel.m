//
//  TPDGoodsViewModel.m
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsViewModel.h"
#import "NSString+TimesTamp.h"
@implementation TPDGoodsItemViewModel

- (instancetype)initWithGoodsModel:(TPDGoodsModel *)goodsModel target:(id)target {
    
    
    self = [super init];
    if (self) {
        self.target = target;
        self.goodsModel = goodsModel;
        
        self.depart_address = [_goodsModel.depart_city stringByReplacingOccurrencesOfString:@"null" withString:@""];
        self.destination_address = [_goodsModel.destination_city stringByReplacingOccurrencesOfString:@"null" withString:@""];
        self.update_time = [_goodsModel.update_time convertedToUpdatetime];
        self.details =[[[_goodsModel.the_goods stringByAppendingString:@"  "]stringByAppendingString:_goodsModel.tuck_length_type]stringByReplacingOccurrencesOfString:@"null" withString:@""];
        self.name = [_goodsModel.owner_info.owner_name stringByReplacingOccurrencesOfString:@"null" withString:@""];
        self.rate = _goodsModel.owner_info.owner_comment_level;
        self.is_examine = _goodsModel.is_examine;
        self.is_call = _goodsModel.is_call;
        self.is_receive_order = _goodsModel.is_receive_order;
        self.isAnonymous = _goodsModel.owner_info.is_anonymous.intValue;
        if (self.isAnonymous) {
            NSString *anonymousImageName = _goodsModel.owner_info.sex.intValue ==1 ?@"common_female_placeholder":@"common_male_placeholder";
            self.anonymousImage = [UIImage imageNamed:anonymousImageName];
        }
        

        
        
    }
    return self;
    
}

@end

@implementation TPDGoodsViewModel

- (instancetype)initWithGoodsModels:(NSArray <TPDGoodsModel*> *)goodsModels target:(id)target {
    
    self = [super init];
    if (self) {
        
        _itemViewModels = [NSMutableArray array];
        
        [goodsModels enumerateObjectsUsingBlock:^(TPDGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            TPDGoodsItemViewModel *cellViewModel = [[TPDGoodsItemViewModel alloc] initWithGoodsModel:obj target:target];
            
            [_itemViewModels addObject:cellViewModel];
            
        }];
    }
    return self;
}

@end
