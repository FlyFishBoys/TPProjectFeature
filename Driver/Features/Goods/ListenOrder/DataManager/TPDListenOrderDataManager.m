//
//  TPDListenOrderDataManager.m
//  TopjetPicking
//
//  Created by lish on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderDataManager.h"
#import "TPDObtainListenOrdertSetAPI.h"
#import "TPDListenOrderSetModel.h"
#import "TPDConstantCityModel.h"
#import "TPAddressModel.h"
#import "TPLocationServices.h"
#import "TPDConstantCityDataManager.h"
#import "TPDListenOrderGoodsListAPI.h"
#import "TPDGoodsModel.h"
#import "TPDAVSpeechSynthesizer.h"
#import "TPDSaveListenOrderSwitchStatusAPI.h"
#import "TPDObtainListenOrderSwitchStatusAPI.h"
#import "TPDSaveListenOrdertSetAPI.h"
#import "NSString+TimesTamp.h"
@interface TPDListenOrderDataManager()

@property (nonatomic , strong) TPDAVSpeechSynthesizer *speechSynthesizer;//播报语音的

@property (nonatomic , strong) TPDListenOrderSetModel *optionalModel;

@property (nonatomic , strong) TPDListenOrderSetModel *departModel;
@end

@implementation TPDListenOrderDataManager {
    
    BOOL _locationSuccees;
    NSTimer *_timer;
   // TPDListenOrderSetModel *_optionalModel,*_departModel;
    NSArray <TPDListenOrderSetModel *> *_destinationModelArr,*_requestDestinationModelAr;
    NSArray <TPDConstantCityModel *> *_constantCityArr;
    NSMutableArray <NSString *> *_destinationCityIdArr;
    NSString *_listenOrderSwitchTime;
}
- (void)dealloc {
    
    [_timer invalidate];
    _timer = nil;
    
}
+ (instancetype)sharedInstance {
    static id sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self new];
    });
   
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.optionalModel = [[TPDListenOrderSetModel alloc]init];
        self.departModel = [[TPDListenOrderSetModel alloc]init];
        self.dataStorage = [[TPDListenOrderDataStorage alloc]init];
        self.speechSynthesizer = [TPDAVSpeechSynthesizer sharedSyntheSize];
    }
    return self;
}

//根据听单设置请求听单货源
- (void)fetchListenOrderGoods {
   
    
    dispatch_group_t group =  dispatch_group_create();
    
    //1.请求听单设置
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_group_enter(group);
        [self fetchListenOrderSetWithComplete:^{
            dispatch_group_leave(group);
        }];
    });
    
    //2.请求常跑城市
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_group_enter(group);
        [self fetchConstantCity:^{
            dispatch_group_leave(group);
        }];
    });
    
    //3.如果depart == nil 定位
    if (![_departModel.city_id isNotBlank] || _departModel == nil) {
        //定位
        dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            dispatch_group_enter(group);
            [self obtainLocationInforWithComplete:^(TPDListenOrderSetModel *model) {
                _departModel = model;
                dispatch_group_leave(group);
            }];
        });
    }
    
    //处理数据
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       
        //获取目的地cityId
        [self obtainDestinationCityIds];
        //获取听单设置完成
        [self listenOrderSetComplete];
        //获取货源
        [self fetchSingleListenOrderGoods];
        //定位完成
        [self fetchLocationComplete];
    });
}

//获取听单设置
- (void)fetchListenOrderSetWithComplete:(ListenOrderFetchComplete)complete {
    
    TPDObtainListenOrdertSetAPI *api = [[TPDObtainListenOrdertSetAPI alloc]init];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        if (success && !error) {
         
            _destinationModelArr = [NSArray yy_modelArrayWithClass:[TPDListenOrderSetModel class] json:responseObject[@"common"]].mutableCopy;
            TPDListenOrderSetModel *tempOptionModel = [TPDListenOrderSetModel yy_modelWithDictionary:responseObject[@"optional"]];
            //处理自选城市
            if ([tempOptionModel.city_id isNotBlank] && [tempOptionModel.city_name isNotBlank]) {
                _optionalModel = tempOptionModel;
            }else{
                _optionalModel.city_name = @"手动选择城市";
                _optionalModel.type = @"3";
            }
            //处理出发地
            _departModel = [TPDListenOrderSetModel yy_modelWithDictionary:responseObject[@"depart"]];
            
        }
        
        
        if (complete) {
            complete();
        }
    };
    [api start];
}


