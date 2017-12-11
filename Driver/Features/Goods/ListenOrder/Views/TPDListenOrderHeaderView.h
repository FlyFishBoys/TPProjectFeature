//
//  TPDListenOrderHeaderView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDListenOrderSetView.h"
typedef void(^TPDListenOrderHeaderViewTapSetBtnBlock)();
@protocol TPDListenOrderHeaderViewDelegate <NSObject>

- (void)didSelectOptionalCityWithObject:(TPDListenOrderSetDestinationViewModel *)object;

@end
@interface TPDListenOrderHeaderView : UIView

@property (nonatomic , copy) TPDListenOrderHeaderViewTapSetBtnBlock tapDepartBtnBlock;//点击出发地

@property (nonatomic , copy) TPDListenOrderHeaderViewTapSetBtnBlock tapSetBtnBlock;//点击设置的按钮


@property (nonatomic , copy) NSString *departCity;//出发地

@property (nonatomic , copy) NSString *destinationCitys;//目的地

@property (nonatomic , weak) id <TPDListenOrderHeaderViewDelegate> delegate;

@end
