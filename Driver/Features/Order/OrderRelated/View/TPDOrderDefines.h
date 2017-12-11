//
//  TPDOrderDefines.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/9/6.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#ifndef TPDOrderDefines_h
#define TPDOrderDefines_h

//我的订单cell上按钮的类型
typedef NS_ENUM(NSInteger, TPDMyOrderListCellButtonType) {
    TPDMyOrderListCellButtonType_MapNavigation = 100,//地图导航
    TPDMyOrderListCellButtonType_ConfirmSignUp,//确认签收
    TPDMyOrderListCellButtonType_CallShipper,//呼叫货主
    TPDMyOrderListCellButtonType_ConfirmPickUp,//确认提货
    TPDMyOrderListCellButtonType_GiveUpTake,//放弃承接
    TPDMyOrderListCellButtonType_ToTake,//我要承接
    TPDMyOrderListCellButtonType_Evaluation,//评价赚积分
    TPDMyOrderListCellButtonType_ViewEvaluation,//查看回评
    TPDMyOrderListCellButtonType_FriendsShare,//好友分享
};

typedef NS_ENUM(NSInteger, TPDOrderDetailDropdownMenuType) {
    TPDOrderDetailDropdownMenuType_ViewContract = 100,//查看合同
    TPDOrderDetailDropdownMenuType_ShareGoods,//分享货源
    TPDOrderDetailDropdownMenuType_RefundDetail,//退款详情
    TPDOrderDetailDropdownMenuType_RefundByMyself,//我要退款
    TPDOrderDetailDropdownMenuType_omplainByMyself,//我要投诉
};

typedef NS_ENUM(NSInteger, TPDGoodsDetailButtonType) {
    TPDGoodsDetailButtonType_TakeOrder = 100,//我要接单
    TPDGoodsDetailButtonType_RevokedQuotes,//撤销报价
    TPDGoodsDetailButtonType_ModifyQuotes,//修改报价
};

typedef NS_ENUM(NSInteger, TPDOrderDetailButtonType) {
    TPDOrderDetailButtonType_GiveUpTake = 100,//放弃承接
    TPDOrderDetailButtonType_ToTake,//我要承接
    TPDOrderDetailButtonType_ConfirmPickUp,//确认提货
    TPDOrderDetailButtonType_MapNavigation,//地图导航
    TPDOrderDetailButtonType_ConfirmSignUp,//确认签收
    TPDOrderDetailButtonType_Evaluation,//评价赚积分
    TPDOrderDetailButtonType_ViewEvaluation,//查看回评
    TPDOrderDetailButtonType_Share,//我要分享
};

typedef NS_ENUM(NSInteger, TPDOrderDetailNavRightButtonType) {
    TPDOrderDetailNavRightButtonType_ViewContract = 100,//查看合同
    TPDOrderDetailNavRightButtonType_ShareGoods,//分享货源
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
 @param model 请求模型
 */
typedef void (^RequestModelCompleteBlock)(BOOL succeed,TPBusinessError * _Nullable error,id _Nullable model);

/**
 订单列表请求block
 
 @param status 状态
 */
typedef void (^MyOrderListLoadQuestBlock)(NSString * _Nullable status);

#endif /* TPDOrderDefines_h */
