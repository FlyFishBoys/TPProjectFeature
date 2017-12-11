//
//  TPDFindGoodsDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDSmartFindGoodsDataManager.h"
#import "TPDSmartFindGoodsAPI.h"
#import "TPDGoodsModel.h"
#import "TPDSeachSmartFindGoodsAPI.h"
#import "TPAddressModel.h"
#import "TPLocationServices.h"
#import "TPDSeachSmartFindGoodsAPI.h"
#import "TPDSubscribeRouteDataManager.h"
#import "TPAdvertDataManager.h"
#import "TPDFreightAgentDataManager.h"
@implementation TPDSmartFindGoodsDataManager {
    
    BOOL _locationSuccees,_requestType;
    NSString *_page;
    NSString *_requestTruckTypeId,*_requestTruckLengthId;
    NSArray *_goodsAdvert;
    NSString *_requestFreightAgentDepartCityCode,*_requestFreightAgentDestinationCityCode;
}
- (instancetype)initWithTarget:(id)target {
    
    self = [super init];
    if (self) {
      
        _dataSource = [[TPDGoodsDataSource alloc]initWithTarget:target];
        _dataSource.noResultViewType = TPNoResultViewTypeNoNeed;
        _page = @"1";
        _requestType = NO;
    }
    return self;
}

//获取是否有货运经济人
- (void)fetchFreightAgent {
    
    if (![_requestDepartCityCode isEqualToString:_requestFreightAgentDepartCityCode] || ![_requestDestinationCityCode isEqualToString:_requestFreightAgentDestinationCityCode]) {
        
        _requestFreightAgentDestinationCityCode = _requestDestinationCityCode;
        _requestFreightAgentDepartCityCode = _requestDepartCityCode;
        
        void (^fetchFreightAgent)(BOOL isHave) = ^(BOOL isHave) {
            if (self.fetchFreightAgentComplete) {
                self.fetchFreightAgentComplete(isHave);
            }
        };
        [TPRouterAnalytic openInteriorURL:TPRouter_Fetch_FreightAgent parameter:@{@"departCode":_requestFreightAgentDepartCityCode?_requestFreightAgentDepartCityCode:@"",
                                                                                 @"destinationCode":_requestFreightAgentDestinationCityCode?_requestFreightAgentDestinationCityCode:@"",
                                                                                 MGJRouterParameterCompletion:fetchFreightAgent
                                                                                  } completeBlock:nil];
   
    }
    
}

#pragma mark - 请求智能找货列表
- (void)requestSmartFindGoodsithCompleteBlock:(FindGoodsRequestCompleteBlock)completeBlock {
    
    [self fetchFreightAgent];
    
    _requestType = NO;
    TPDSmartFindGoodsAPI *api = [[TPDSmartFindGoodsAPI alloc]initWithDepartCode:_requestDepartCityCode page:_page];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        TPHiddenLoading;
        if (success && !error) {
            completeBlock(YES,responseObject,error);
        }else{
            completeBlock(NO,responseObject,error);
        }
        if (self.fetchHandler) {
            self.fetchHandler();
        }
        //插入广告
        [self requestGoodsAdvert];
    };
    
    [api start];
}
//刷新找货
- (void)refreshSmartFindGoods{
    
   _page = @"1";
    [self.dataSource clearAllItems];
    [self requestSmartFindGoodsithCompleteBlock:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        [self.dataSource refreshItemsWithResponseObject:responseObject];
        
    }];
    
}
//加载更多
- (void)loadMoreSmartFindGoods {
    
    _page = [NSString stringWithFormat:@"%d",_page.intValue + 1];
    [self requestSmartFindGoodsithCompleteBlock:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        [self.dataSource appendItemsWithResponseObject:responseObject];
    }];
    
}


#pragma mark - 筛选智能找货
- (void)requestSeachGoodsWithCompleteBlock:(FindGoodsRequestCompleteBlock _Nullable )completeBlock {
    
    [self fetchFreightAgent];
    
    _requestType = YES;
    TPDSeachSmartFindGoodsAPI *api = [[TPDSeachSmartFindGoodsAPI alloc]initWithDepartCode:_requestDepartCityCode destinationCityCode:_requestDestinationCityCode truckTypeId:_requestTruckTypeId truckLengthId:_requestTruckLengthId page:_page];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
         TPHiddenLoading;
        if (success && !error) {
            completeBlock(YES,responseObject,error);
        }else{
            completeBlock(NO,responseObject,error);
        }
        if (self.fetchHandler) {
            self.fetchHandler();
        }
        //插入广告
        [self requestGoodsAdvert];
    };
    [api start];
    
}

