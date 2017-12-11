//
//  TPDArrowsButton.h
//  TopjetPicking
//
//  Created by lish on 2017/9/1.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TPDArrowsButtonTapBlock)(UIButton *btn);
@interface TPDArrowsButton : UIButton

@property (nonatomic , copy) TPDArrowsButtonTapBlock tapBlock;

@end
