//
//  TPDDestinationViewModel.h
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TPBaseTableViewItem.h"

@class TPDConstantCityModel;

@interface TPDestinationItemViewModel : TPBaseTableViewItem


@property (nonatomic , copy)   NSString *bussiness_line_id; //常跑城市line-ID

@property (nonatomic , copy)   NSString *driver_id;//司机id

@property (nonatomic , copy)   NSString *business_line_city;//司机id

@property (nonatomic , copy)   NSString *business_line_city_id;//常跑城市id

@property (nonatomic , assign) BOOL isSelectCell;


- (instancetype)initWithModel:(TPDConstantCityModel *)model;


@end


@interface TPDDestinationViewModel : NSObject

@property (nonatomic, strong) NSMutableArray <TPDestinationItemViewModel *> * viewModels;

- (instancetype)initWithModels:(NSArray <TPDConstantCityModel *> *)models target:(id)target;

- (void)appendModel:(TPDestinationItemViewModel *)model target:(id)target;

@end


