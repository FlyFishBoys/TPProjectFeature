//
//  TPDModifyAuthenticationAPI.m
//  TopjetPicking
//
//  Created by zolobdz on 2017/8/16.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDModifyAuthenticationAPI.h"
#import "TPDAuthenticationModel.h"

@interface TPDModifyAuthenticationAPI ()
@property (nonatomic, strong) TPDAuthenticationModel * model;
@end

@implementation TPDModifyAuthenticationAPI
- (instancetype)initWithModel:(TPDAuthenticationModel *)model {
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (NSString *)requestMethod {
    return @"user-service/userpublic/usercentretypeauthdriver";
}

- (nullable NSString *)destination {
    return @"userpublic.usercentretypeauthdriver";
}

- (nullable id)businessParameters {
    return @{
             @"driver_license_img" : _model.driver_license_img.isNotBlank ? _model.driver_license_img : @"",
             @"driver_license_img_key" : _model.driver_license_img_key.isNotBlank ? _model.driver_license_img_key : @"",
             @"driver_operation_img" : _model.driver_operation_img.isNotBlank ? _model.driver_operation_img : @"",
             @"driver_operation_img_key" : _model.driver_operation_img_key.isNotBlank ? _model.driver_operation_img_key : @"",
             @"version" : _model.version.isNotBlank ? _model.version : @"",
             };
    
}
@end
