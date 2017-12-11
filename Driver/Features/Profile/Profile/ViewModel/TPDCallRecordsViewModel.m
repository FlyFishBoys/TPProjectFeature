//
//  TPDCallRecordsViewModel.m
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCallRecordsViewModel.h"
#import "TPDCallRecordItem.h"
#import "NSString+TimesTamp.h"

@implementation TPDCallRecordsItemViewModel

+ (instancetype)viewModelWithItem:(TPDCallRecordItem *)item target:(id)target {
    TPDCallRecordsItemViewModel *viewModel = [[TPDCallRecordsItemViewModel alloc] init];
    
    viewModel.depart = item.depart_city;
    viewModel.destination = item.destination_city;
    viewModel.timeString = [item.create_time convertedToUpdatetime];
    viewModel.goodsTruckInfoString = [NSString stringWithFormat:@"%@ %@",item.the_goods,item.tuck_length_type];
    if ([item.shipprModel.is_anonymous isEqualToString:@"2"]) {
        if ([item.shipprModel.sex isEqualToString:@"0"]) {
            viewModel.iconImageName = @"common_male_placeholder";
        } else if ([item.shipprModel.sex isEqualToString:@"1"]) {
            viewModel.iconImageName = @"common_female_placeholder";
        } else {
            viewModel.iconImageName = @"common_placeholder70*70";
        }
    } else {
        viewModel.iconImageName = @"";
    }
    viewModel.iconUrl = item.shipprModel.owner_icon_url;
    viewModel.iconKey = item.shipprModel.owner_icon_key;
    viewModel.name = item.shipprModel.owner_name;
    viewModel.grade = item.shipprModel.owner_comment_level.floatValue;
    viewModel.target = target;
    viewModel.goods_id = item.goods_id;
    viewModel.goods_status = item.goods_status;
    viewModel.mobile = item.shipprModel.owner_mobile;
    
    return viewModel;
}

@end

@implementation TPDCallRecordsListViewModel

+ (instancetype)viewModelWithItems:(NSArray *)items target:(id)target {
    TPDCallRecordsListViewModel *viewModel = [[TPDCallRecordsListViewModel alloc] init];
    for (TPDCallRecordItem *item in items) {
        TPDCallRecordsItemViewModel *itemViewModel = [TPDCallRecordsItemViewModel viewModelWithItem:item target:target];
        [viewModel.items addObject:itemViewModel];
    }
    return viewModel;
}

@end