//更新听单设置
- (void)updateListenOrderSet {
    
    [self clearAllListenOrderGoods];
    
    TPDListenOrderSetModel *departModel = self.listenOrderSetDataSource.viewModel.departSetViewModel.model;
    
    TPDListenOrderSetModel *optionalModel = self.listenOrderSetDataSource.viewModel.optionalSetViewModel.model;
    if (!self.listenOrderSetDataSource.viewModel.optionalSetViewModel.isSelectCity) {
        optionalModel = [[TPDListenOrderSetModel alloc]init];
    }
    
    NSMutableArray *destinationModels = [NSMutableArray array];
    [self.listenOrderSetDataSource.viewModel.destinationSetViewModels enumerateObjectsUsingBlock:^(TPDListenOrderSetDestinationViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelectCity) {
            [destinationModels addObject:obj.model];
        }
    }];
    
    if (![departModel.city_id isNotBlank]) {
        TPShowToast(@"请设置出发地");
        return;
    }
    TPDSaveListenOrdertSetAPI *api = [[TPDSaveListenOrdertSetAPI alloc]initWithDepartObject:departModel  optional:optionalModel commonArr:destinationModels];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
          _requestDestinationModelAr = [NSArray arrayWithArray:destinationModels];
        }
        [self fetchListenOrderGoods];
       
    };
    [api start];
}


//获取听单开关状态
- (void)fetchListenOrderSwitchStatus{
    
    TPDObtainListenOrderSwitchStatusAPI *api = [[TPDObtainListenOrderSwitchStatusAPI alloc]init];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        
        if (success) {
        self.listenOrderStatus = [responseObject[@"status"] isEqualToString:@"0"]?ListenOrderSwicthStatus_Off:ListenOrderSwicthStatus_On;
        }
       
    };
    
    [api start];
}

//更新听单开关状态
- (void)updateListenOrderSwitchStatus {
    
    NSString *status = self.listenOrderStatus == ListenOrderSwicthStatus_On ?@"0":@"1";
    
    self.listenOrderStatus = [status isEqualToString:@"0"]?ListenOrderSwicthStatus_Off:ListenOrderSwicthStatus_On;
    
    TPDSaveListenOrderSwitchStatusAPI *api = [[TPDSaveListenOrderSwitchStatusAPI alloc]initWithStatus:status];
    
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
            if ([responseObject[@"code"] isEqualToString:@"1"]) {
                //说明保存成功
            }else{
                TPShowToast(@"听单开关保存失败");
            }
        }
    };
    [api start];

}
//获取常跑城市
- (void)fetchConstantCity:(void(^)())complete {
    
    [TPDConstantCityDataManager requestConstantCityListAPIWithCompleteBlock:^(BOOL succeed, id responseObjet, TPBusinessError *error) {
        if (succeed) {
           _constantCityArr = [NSArray arrayWithArray:responseObjet];
        }
        if (complete) {
            complete();
        }
    }];
    
}

