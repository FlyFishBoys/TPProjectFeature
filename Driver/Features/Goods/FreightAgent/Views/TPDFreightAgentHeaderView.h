//
//  TPDFreightAgentHeaderView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FreightAgentHeaderViewTapCloseBtnBlock)(void);
@interface TPDFreightAgentHeaderView : UIView
@property (nonatomic , copy) FreightAgentHeaderViewTapCloseBtnBlock tapCloseBtnBlock;
@end
