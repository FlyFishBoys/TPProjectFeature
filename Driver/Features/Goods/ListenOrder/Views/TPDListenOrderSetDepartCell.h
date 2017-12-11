//
//  TPDListenOrderSetDepartCell.h
//  TopjetPicking
//
//  Created by lish on 2017/9/1.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPBaseTableViewCell.h"
#import "TPDListenOrderSetViewModel.h"
typedef NS_ENUM(NSUInteger, ListenOrderSetPopLocationCellBtnType) {
    
    ListenOrderSetPopLocationCell_DepartCityBtn,
    ListenOrderSetPopLocationCell_LocationBtn
    
};
@protocol  ListenOrderSetPopLocationCellDelegate <NSObject>

- (void)listenOrderSetPopLocationCellDidSelectBtn:(ListenOrderSetPopLocationCellBtnType)btnType cellViewModel:(TPDListenOrderSetDepartViewModel *)cellViewModel;


@end

@interface TPDListenOrderSetDepartCell :TPBaseTableViewCell

@property (nonatomic , assign) id<ListenOrderSetPopLocationCellDelegate> delegate;

@end