//获取单条听单货源
- (void)fetchSingleListenOrderGoods{
    
    //停止定时器
    [self stopTimer];
    
    //如果听单状态关闭的话 不请求
    if (self.listenOrderStatus == ListenOrderSwicthStatus_Off) {
        return;
    }
    if (![_departModel.city_id isNotBlank]) {
        return;
    }
    
    TPDListenOrderGoodsListAPI *api = [[TPDListenOrderGoodsListAPI alloc]initWithStartTime:_listenOrderSwitchTime?_listenOrderSwitchTime:[NSString obtainCurrentTimestamp] departCityId:_departModel.city_id destinationCityIdArr:_destinationCityIdArr];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        TPDGoodsModel *model  = [TPDGoodsModel yy_modelWithDictionary:responseObject];
        if ([model.goods_id isNotBlank]) {
            //1.存在本地
            [self.dataStorage recordSingleListenOrderDataWithModel:model completeBlock:^(BOOL succeed, NSMutableArray<TPDGoodsModel *> *result) {
                [self fetchListenOrderGoodsCompleteWithResult:result];
            }];
            //2.播报语音
            [self.speechSynthesizer startReadWithSpeechText:model.listen_single_content];
            //3.播报完成 请求下一条数据
            @weakify(self);
            self.speechSynthesizer.speechFinishBlock = ^(AVSpeechSynthesizer *synthesizer, AVSpeechUtterance *utterence) {
                @strongify(self);
                [self fetchSingleListenOrderGoods];
            };
            _listenOrderSwitchTime = model.update_time;
        }else{
            [self startTimer];
        }
    };
    
    [api start];
}

#pragma mark - Private Methods
//获取听单货源完成
- (void)fetchListenOrderGoodsCompleteWithResult:(id)result {
    [self.goodsDataSource refreshItemsWithGoodsModels:result];
    //返回请求货源回调
    if (self.fetchGoodsComplete) {
        self.fetchGoodsComplete();
    }
}
- (void)fetchLocationComplete {
    //返回定位失败与否
    if ([_departModel.city_id isNotBlank] && _locationSuccees == NO) {
        if (self.locationComplete) {
            self.locationComplete(NO);
        }
    }else{
        if (self.locationComplete) {
            self.locationComplete(YES);
        }
    }
}
//听单设置完成
- (void)listenOrderSetComplete {
 
    [self.listenOrderSetDataSource appendDepartModelWithModel:_departModel destinationModels:_destinationModelArr constantCityModels:_constantCityArr optionalModel:_optionalModel];
    
    __block  NSString *destination;
    [_destinationModelArr enumerateObjectsUsingBlock:^(TPDListenOrderSetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![destination isNotBlank]) {
            destination = obj.city_name;
        }else{
            destination = [[destination stringByAppendingString:@"/ "]stringByAppendingString:obj.city_name];
        }
    }];
    
    if (![_optionalModel.city_name containsString:@"手动选择城市"] && [_optionalModel.city_name isNotBlank]) {
        if ([destination isNotBlank]) {
           destination = [[destination stringByAppendingString:@"/"]stringByAppendingString:_optionalModel.city_name];
        }else{
            destination = _optionalModel.city_name;
        }
        
    }
    if (self.fetchListenOrderSetComplete) {
        self.fetchListenOrderSetComplete(_departModel.city_name, destination);
    }
    
    NSLog(@"出发地名称 === %@",_departModel.city_name);
}
//获取定位信息
- (void)obtainLocationInforWithComplete:(void(^)(TPDListenOrderSetModel *model))complete {
    TPShowLoading;
    __block TPDListenOrderSetModel *model = [[TPDListenOrderSetModel alloc]init];
  
    if ([TPLocationServices locationServicesState] == TPLocationServicesStateAvailable ||[TPLocationServices locationServicesState] == TPLocationServicesStateNotDetermined) {
        [[TPLocationServices locationService]requestSingleLocationWithReGeocode:YES completionHandler:^(TPAddressModel *addressModel, NSError *error) {
            self->_locationSuccees = YES;
            if (![addressModel.adcode isNotBlank] ) {
                
                model.city_name = @"上海";
                model.city_id = @"020000";
                
            }else{
                model.city_name = [addressModel.formatted_area stringByReplacingOccurrencesOfString:@"市" withString:@""];
                model.city_id = addressModel.adcode;
                
            }
            if (complete) {
                complete(model);
            }
             TPHiddenLoading;
        }];
    }else{
        TPHiddenLoading;
        if ([_departModel.city_id isNotBlank]) {
            model = _departModel;
        }else{
            model.type = @"1";
            model.city_name = @"无法获取";
        }
        if (complete) {
            complete(model);
        }
    }
}
//刷新听单设置数据
- (void)refreshListenOrderSetDataSource {
    
    [self listenOrderSetComplete];
    
}
//删除货源
- (void)removeGoodsWithGoodsId:(NSString *)goodsId {
    [self.dataStorage removeSingleListenOrderDataWithGoodsId:goodsId completeBlock:^(BOOL succeed, NSMutableArray<TPDGoodsModel *> *result) {
        [self fetchListenOrderGoodsCompleteWithResult:result];
    }];
}
//打过电话记录
- (void)callUpWithGoodsId:(NSString *)goodsId {
    [self.dataStorage obtainListenOrderDataCompleteBlock:^(BOOL succeed, NSMutableArray<TPDGoodsModel *> *result) {
        if (succeed) {
            [result enumerateObjectsUsingBlock:^(TPDGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.goods_id isEqualToString:goodsId]) {
                    obj.is_call = @"1";
                }
            }];
        }
        [self.dataStorage recordListenOrderDataWithObject:result completeBlock:^(BOOL succeed) {
            [self fetchListenOrderGoodsCompleteWithResult:result];
        }];
        
    }];
}
//查看过货源记录
- (void)lookupWithGoodsId:(NSString *)goodsId {

    [self.dataStorage obtainListenOrderDataCompleteBlock:^(BOOL succeed, NSMutableArray<TPDGoodsModel *> *result) {
        if (succeed) {
            [result enumerateObjectsUsingBlock:^(TPDGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.goods_id isEqualToString:goodsId]) {
                    obj.is_examine = @"1";
                }
            }];
        }
        [self.dataStorage recordListenOrderDataWithObject:result completeBlock:^(BOOL succeed) {
             [self fetchListenOrderGoodsCompleteWithResult:result];
        }];
    }];
    
}

