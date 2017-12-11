//
//  TPDListenOrderSetUpView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPDListenOrderSetDepartViewModel;
@class TPDListenOrderSetDestinationViewModel;
@protocol TPDListenOrderSetViewDelegate <NSObject>

- (void)didSelectOptionalCityWithObject:(TPDListenOrderSetDestinationViewModel *)object;

@end
typedef void (^TPDListenOrderSetViewTapConfirmBtn)();
@interface TPDListenOrderSetView : UIView

@property (nonatomic , weak) id<TPDListenOrderSetViewDelegate> delegate;

@property (nonatomic , copy) TPDListenOrderSetViewTapConfirmBtn tapConfirmBtn;

- (instancetype)initWithDataSource:(id)dataSource;

- (void)showInView:(UIView *)contentView;

- (void)tableViewReload;

@end
