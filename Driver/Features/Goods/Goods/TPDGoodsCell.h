//
//  TPDGoodsCell.h
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"

@class TPDGoodsItemViewModel;
typedef void (^GoodsCellTapBtnHandler)(UIButton *btn);
typedef NS_ENUM(NSUInteger, TPDGoodsCellBtnType) {
    
    TPDGoodsCell_CallUp,
    TPDGoodsCell_ReceiveOrder
    
};
@protocol  TPDGoodsCellDelegate <NSObject>

- (void)didSelectGoodsCellBtn:(TPDGoodsCellBtnType)btnType itemViewModel:(TPDGoodsItemViewModel *)itemViewModel;


@end

@interface TPDGoodsCell :TPBaseTableViewCell


@property (nonatomic , assign) id<TPDGoodsCellDelegate> delegate;

@end
