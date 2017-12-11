//
//  TPDFreightAgentView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//货运经纪人弹框

#import <UIKit/UIKit.h>
#import "TPDFreightAgrentViewModel.h"
@interface TPDFreightAgentView : UIView

- (instancetype)initWithFreightAgentViewDepartCode:(NSString *)departCode destinationCode:(NSString *)destinationCode;

- (void)show;

- (void)close;

@end
