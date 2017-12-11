//
//  TPDIntegrityInquiryDefines.h
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#ifndef TPDIntegrityInquiryDefines_h
#define TPDIntegrityInquiryDefines_h

typedef enum : NSUInteger {
    TPDIntegrityInquiryGoodsCellButtonType_TakeOrder = 100,//接单
    TPDIntegrityInquiryGoodsCellButtonType_RevokedQuotes,//撤销报价
    TPDIntegrityInquiryGoodsCellButtonType_ModifyQuotes,//修改报价
} TPDIntegrityInquiryGoodsCellButtonType;

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

#endif /* TPDIntegrityInquiryDefines_h */
