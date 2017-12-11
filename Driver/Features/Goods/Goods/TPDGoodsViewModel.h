//
//  TPDGoodsViewModel.h
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"


@class TPDGoodsItemViewModel;
#import "TPDGoodsModel.h"
@interface TPDGoodsItemViewModel:TPBaseTableViewItem

@property (nonatomic , copy) NSString *depart_address;//出发地

@property (nonatomic , copy) NSString *destination_address;//目的地

@property (nonatomic , copy) NSString *update_time;//更新时间

@property (nonatomic , copy) NSString *details;//详情

@property (nonatomic , copy) NSString *name;//姓名

@property (nonatomic , copy) NSString *rate;//评级

@property (nonatomic , copy) NSString *is_call;//是否对此货源拨打过电话 0:没打过 1：打过

@property (nonatomic , copy) NSString *is_examine;//是否查看过货源

@property (nonatomic , copy) NSString *is_receive_order;//是否接单过

@property (nonatomic , strong) UIImage *anonymousImage;//匿名头像

@property (nonatomic , assign) BOOL isAnonymous;//是否匿名

@property (nonatomic , strong) TPDGoodsModel *goodsModel;

@end

@interface TPDGoodsViewModel : TPBaseTableViewItem


@property (nonatomic , strong) NSMutableArray <TPDGoodsItemViewModel *> *itemViewModels;

- (instancetype)initWithGoodsModels:(NSArray <TPDGoodsModel*> *)goodsModels target:(id)target;


@end
