//
//  TPPersonalCenterCellView.h
//  TopjetPicking
//
//  Created by lish on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,PersonalCenterCellViewType){
     PersonalCenterCellViewType_Swicth,//开关的
     PersonalCenterCellViewType_Arrow //箭头的
    
};
typedef void (^TPDProfileCellViewTap)();
typedef void (^TPDProfileCellViewTapSwitch)(BOOL isON);
@interface TPDProfileCellView : UIView

@property (nonatomic , assign) PersonalCenterCellViewType viewType;

@property (nonatomic , copy) NSString *titleStr;

@property (nonatomic , copy) NSString *detailStr;

//点击箭头
@property (nonatomic , copy) TPDProfileCellViewTap tapArrowHandle;

//点击开关 0 是关 1是开
@property (nonatomic , copy) TPDProfileCellViewTapSwitch tapSwitchHandle;

@end
