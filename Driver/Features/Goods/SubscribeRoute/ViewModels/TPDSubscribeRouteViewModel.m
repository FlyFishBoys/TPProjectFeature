//
//  TPDSubscribeRouteViewModel.m
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSubscribeRouteViewModel.h"
@implementation TPDSubscribeRouteCellViewModel

- (void)blindCellViewModel:(TPDSubscribeRouteModel *)model isEdit:(BOOL)isEdit{
    
    self.depart_city = model.depart_city;
    self.destination_city = model.destination_city;
    self.supply_of_goods_count = model.supply_of_goods_count;
    self.truck_detail = model.truck_type_length ;
    self.is_edit = isEdit;
    self.is_select = NO;
    self.subscribeRouteModel = model;
}

@end
@implementation TPDSubscribeRouteViewModel

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _is_edit = NO;
        _deleteSubscribeRouteIdArr = [NSMutableArray array];
    }
    return self;
}

- (void)blindViewModel:(NSMutableArray <TPDSubscribeRouteModel *>*)subscribeRouteArr allBadge:(NSString *)allBadge {
    
    self.allBadge = allBadge;
    _subscribeRouteCellModelArr  = [NSMutableArray array];
    [subscribeRouteArr enumerateObjectsUsingBlock:^(TPDSubscribeRouteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        TPDSubscribeRouteCellViewModel *cellViewModel = [[TPDSubscribeRouteCellViewModel alloc]init];
        [cellViewModel blindCellViewModel:obj isEdit:_is_edit];
        [_subscribeRouteCellModelArr addObject:cellViewModel];
    }];
    
}
- (void)deleteObject:(TPDSubscribeRouteCellViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    
    object.is_select = !object.is_select;
    
    if ([self.deleteSubscribeRouteIdArr containsObject:object.subscribeRouteModel.subscribe_line_id]) {
        [self.deleteSubscribeRouteIdArr  removeObject:object.subscribeRouteModel.subscribe_line_id];
    }else{
        
        [self.deleteSubscribeRouteIdArr addObject:object.subscribeRouteModel.subscribe_line_id];
    }
    
}
- (void)setIs_edit:(BOOL)is_edit {
    
    _is_edit = is_edit;
    [self.subscribeRouteCellModelArr enumerateObjectsUsingBlock:^(TPDSubscribeRouteCellViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.is_edit = self.is_edit;
        if (self.is_edit) {
            obj.is_select = NO;
            [self.deleteSubscribeRouteIdArr removeAllObjects];
        }
    }];
}
@end
