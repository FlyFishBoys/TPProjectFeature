//
//  TPDNearSupplyDataManager.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/5.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDNearSupplyDataManager.h"

#import "TPDNearSupplyMapAPI.h"

#import "TPDNearSupplyListAPI.h"

#import "TPAdvertDataManager.h"

#import <AMapSearchKit/AMapSearchKit.h>

#import "TPLocationServices.h"

@interface TPDNearSupplyDataManager ()<AMapSearchDelegate>

@property (nonatomic, strong) AMapSearchAPI *searchAPI;

@property (nonatomic,strong,nonnull,readwrite) TPDGoodsDataSource * listDataSource;

@property (nonatomic,copy) void(^reGeoHandler)(BOOL success);

@property (nonatomic,weak) id target;
@end

@implementation TPDNearSupplyDataManager
{
    NSInteger page_;
     NSArray *_goodsAdvert;
}
- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        page_ = 1;
        self.target = target;
    }
    return self;
}

- (void)fetchLocationCompletion:(void(^)(NSString *latitude,NSString *longitude))completionBlock {
    
    [[TPLocationServices locationService] requestSingleLocationWithReGeocode:YES completionHandler:^(TPAddressModel *addressModel, NSError *error) {
        if (error) {
            if (completionBlock) completionBlock(@"31.2304",@"121.473701");
        } else {
            if (completionBlock) completionBlock(addressModel.latitude,addressModel.longitude);
        }
    }];
}

- (void)loadListDataWithCallback:(void(^)(BOOL success,TPBusinessError *error))callback {
    
//                NSString *file = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
//                NSData *data = [NSData dataWithContentsOfFile:file];
//                NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
//                [self.listDataSource refreshItemsWithResponseObject:array];
//            if (callback) callback(YES,nil);
    @weakify(self);
    [self.requestParams setValue:@"1" forKey:@"page"];
    
    TPDNearSupplyListAPI *api = [[TPDNearSupplyListAPI alloc] initWithParams:self.requestParams];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            @strongify(self);
            [self.listDataSource refreshItemsWithResponseObject:responseObject];
        }
        if (callback) callback(success,error);
        //插入广告
        [self requestGoodsAdvert];
    };
    
    [api start];
}
- (void)loadNextPageDataWithCallback:(void(^)(BOOL success,TPBusinessError *error))callback {
    page_++;
    [self.requestParams setValue:[@(page_) stringValue] forKey:@"page"];
    
    @weakify(self);
    TPDNearSupplyListAPI *api = [[TPDNearSupplyListAPI alloc] initWithParams:self.requestParams];
    api.filterCompletionHandler = ^(BOOL success, NSArray *  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        @strongify(self);
        if (success && error == nil) {
            if (responseObject.count > 0) {
                [self.listDataSource appendItemsWithResponseObject:responseObject];
            } else {
                page_--;
            }
            if (callback) callback(YES,nil);
        } else {
            page_--;
            if (callback) callback(NO,error);
        }
        //插入广告
        [self requestGoodsAdvert];
    };
    [api start];
}

//请求广告的
- (void)requestGoodsAdvert {
    
    if (_goodsAdvert.count > 0) {
        [self.listDataSource insertGoodsAdvertWithResponseObject:_goodsAdvert];
        return;
    }
    [TPAdvertDataManager requestGoodsListAdvertWithComplete:^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success) {
            _goodsAdvert = [NSArray arrayWithArray:responseObject];
            [self.listDataSource insertGoodsAdvertWithResponseObject:_goodsAdvert];
        }
        if (self.fetchAdvertHandler) {
            self.fetchAdvertHandler();
        }
    }];
}
- (void)requestNearSupplyMapWithCallback:(NearSupplyMapCompletionBlock _Nonnull)callback {
    
    [self _reGoecodeSearchWithCoordinate:CLLocationCoordinate2DMake([self.requestParams[@"latitude"] doubleValue], [self.requestParams[@"longitude"] doubleValue]) complete:^(BOOL success) {
        
            NSString *file = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
            NSData *data = [NSData dataWithContentsOfFile:file];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            TPNearSupplyMapModel *model = [TPNearSupplyMapModel yy_modelWithDictionary:dict];
            if (callback) callback(YES,model,nil);

//        if (success) {
//                    TPDNearSupplyMapAPI *api = [[TPDNearSupplyMapAPI alloc] initWithParams:self.requestParams];
//            
//                    api.filterCompletionHandler = ^(BOOL success,id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
//            
//                        if (error == nil && success) {
//                            TPNearSupplyMapModel *model = [TPNearSupplyMapModel yy_modelWithDictionary:responseObject];
//                            if (callback) {
//                                callback(YES,model,error);
//                            }
//                        } else {
//                            if (callback) {
//                                callback(NO,nil,error);
//                            }
//                        }
//                    };
//            
//                    [api start];
//        } else {
//            TPBusinessError *bus_error = [[TPBusinessError alloc] init];
//            bus_error.business_code = @"566560";
//            bus_error.business_msg = @"查询失败，请在网络良好后再重试E566560";
//            if (callback) callback(NO,nil,bus_error);
//        }
    }];
}
- (void)_reGoecodeSearchWithCoordinate:(CLLocationCoordinate2D)coordinate complete:(void(^)(BOOL success))complete {
    
    self.reGeoHandler = complete;
    
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    AMapGeoPoint *geoPoint = [AMapGeoPoint locationWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
    regeo.location = geoPoint;
    
    [self.searchAPI AMapReGoecodeSearch:regeo];
}

#pragma mark - AMapSearchDelegate
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    
    if (self.reGeoHandler) self.reGeoHandler(NO);
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request
                     response:(AMapReGeocodeSearchResponse *)response {
    
    self.requestParams[@"city_id"] = response.regeocode.addressComponent.adcode ?: (response.regeocode.addressComponent.citycode ?: @"");
    
    if (self.reGeoHandler) self.reGeoHandler(YES);
}

#pragma mark - getter
- (AMapSearchAPI *)searchAPI
{
    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc] init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}
#pragma mark - getter
- (TPDGoodsDataSource *)listDataSource {
    if (!_listDataSource) {
        _listDataSource = [[TPDGoodsDataSource alloc] initWithTarget:self.target];
    }
    return _listDataSource;
}
- (NSMutableDictionary *)requestParams {
    if (!_requestParams) {
        _requestParams = @{
                           @"longitude" : @"",
                           @"latitude" : @"",
                           @"city_id" : @"",
                           @"truck_type_id" : @"",
                           @"truck_length_id" : @"",
                           @"destination_city_ids" : @[],
                           @"map_level" : @""
                           }.mutableCopy;
    }
    return _requestParams;
}
@end
