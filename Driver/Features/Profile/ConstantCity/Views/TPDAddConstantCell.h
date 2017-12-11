//
//  TPDAddConstantCell.h
//  TopjetPicking
//
//  Created by lish on 2017/8/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPAddressModel.h"
typedef NS_ENUM(NSInteger,RIGHT_BTN_TYPE){
    
    RIGHT_BTN_ARROWS,//箭头
    RIGHT_BTN_DELETE,//删除
    
};
@interface TPDAddConstantCell : UITableViewCell

@property (nonatomic , assign) RIGHT_BTN_TYPE right_btn_type;

@property (nonatomic , strong) TPAddressModel *model;

@property (nonatomic , assign) BOOL hideLocationIcon;//定位图标

@property (nonatomic , copy) void(^AddConstantCellTapArrowHandler)();

@end
