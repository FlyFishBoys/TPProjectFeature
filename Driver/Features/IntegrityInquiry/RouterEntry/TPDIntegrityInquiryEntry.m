//
//  TPDIntegrityInquiryEntry.m
//  TopjetPicking
//
//  Created by Mr.mao on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryEntry.h"
#import "TPDIntegrityInquiryViewController.h"
#import "TPDIntegrityInquiryResultViewController.h"
#import "TPDIntegrityInquiryModel.h"

@implementation TPDIntegrityInquiryEntry

+ (void)registerIntegrityInquiry {
    [MGJRouter registerURLPattern:TPRouter_IntegrityInquiry_Conteroller toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDIntegrityInquiryViewController * integrityInquiryViewController = [[TPDIntegrityInquiryViewController alloc]init];
        return integrityInquiryViewController;
    }];
}

+ (void)registerIntegrityInquiryResult {
    [MGJRouter registerURLPattern:TPRouter_IntegrityInquiryResult_Conteroller toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDIntegrityInquiryResultViewController * integrityInquiryResultViewController = [[TPDIntegrityInquiryResultViewController alloc]init];
        TPDIntegrityInquiryModel * model = [TPDIntegrityInquiryModel yy_modelWithJSON:routerParameters[MGJRouterParameterUserInfo][@"queryIntegrityInfo"]];
        integrityInquiryResultViewController.model = model;
        return integrityInquiryResultViewController;
    }];
}
@end
