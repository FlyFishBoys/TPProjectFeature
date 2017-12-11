//
//  TPDSmartFindGoodsFooterView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,GoodsFooterViewRightBtnType){
    
    GoodsFooterViewRightBtnType_MatchedCenter,//匹配中心
    GoodsFooterViewRightBtnType_FreightAgent//货运经济人
    
    
};
typedef void(^SmartFindGoodsFooterViewTapBtnBlock)(void);
typedef void(^SmartFindGoodsFooterViewTapRightBtnBlock)(GoodsFooterViewRightBtnType type);

@interface TPDSmartFindGoodsFooterView : UIView

@property (nonatomic , copy) SmartFindGoodsFooterViewTapBtnBlock tapLeftBtnBlock;

@property (nonatomic , copy) SmartFindGoodsFooterViewTapRightBtnBlock tapRightBtnBlcok;

@property (nonatomic , assign) GoodsFooterViewRightBtnType rightBtnType;

@end
