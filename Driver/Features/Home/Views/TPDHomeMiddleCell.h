//
//  TPHomeMiddleCell.h
//  TopjetPicking
//
//  Created by leeshuangai on 2017/9/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TapLeftBtnCompleteBlock)(UIButton *);
typedef void (^TapRightBtnCompleteBlock)(UIButton *);

@interface TPDHomeMiddleCell : UITableViewCell

@property (nonatomic , copy) TapLeftBtnCompleteBlock tapLeftBtnCompleteBlock;

@property (nonatomic , copy) TapRightBtnCompleteBlock tapRightBtnCompleteBlock;

@end
