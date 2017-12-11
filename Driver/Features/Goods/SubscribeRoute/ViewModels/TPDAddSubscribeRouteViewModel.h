//
//  TPDAddSubscribeRouteViewModel.h
//  TopjetPicking
//
//  Created by lish on 2017/9/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPAddressModel.h"
#import "TPLocationServices.h"
#import "TPCitySelectView.h"
#import "TPFilterView.h"
@interface TPDAddSubscribeRouteViewModel : NSObject

@property (nonatomic , copy) NSString *departCityCode;//目的地城市id

@property (nonatomic , copy) NSString *destintionCityCode;//目的地城市id

@property (nonatomic , copy) NSString *truckTypeId;//车型id

@property (nonatomic , copy) NSString *truckLengthId;//车长id

@property (nonatomic , copy) NSString *destintionAddress;//目的地地址

@property (nonatomic , copy) NSString *departAddress;//出发地地址

@property (nonatomic , copy) NSString *truckLengthType;//车型车长拼的字符串

- (void)blindDepartModel:(TPAddressModel *)departModel;//绑定出发地model

- (void)blindDestintionModel:(TPAddressModel *)destintionModel;//邦定目的地目的地model

- (void)blindTruckTypeModel:(TrucktypeModel *)truckTypeModel;//绑定车型model

- (void)blindTruckLengthModel:(TrucklengthModel *)truckLengthModel;//绑定车长model

@end
