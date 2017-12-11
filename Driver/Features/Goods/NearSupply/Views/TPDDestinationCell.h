//
//  TPDDestinationCell.h
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"

@protocol TPDestinationCellDelegate <NSObject>

- (void)selectIconBtn:(id)data;

@end

@interface TPDDestinationCell : TPBaseTableViewCell

@property (nonatomic, weak) id <TPDestinationCellDelegate> delegate;

@end
