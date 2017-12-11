//
//  TPDFreightAgentDataManager.h
//  TopjetPicking
//
//  Created by lish on 2017/11/15.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TPDFreightAgentDataSource.h"
typedef void (^FreightAgentFetchComplete)();
typedef void (^FreightAgentFetchEconomicCountComplete)(BOOL isHave);
@interface TPDFreightAgentDataManager : NSObject

@property (nonatomic , strong) TPDFreightAgentDataSource *dataSource;

@property (nonatomic , copy) FreightAgentFetchComplete fetchListComplete;

@property (nonatomic , copy) FreightAgentFetchEconomicCountComplete fetchFreightAgentComplete;

- (instancetype)initWithTarget:(id)target;


- (void)pullUpFreightAgentListWithDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode;

- (void)pullDownFreightAgentListWithDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode;

- (void)fetchHaveFreightAgentWithDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode ;

@end
