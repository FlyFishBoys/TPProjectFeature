//
//  TPDSubscribeRouteViewModel.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
#import "TPDSubscribeRouteModel.h"
@interface TPDSubscribeRouteCellViewModel:TPBaseTableViewItem

@property (nonatomic , assign) BOOL is_select;//是否是编辑状态

@property (nonatomic , assign) BOOL is_edit;//是否是编辑状态

@property (nonatomic, copy) NSString *depart_city;//出发地城市

@property (nonatomic, copy) NSString *destination_city;//目的地城市

@property (nonatomic, copy) NSString *truck_detail;//车型车长

@property (nonatomic, copy) NSString *supply_of_goods_count;//订阅路线货源总数

@property (nonatomic , strong) TPDSubscribeRouteModel *subscribeRouteModel;

@end

@interface TPDSubscribeRouteViewModel : TPBaseTableViewItem

@property (nonatomic , copy) NSString *allBadge;//订阅路线货源总数

@property (nonatomic , assign) BOOL is_edit;//是否是编辑状态

@property (nonatomic , strong) NSMutableArray <TPDSubscribeRouteCellViewModel *> *subscribeRouteCellModelArr;

@property (nonatomic , strong) NSMutableArray *deleteSubscribeRouteIdArr;//删除的订阅路线id


- (void)blindViewModel:(NSMutableArray <TPDSubscribeRouteModel *>*)subscribeRouteArr allBadge:(NSString *)allBadge;

//删除或者是选中某一项时
- (void)deleteObject:(TPDSubscribeRouteCellViewModel *)object atIndexPath:(NSIndexPath *)indexPath;

@end
