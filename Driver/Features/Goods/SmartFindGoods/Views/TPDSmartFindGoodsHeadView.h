//
//  TPDSmartFindGoodsHeadView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPAddressModel;
#import "TPFilterView.h"
typedef void(^SmartFindGoodsHeadViewTapBtnCompleteBlock)(TPAddressModel *selectModel);

typedef void(^SmartFindGoodsHeadViewTapTruckBtnCompleteBlock)(NSArray<TrucklengthModel *> *trucklength, NSArray<TrucktypeModel *> *Trucktype);

typedef void(^SmartFindGoodsHeadViewTapSubscribeBtnCompleteBlock)(void);


@interface TPDSmartFindGoodsHeadView : UIView

@property (nonatomic , copy) SmartFindGoodsHeadViewTapBtnCompleteBlock tapFromAdressBtnBlock;

@property (nonatomic , copy) SmartFindGoodsHeadViewTapBtnCompleteBlock tapReceiveAdressBtnBlock;

@property (nonatomic , copy) SmartFindGoodsHeadViewTapTruckBtnCompleteBlock tapVehicleStandardBtnBlock;

@property (nonatomic , copy) SmartFindGoodsHeadViewTapSubscribeBtnCompleteBlock tapSubscribeBtnBlock;

@property (nonatomic , copy) NSString *badgeNum;

@property (nonatomic , copy) NSString *locationCityAddress;//定位城市

- (void)removeFilterView;

@end
