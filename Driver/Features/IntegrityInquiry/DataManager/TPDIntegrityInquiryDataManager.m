//
//  TPDIntegrityInquiryDataManager.m
//  TopjetPicking
//
//  Created by Mr.mao on 2017/11/14.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryDataManager.h"
#import "LTPContactModel.h"
#import "LJContactManager.h"
#import "NSFileManager+Category.h"
#import "TPDIntegrityInquiryAPI.h"

static NSString * const kFileName = @"IntegrityInquiry";
static NSString * const kDirectoryName = @"SearchHistory";

@interface TPDIntegrityInquiryDataManager ()
@property (nonatomic,strong) NSArray * allContracts;
@end

@implementation TPDIntegrityInquiryDataManager

- (void)contactsWithComplection:(void (^)(NSArray<LTPContactModel *> *))completcion {
    @weakify(self);
    [[LJContactManager sharedInstance] obtainContactListComplection:^(BOOL succeed, NSArray<LTPContactModel *> *contacts) {
        @strongify(self);
        if (succeed) {
            //手机通讯录联系人
            self.allContracts = contacts;
            completcion(contacts);
        } else {
            //历史联系人
            [NSFileManager getModelObjectByFileName:kFileName directoryName:kDirectoryName completeBlock:^(BOOL succeed, NSArray * result) {
                @strongify(self);
                self.allContracts = contacts;
                completcion(result);
            }];
        }
    }];
}

- (void)saveContactWithMobile:(NSString *)mobile {
    __block LTPContactModel * model = [[LTPContactModel alloc] init];
    model.contactMobile = mobile;
    [NSFileManager getModelObjectByFileName:kFileName directoryName:kDirectoryName completeBlock:^(BOOL succeed, NSArray * result) {
        NSMutableArray * array = [[NSMutableArray alloc] initWithArray:result];
        __block BOOL isContain;
        [array enumerateObjectsUsingBlock:^(LTPContactModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:model]) {
                isContain = YES;
                * stop = YES;
            }
        }];
        if (!isContain) {
            if (array.count >= 3) {
                [array removeLastObject];
            }
            [array insertObject:model atIndex:0];
            [NSFileManager saveModelObject:array directoryName:kDirectoryName fileName:kFileName];
        }
    }];
}

- (void)matchContactsWithMobile:(NSString *)mobile complection:(void (^)(NSArray<LTPContactModel *> *))completcion {
    if (mobile.length) {
        //输入文字后匹配联系人
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSPredicate * predicate = [NSPredicate predicateWithFormat:@"(SELF.contactMobile CONTAINS[cd] %@)",mobile];
            NSArray * contacts = [self.allContracts filteredArrayUsingPredicate:predicate];
            dispatch_async(dispatch_get_main_queue(), ^{
                completcion(contacts);
            });
        });
    } else {
        completcion(self.allContracts);
    }
}

- (void)inquireIntegrityWithMobile:(NSString *)mobile complection:(void (^)(BOOL, TPBusinessError *, NSDictionary *))completcion {
    TPDIntegrityInquiryAPI * api = [[TPDIntegrityInquiryAPI alloc] initWithMobile:mobile];
    api.filterCompletionHandler = ^(BOOL success, id  _Nonnull responseObject, TPBusinessError * _Nullable error) {
        if (success && error == nil) {
            NSDictionary * dict = responseObject[@"query_integrity_user_info"];
            completcion(YES,nil,dict);
        } else {
            completcion(NO,error,nil);
        }
    };
    [api start];
}
@end
