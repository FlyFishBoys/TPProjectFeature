//
//  TPDAddSubscribeRouteCustomView.h
//  TopjetPicking
//
//  Created by lish on 2017/8/29.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AddSubscribeRouteTapBlock)(void);
@interface TPDAddSubscribeRouteCustomView : UIView

@property (nonatomic , copy) NSString *leftTitle;
@property (nonatomic , copy) NSString *placeholder;
@property (nonatomic , copy) NSString *textFieldText;

@property (nonatomic , copy) AddSubscribeRouteTapBlock tapBlock;

@end
