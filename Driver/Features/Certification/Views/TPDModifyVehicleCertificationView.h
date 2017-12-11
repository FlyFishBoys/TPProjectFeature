//
//  TPDModifyVehicleCertificationView.h
//  Driver
//
//  Created by Mr.mao on 2017/10/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPDVehicleCertificationModel,TPDVehicleCertificationViewModel;

@interface TPDModifyVehicleCertificationView : UIView

/**
 初始化

 @param isRegistered 是否是注册
 */
- (instancetype)initWithIsRegistered:(BOOL)isRegistered;


@property (nonatomic,copy)void(^modifyBlock)(TPDVehicleCertificationModel * model);

@property (nonatomic, strong) TPDVehicleCertificationViewModel * viewModel;

@end
