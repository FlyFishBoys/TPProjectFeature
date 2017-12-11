//
//  TPDIntegrityInquiryDataManager.h
//  TopjetPicking
//
//  Created by Mr.mao on 2017/11/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LTPContactModel;

@interface TPDIntegrityInquiryDataManager : NSObject

//获取联系人
- (void)contactsWithComplection:(void (^)(NSArray <LTPContactModel *> *contacts))completcion;

//保存联系人
- (void)saveContactWithMobile:(NSString *)mobile;

//匹配联系人
- (void)matchContactsWithMobile:(NSString *)mobile complection:(void (^)(NSArray <LTPContactModel *> *contacts))completcion;

//诚信查询
- (void)inquireIntegrityWithMobile:(NSString *)mobile complection:(void (^)(BOOL success,TPBusinessError * error,NSDictionary * queryIntegrityInfo))completcion;
@end
