//
//  TPDSubscribeRouteListView.h
//  TopjetPicking
//
//  Created by lish on 2017/9/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDSubscribeRouteViewModel.h"
typedef void(^SubscribeRouteListViewTapBlock) ();
@protocol TPDSubscribeRouteListViewDelegate <NSObject>


/**
 选择某一项object

 @param object object
 @param indexPath index
 */
- (void)didSelectObject:(TPDSubscribeRouteCellViewModel *)object atIndexPath:(NSIndexPath *)indexPath ;

@end
@interface TPDSubscribeRouteListView : UIView

@property (nonatomic , copy) SubscribeRouteListViewTapBlock tapBottomBlock;//点击底部按钮回调

@property (nonatomic , copy) SubscribeRouteListViewTapBlock noResultBlock;//空白页面点击

@property (nonatomic , strong) SubscribeRouteListViewTapBlock tapAllSubscribeRouteBLock;//点击所有的定阅路线

@property (nonatomic , assign) id<TPDSubscribeRouteListViewDelegate > delegate;//代理

- (void)blindViewModel:(TPDSubscribeRouteViewModel *)viewModel;//viewModel

- (void)setBottomBtnTitle:(NSString *)title;

- (void)reloadData;

@end
