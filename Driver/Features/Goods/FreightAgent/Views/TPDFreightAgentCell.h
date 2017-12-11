//
//  TPDFreightAgentCell.h
//  TopjetPicking
//
//  Created by lish on 2017/8/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//货运经纪人cell

#import "TPBaseTableViewCell.h"
#import "TPDFreightAgrentViewModel.h"
typedef NS_ENUM(NSInteger,FreightAgentCellButtonType){
    
    FreightAgentCellButtonType_Message,
    FreightAgentCellButtonType_Call
    
};
@protocol TPDFreightAgentCellDelegate<NSObject>


- (void)didClickFreightAgentCellButton:(FreightAgentCellButtonType)type object:(TPDFreightAgrentItemViewModel *)object;
@end
@interface TPDFreightAgentCell : TPBaseTableViewCell


@property (nonatomic , assign) id<TPDFreightAgentCellDelegate> delagete;

@end
