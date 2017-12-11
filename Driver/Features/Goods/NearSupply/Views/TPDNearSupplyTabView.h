//
//  TPDNearSupplyTabView.h
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/4.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TPNearSupplyTabViewDelegate <NSObject>

- (void)chooseDestination:(NSString *)destination_city_ids;

- (void)chooseCarModel:(NSString *)lengthIds typeIds:(NSString *)typeIds;

@end

@interface TPDNearSupplyTabView : UIView

@property (nonatomic, weak) id <TPNearSupplyTabViewDelegate> delegate;

@end
