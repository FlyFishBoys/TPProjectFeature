//
//  TPDIntegrityInquiryGoodsCell.h
//  Driver
//
//  Created by Mr.mao on 2017/11/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "TPDIntegrityInquiryDefines.h"

@class TPDIntegrityInquiryGoodsCell;

@protocol TPDIntegrityInquiryGoodsCellDelegate <NSObject>

- (void)integrityInquiryResultCell:(TPDIntegrityInquiryGoodsCell *)integrityInquiryResultCell didClickButtonWithButtonType:(TPDIntegrityInquiryGoodsCellButtonType)buttonType;

@end

@interface TPDIntegrityInquiryGoodsCell : TPBaseTableViewCell
@property (nonatomic, weak) id<TPDIntegrityInquiryGoodsCellDelegate> delegate;

@end
