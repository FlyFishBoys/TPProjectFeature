//
//  TPDConstantCityViewModel.h
//  TopjetPicking
//
//  Created by lish on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//


#import "TPDConstantCityModel.h"
@class TPAddressModel;
@interface TPDConstantCityItemViewModel : NSObject

@property (nonatomic , strong) TPAddressModel *addressModel;

@property (nonatomic , strong) TPDConstantCityModel *constantCityModel;

@property (nonatomic , copy) NSString *cityName;

- (void)blindConstantCityViewModel:(TPDConstantCityModel *)model;

@end

@interface TPDConstantCityViewModel : NSObject


@property (nonatomic , strong) NSMutableArray <TPDConstantCityItemViewModel *>*constantCitysArr;


@property (nonatomic , strong) NSMutableArray <TPAddressModel *>*submitCityArr;//最终提交的数组


@property (nonatomic , strong) NSMutableArray <NSString *>*addBusinessLineCityCodesArr;//提交的 - 添加常跑城市code集合

@property (nonatomic , strong) NSMutableArray <TPDConstantCityModel *>*updateBusinessLinesArr;//提交的 - 修改常跑城市集合

@property (nonatomic , strong) NSMutableArray <NSString *>*deleteBusinessLineIdsArr;//提交的 - 删除常跑城市id集合


- (void)blindConstantCityViewModel:(NSArray <TPDConstantCityModel *>*)list;

- (void)addAdressModel:(TPAddressModel *)addressModel;

- (void)deleteConstantCity:(NSInteger)index;

- (void)updateConstantCity:(TPAddressModel *)addressModel index:(NSInteger)index;

@end
