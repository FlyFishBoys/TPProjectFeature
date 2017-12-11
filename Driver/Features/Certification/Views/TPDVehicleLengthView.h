//
//  TPDVehicleLengthView.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDVehicleLengthView : UIView

/**
 车型车长
 */
@property (nonatomic,copy) NSString * truckTypeLength;

/**
 是否能修改
 */
@property (nonatomic,assign) BOOL isEnble;

/**
 车型车长选择完成的回调
 */
@property (nonatomic, copy) void (^vehicleLengCompleteBlock)(NSString * truckLengthId,NSString * truckTypeId);
@end
