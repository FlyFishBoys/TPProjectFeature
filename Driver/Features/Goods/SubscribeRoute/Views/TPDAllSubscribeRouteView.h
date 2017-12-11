//
//  TPDAllSubscribeRouteView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AllSubscribeRouteViewTapBlock) (void);
@interface TPDAllSubscribeRouteView : UIView

@property (nonatomic , copy) NSString *badge;
@property (nonatomic , copy) AllSubscribeRouteViewTapBlock tapAllSubscribeRouteView;

@end
