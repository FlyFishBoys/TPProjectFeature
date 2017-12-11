//
//  TPDCallRecordsCell.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"

@class TPDCallRecordsCell;
@protocol TPDCallRecordsCellProtocol <NSObject>
@optional
- (void)didClickCallOnCell:(TPDCallRecordsCell *)cell;

- (void)didClickChatOnCell:(TPDCallRecordsCell *)cell;

@end
@interface TPDCallRecordsCell : TPBaseTableViewCell

@end
