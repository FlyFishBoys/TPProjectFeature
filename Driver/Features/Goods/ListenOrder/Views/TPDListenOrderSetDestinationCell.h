//
//  TPDListenOrderSetDestinationCell..h
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "TPDListenOrderSetViewModel.h"

typedef NS_ENUM(NSInteger,ListenOrderSetPopCellType){
    
    ListenOrderSetPopCell_SelectBtn,
    
};

@protocol  ListenOrderSetPopCellTypeCellDelegate <NSObject>

- (void)ListenOrderSetPopCellTypeDidSelectBtn:(ListenOrderSetPopCellType)btnType cellViewModel:(TPDListenOrderSetDestinationViewModel *)cellViewModel;


@end
@interface TPDListenOrderSetDestinationCell : TPBaseTableViewCell

@property (nonatomic , assign) id <ListenOrderSetPopCellTypeCellDelegate> delegate;

@end
