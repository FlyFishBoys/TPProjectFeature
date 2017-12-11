//
//  TPDNearbyMapListView.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/11/7.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDNearbyMapListView : UIView

- (instancetype)initWithTarget:(id)target;

@property (nonatomic,strong) NSDictionary * requestParams;

@property (nonatomic,strong) NSArray * goodsArray;

- (void)showOnView:(UIView *)view;

- (void)dismiss;

@end
