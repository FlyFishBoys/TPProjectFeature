//
//  TPDMyOrderListCell.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "TPDOrderDefines.h"

@class TPDMyOrderListCell;

@protocol TPDMyOrderListCellDelegate <NSObject>

- (void)myOrderListCell:(TPDMyOrderListCell *)myOrderListCell didClickButtonWithButtonType:(TPDMyOrderListCellButtonType)buttonType;

@end

@interface TPDMyOrderListCell : TPBaseTableViewCell
@property (nonatomic, weak) id<TPDMyOrderListCellDelegate> delegate;

@end