#pragma mark - 删选货源列表 - 上拉
- (void)refreshSeachSmartFindGoods {
    
    _page = @"1";
    [self.dataSource clearAllItems];
    [self requestSeachGoodsWithCompleteBlock:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        [self.dataSource refreshItemsWithResponseObject:responseObject];
    }];
}

#pragma mark - 删选货源列表 - 下拉
- (void)loadMoreSeachSmartFindGoods {
    
   _page = [NSString stringWithFormat:@"%d",_page.intValue + 1];
    [self requestSeachGoodsWithCompleteBlock:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        [self.dataSource appendItemsWithResponseObject:responseObject];
    }];
   
}

//获取默认的货源
- (void)fetchDefaultGoods{
    if (_locationSuccees) {
        return;
    }
    @weakify(self);
    [self obtainLocationInforWithComplete:^(TPAddressModel *model) {
        @strongify(self);
        if (self.locationHandler) {
            self.locationHandler(self->_locationSuccees,model.city);
            _requestDepartCityCode = model.adcode;
        }
        [self refreshSmartFindGoods];
    }];
    
}

//获取定位信息
- (void)obtainLocationInforWithComplete:(void(^)(TPAddressModel *model))complete {
    
    __block  TPAddressModel *model = [[TPAddressModel alloc]init];
    //1. 监测定位
    if ([TPLocationServices locationServicesState] != TPLocationServicesStateNotDetermined && [TPLocationServices locationServicesState] != TPLocationServicesStateAvailable) {
        if (complete) {
            complete(model);
        }
        self->_locationSuccees = NO;
        return;
    }else{
        [[TPLocationServices locationService]requestSingleLocationWithReGeocode:YES completionHandler:^(TPAddressModel *addressModel, NSError *error) {
            self->_locationSuccees = YES;
            if ([addressModel.adcode isNotBlank]) {
                model = addressModel;
                model.city = [model.city stringByReplacingOccurrencesOfString:@"市" withString:@""];
            }else{
                model.formatted_area = @"上海";
                model.adcode = @"020000";
                model.city = @"上海";
            }
            if (complete) {
                complete(model);
            }
        }];
    }
}


- (void)pullUpGoods {
    if (_requestType) {
        [self loadMoreSeachSmartFindGoods];
    }else{
        [self loadMoreSmartFindGoods];
    }
}

- (void)pullDownGoods {
    
    if (_locationSuccees) {
        if (_requestType) {
            [self refreshSeachSmartFindGoods];
        }else{
            [self refreshSmartFindGoods];
        }
    }else{
        [self fetchDefaultGoods];
    }
    
}

- (void)fetchGoodsWithDepartCityCode:(NSString *)departCityCode {
    _requestDepartCityCode = departCityCode;
    [self refreshSeachSmartFindGoods];
    
}

- (void)fetchGoodsWithDestinationCityCode:(NSString *)destinationCityCode {
    _requestDestinationCityCode = destinationCityCode;
    [self refreshSeachSmartFindGoods];
}

- (void)fetchGoodsWithTruckTypeId:(NSString *)truckTypeId truckLengthId:(NSString *)truckLengthId {
    _requestTruckLengthId = truckLengthId;
    _requestTruckTypeId = truckTypeId;
    [self refreshSeachSmartFindGoods];
}
- (void)fetchSubscibeGoodsCountWithComplte:(void(^)(NSString *goodsCount))complete {

    [TPDSubscribeRouteDataManager requestSubscribeRouteGoodsCountAPIWithCompleteBlock:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
    
        if (success) {
            complete(responseObject);
        }else{
            TPShowToast(error.business_msg);
            complete(@"");
        }
    }];
    
}

//请求广告的
- (void)requestGoodsAdvert {
    
    if (_goodsAdvert.count > 0) {
        [self.dataSource insertGoodsAdvertWithResponseObject:_goodsAdvert];
        return;
    }
    [TPAdvertDataManager requestGoodsListAdvertWithComplete:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success) {
            _goodsAdvert = [NSArray arrayWithArray:responseObject];
           [self.dataSource insertGoodsAdvertWithResponseObject:_goodsAdvert];
        }
        if (self.fetchHandler) {
            self.fetchHandler();
        }
    }];
}
@end
