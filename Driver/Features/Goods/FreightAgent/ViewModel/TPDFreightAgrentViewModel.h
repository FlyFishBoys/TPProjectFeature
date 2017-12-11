//
//  TPDFreightAgrentViewModel.h
//  TopjetPicking
//
//  Created by lish on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewItem.h"
#import "TPDFreightAgrentModel.h"
@interface TPDFreightAgrentItemViewModel : TPBaseTableViewItem

@property (nonatomic , strong) TPDFreightAgrentModel *model;

@property (nonatomic , copy) NSString *name;

@property (nonatomic , strong) UIImage *avatarImage;

@property (nonatomic , strong) UIImage *authenticationIcon;

@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *firstBrokerRoute;

@property (nonatomic , copy) NSString *secondBrokerRoute;

@property (nonatomic , copy) NSString *thirdBrokerRoute;


@property (nonatomic , strong) UIImage *callIcon;

@property (nonatomic , strong) UIImage *messageIcon;

@end
@interface TPDFreightAgrentViewModel : TPBaseTableViewItem

@property (nonatomic , strong) NSMutableArray <TPDFreightAgrentItemViewModel *> *viewModels;

- (instancetype)initWithFreightAgrentModels:(NSArray <TPDFreightAgrentModel *>*)models target:(id)target;

@end
