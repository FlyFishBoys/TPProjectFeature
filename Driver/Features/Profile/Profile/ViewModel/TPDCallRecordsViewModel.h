//
//  TPDCallRecordsViewModel.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
#import "TPBaseTableViewSectionObject.h"

@class TPDCallRecordItem;
@interface TPDCallRecordsItemViewModel : TPBaseTableViewItem

@property (nonatomic,copy) NSString * depart;

@property (nonatomic,copy) NSString * destination;

@property (nonatomic,copy) NSString * timeString;

@property (nonatomic,copy) NSString * goodsTruckInfoString;

@property (nonatomic,copy) NSString * iconImageName;

@property (nonatomic,copy) NSString * iconUrl;

@property (nonatomic,copy) NSString * iconKey;

@property (nonatomic,copy) NSString * name;

@property (nonatomic,assign) CGFloat grade;

@property (nonatomic,copy) NSString * goods_id;

@property (nonatomic,copy) NSString * goods_status;

@property (nonatomic,copy) NSString * mobile;


+ (instancetype)viewModelWithItem:(TPDCallRecordItem *)item target:(id)target;

@end

@interface TPDCallRecordsListViewModel : TPBaseTableViewSectionObject

+ (instancetype)viewModelWithItems:(NSArray *)items target:(id)target;

@end
