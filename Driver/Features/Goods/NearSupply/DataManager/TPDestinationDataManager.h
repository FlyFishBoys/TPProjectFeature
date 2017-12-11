//
//  TPDestinationDataManager.h
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DestinationCompletionBlock)(BOOL success, id _Nullable responseObject , TPBusinessError * _Nullable error);


@interface TPDestinationDataManager : NSObject

+ (void)requestNearSupplyListCallback:(DestinationCompletionBlock _Nullable )callback;

@end
