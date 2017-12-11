//
//  TPDSelectProvinceView.h
//  TopjetPicking
//
//  Created by 沈阳 on 2017/10/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPDSelectProvinceView : UIView

@property (nonatomic,copy) void(^selectedBolck)(NSString *province);

- (void)show;

- (void)dismiss;

@end
