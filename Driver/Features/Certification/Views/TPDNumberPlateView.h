//
//  TPDNumberPlateView.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDNumberPlateView : UIView

/**
 是否能修改
 */
@property (nonatomic,assign) BOOL isEnble;

/**
 车牌的城市
 */
@property (nonatomic,copy) NSString * plateCity;


/**
 车牌后面的数字字母
 */
@property (nonatomic,copy) NSString * plateNo;



/**
 输入车牌号码后的回调
 */
@property (nonatomic, copy) void (^numberPlateCompleteBlock)(NSString * plateNo2,NSString * plateNo3);

/**
 选择车牌城市后的回调
 */
@property (nonatomic, copy) void (^addressPlateCompleteBlock)(NSString * plateNo1);

@end
