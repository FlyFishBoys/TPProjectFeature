//
//  TPDVehicleDefines.h
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#ifndef TPDVehicleDefines_h
#define TPDVehicleDefines_h

typedef NS_ENUM(NSInteger, TPDVehicleRemarkViewType) {
    TPDVehicleRemarkViewType_Name = 100,//姓名
    TPDVehicleRemarkViewType_Mobile,//电话
};


/**
 请求列表的block
 
 @param succeed 是否请求成功
 @param error 错误信息
 @param listCount 列表数量
 */
typedef void (^RequestListCompleteBlock)(BOOL succeed,TPBusinessError * _Nullable error,NSInteger listCount);

/**
 请求的block
 
 @param succeed 是否请求成功
 @param error 错误信息
 */
typedef void (^RequestCompleteBlock)(BOOL succeed,TPBusinessError * _Nullable error);

/**
 请求模型的block
 
 @param succeed 是否请求成功
 @param error 错误信息
 @param viewModel 请求模型
 */
typedef void (^RequestViewModelCompleteBlock)(BOOL succeed,TPBusinessError * _Nullable error,id _Nullable viewModel);


#endif /* TPDVehicleDefines_h */
