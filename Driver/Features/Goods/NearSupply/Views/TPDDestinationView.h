//
//  TPDDestinationView.h
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TPDConstantCityModel.h"

#import "TPDDestinationViewModel.h"

typedef void(^DestinationComplete)(NSArray<TPDestinationItemViewModel*> *destinations);

typedef void(^DestinationDismiss)();

@interface TPDDestinationView : UIView

@property (nonatomic, strong) NSArray <TPDestinationItemViewModel*> *selectDestinations;

- (void)showViewInWindowWithTop:(CGFloat)top
                 handleComplete:(DestinationComplete)destinationComplete
                  filterDismiss:(DestinationDismiss)destinationDismiss;

- (void)disMissFilterView;

@end
