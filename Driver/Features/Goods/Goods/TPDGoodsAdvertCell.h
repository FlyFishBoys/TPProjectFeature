//
//  TPDGoodsAdvertCell.h
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"

#import "TPGoodsListAdvertViewModel.h"
@protocol TPDGoodsAdvertCellDelegate<NSObject>

- (void)didClickGoodsAdvertCell:(TPGoodsListAdvertItemViewModel *)viewModel;

@end
@interface TPDGoodsAdvertCell : TPBaseTableViewCell


@property (nonatomic , assign) id <TPDGoodsAdvertCellDelegate>delegate;


@end