//清空所有听单数据数据
- (void)clearAllListenOrderGoods {
    
    [self.dataStorage removeListenOrderDataWithCompleteBlock:nil];
    [self.goodsDataSource clearAllItems];
    if (self.fetchGoodsComplete) {
        self.fetchGoodsComplete ();
    }
}
//处理听单的目的地cityId
- (void)obtainDestinationCityIds {
    
    _destinationCityIdArr = [NSMutableArray array];
    if (_requestDestinationModelAr.count > 0) {
        [_requestDestinationModelAr enumerateObjectsUsingBlock:^(TPDListenOrderSetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_destinationCityIdArr addObject:obj.city_id];
        }];
    }else{
        [_destinationModelArr enumerateObjectsUsingBlock:^(TPDListenOrderSetModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_destinationCityIdArr addObject:obj.city_id];
        }];
    }
}

//定时器
- (void)stopTimer {
    [_timer invalidate];
    _timer = nil;
}
//开启定时器
- (void)startTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:10.0 block:^(NSTimer * _Nonnull timer) {
        [self fetchSingleListenOrderGoods];
    } repeats:NO];
}
#pragma mark - Getters and Setters
- (void)setTarget:(id)target {
    
    _target = target;
    self.goodsDataSource = [[TPDGoodsDataSource alloc]initWithTarget:_target];
    _goodsDataSource.noResultViewType = TPNoResultViewTypeNoNeed;
    self.listenOrderSetDataSource = [[TPDListenOrderSetDataSource alloc]initWithTarget:target];
}

//设置听单状态
- (void)setListenOrderStatus:(ListenOrderSwicthStatus)listenOrderStatus {
    
    _listenOrderStatus = listenOrderStatus;
    if (self.listenOrderStausChanged) {
        self.listenOrderStausChanged(self.listenOrderStatus);
    }
    if (self.ATlistenOrderStausChanged) {
        self.ATlistenOrderStausChanged(self.listenOrderStatus);
    }
    if (_listenOrderStatus == ListenOrderSwicthStatus_Off) {
        [self stopTimer];
        [self.speechSynthesizer cancleReading];
    }else{
        _listenOrderSwitchTime = [NSString obtainCurrentTimestamp];
        [self fetchSingleListenOrderGoods];
    }
}
@end
