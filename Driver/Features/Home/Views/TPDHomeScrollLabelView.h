//
//  TPHomeMiddleView.h
//  TopjetPicking
//
//  Created by leeshuangai on 2017/8/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPAnnouncementModel.h"
typedef void (^TPDHomeScrollLabelViewTapHander)(NSInteger index);

@interface TPDHomeScrollLabelView : UIView

@property (nonatomic , copy) TPDHomeScrollLabelViewTapHander tapScrollLabelHander;

@property (nonatomic , strong) NSArray *scrollTextArray;

@end
