//
//  TPDMyVehicleTeamBottomView.h
//  Driver
//
//  Created by Mr.mao on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDMyVehicleTeamBottomView : UIView
//设置全部求货/休息block
@property (nonatomic,copy) void (^swithAllStatusBlock)(NSString * truckStatus);

@end
