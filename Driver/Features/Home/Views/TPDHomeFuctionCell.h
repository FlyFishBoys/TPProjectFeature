//
//  TPHomeFuctionCell.h
//  TopjetPicking
//
//  Created by leeshuangai on 2017/9/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPDHomeFuctionItemModel.h"
typedef void (^TPDHomeFuctionCellTapItem)(NSString *routeURL);
@interface TPDHomeFuctionCell : UITableViewCell

@property (nonatomic , strong) NSArray <TPDHomeFuctionItemModel *>*fuctionItemArr;
@property (nonatomic , copy) TPDHomeFuctionCellTapItem tapItemBlock;
@end
