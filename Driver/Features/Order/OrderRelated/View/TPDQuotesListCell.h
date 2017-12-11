//
//  TPDQuotesListCell.h
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/28.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"
@class TPDQuotesListCell,TPDQuotesListItemViewModel;

@protocol TPDQuotesListCellDelegate <NSObject>


/**
 点击了支付定金

 @param quotesListCell 报价cell
 */
- (void)didClickPayDepositWithQuotesListCell:(TPDQuotesListCell *)quotesListCell;


/**
 点击了选择按钮

 @param quotesListCell 报价cell
 @param isSelected 是否选择
 */
- (void)quotesListCell:(TPDQuotesListCell *)quotesListCell isSelected:(BOOL)isSelected itemViewModel:(TPDQuotesListItemViewModel *)itemViewModel;


@end

@interface TPDQuotesListCell : TPBaseTableViewCell
@property (nonatomic, weak) id<TPDQuotesListCellDelegate> delegate;
@end
