//
//  TPHomeBannerCell.h
//  TopjetPicking
//
//  Created by leeshuangai on 2017/9/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TPDHomeBannerCellClickHander)(NSInteger index);
@interface TPDHomeBannerCell : UITableViewCell

//点击banner
@property (nonatomic , copy) TPDHomeBannerCellClickHander tapBannerHandler;

@property (nonatomic , strong) NSArray *bannerImages;

@end
