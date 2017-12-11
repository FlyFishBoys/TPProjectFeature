//
//  TPDMyVehicleTeamDataSource.m
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDMyVehicleTeamDataSource.h"
#import "TPDMyVehicleTeamCell.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDMyVehicleTeamAPI.h"
#import "TPDMyVehicleTeamModel.h"
#import "TPDSwitchSeekGoodsStatusAPI.h"
#import "TPDSwitchSeekGoodsStatusAllAPI.h"
#import "TPDMyVehicleTeamModel.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDMyVehicleTeamViewModel.h"

@interface TPDMyVehicleTeamDataSource ()
{
    NSInteger _page;
}
@property (nonatomic,strong)TPBaseTableViewSectionObject * section;
@property (nonatomic,weak) id target;

@end

@implementation TPDMyVehicleTeamDataSource
- (instancetype)initWithTarget:(id)target {
    if (self = [super init]) {
        self.target = target;
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    return self;
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    return [TPDMyVehicleTeamCell class];
}

- (TPNoResultViewType)noResultViewTypeForTableView:(UITableView *)tableView {
    return TPNoResultViewTypeMyVehicleTeamNull;
}

- (void)refreshMyVehicleTeamWithCompleteBlock:(RequestCompleteBlock)completeBlock {
    _page = 1;
    TPDMyVehicleTeamAPI * myVehicleTeamAPI = [[TPDMyVehicleTeamAPI alloc]initWithPage:_page];
    myVehicleTeamAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (error == nil && success) {
            if (completeBlock) {
                NSArray * lists = [NSArray yy_modelArrayWithClass:[TPDMyVehicleTeamModel class] json:responseObject[@"truck_team_list"]];
                TPDMyVehicleTeamViewModel * viewModel = [[TPDMyVehicleTeamViewModel alloc]initWithModels:lists target:self.target];
                [self clearAllItems];
                [self appendItems:viewModel.viewModels];
                completeBlock(YES,nil);
            }
        } else {
            if (completeBlock) {
                completeBlock(NO,error);
            }
        }
    };
    
    [myVehicleTeamAPI start];
}

- (void)loadMoreMyVehicleTeamWithCompleteBlock:(RequestListCompleteBlock)completeBlock {
    _page ++;
    TPDMyVehicleTeamAPI * myVehicleTeamAPI = [[TPDMyVehicleTeamAPI alloc]initWithPage:_page];
    myVehicleTeamAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (error == nil && success) {
            if (completeBlock) {
                NSArray * list = [NSArray yy_modelArrayWithClass:[TPDMyVehicleTeamModel class] json:responseObject[@"truck_team_list"]];
                if (list.count) {
                    TPDMyVehicleTeamViewModel * viewModel = [[TPDMyVehicleTeamViewModel alloc]initWithModels:list target:self.target];
                    [self appendItems:viewModel.viewModels];
                }
                completeBlock(YES,nil,list.count);
            }
        } else {
            _page --;
            if (completeBlock) {
                completeBlock(NO,error,0);
            }
        }
    };
    
    [myVehicleTeamAPI start];
}

- (void)switchSeekGoodsStatusWithDriverTruckId:(NSString *)driverTruckId truckStatus:(NSString *)truckStatus completeBlock:(RequestCompleteBlock _Nonnull)completeBlock {
    TPDSwitchSeekGoodsStatusAPI * switchSeekGoodsStatusAPI = [[TPDSwitchSeekGoodsStatusAPI alloc]initWithDriverTruckId:driverTruckId truckStatus:truckStatus];
    switchSeekGoodsStatusAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            
            [self.section.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TPDMyVehicleTeamItemViewModel * itemViewModel = (TPDMyVehicleTeamItemViewModel *)obj;
                if ([itemViewModel.model.driver_truck_id isEqualToString:driverTruckId]) {
                    itemViewModel.model.truck_status = [itemViewModel.model.truck_status isEqualToString:@"1"] ? @"2" : @"1";
                }
                *stop = YES;
            }];
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [switchSeekGoodsStatusAPI start];
}

- (void)switchSeekGoodsStatusAllWithTruckStatus:(NSString *)truckStatus completeBlock:(RequestCompleteBlock _Nonnull)completeBlock {
    TPDSwitchSeekGoodsStatusAllAPI * switchSeekGoodsStatusAllAPI = [[TPDSwitchSeekGoodsStatusAllAPI alloc]initWithTruckStatus:truckStatus];
    switchSeekGoodsStatusAllAPI.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            completeBlock(YES,nil);
        } else {
            completeBlock(NO,error);
        }
    };
    [switchSeekGoodsStatusAllAPI start];
}

- (TPBaseTableViewSectionObject *)section {
    return self.sections.firstObject;
}

@end
