//
//  TPDProfileViewModel.m
//  TopjetPicking
//
//  Created by lish on 2017/10/25.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileViewModel.h"

@implementation TPDProfileViewModel
- (instancetype)init {
    self = [super init];
    if (self) {
        
      self.model = [[TPDProfileModel alloc]init];
    }
    return self;
}
- (void)blindViewModel:(TPDProfileModel *)model {

    self.model = model;
    [self setUserStatus];
    [self setUserAuthStatus];
    [self setIconImageStatus];
    [self setSignStatus];
    [self setVehicleStatuss];
    [self setObtainIntegral];
    
}

- (void)setUserStatus {
    
    switch (self.model.use_status.intValue) {
        case 0:
            self.userStatus = @"未认证";
            break;
            
        case 1:
             self.userStatus = @"认证中";
            break;
            
        case 2:
             self.userStatus = @"";
            break;
        case 3:
             self.userStatus = @"资料修改待审核";
            break;
        case 4:
            self.userStatus = @"认证失败";
            break;
    }
    
    if (self.model.use_status.intValue == 2) {
        self.name = self.model.user_name;
        self.userStatusIcon = [UIImage imageNamed:@"personal_center_have_authenticated_bg"];
    }else{
        self.name = @"新用户";
        self.userStatusIcon = [UIImage imageNamed:@"personal_center_no_authenticated_bg"];
    }
    
}


- (void)setIconImageStatus {
    
    switch (self.model.icon_image_status.intValue) {
        case 0:
            self.iconImageStatus = @"未认证";
            self.usericonAuditImage = nil;
            break;
            
        case 1:
            self.iconImageStatus = @"认证中";
            self.usericonAuditImage = [UIImage imageNamed:@"personal_center_audit_icon"];
            break;
            
        case 2:
            self.iconImageStatus = @"认证失败";
            self.usericonAuditImage = nil;
            break;
        case 3:
            self.iconImageStatus = @"认证通过";
            self.usericonAuditImage = nil;
            break;
    }
    
    
}

- (void)setUserAuthStatus {
    
    switch (self.model.user_auth_status.intValue) {
        case 0:
            self.userAuthStatus = @"未认证";
            break;
            
        case 1:
            self.userAuthStatus = @"认证中";
            break;
            
        case 2:
            self.userAuthStatus = @"认证失败";
            break;
        case 3:
            self.userAuthStatus = @"认证通过";
            break;
    }
}
- (void)setVehicleStatuss {
    
    switch (self.model.audit_status.intValue) {
        case 1:
            self.vehicleStatus = @"未认证";
            break;
            
        case 2:
            self.vehicleStatus = @"已认证";
            break;
            
        case 3:
            self.vehicleStatus = @"认证中";
            break;
        case 4:
            self.vehicleStatus = @"认证失败";
            break;
          default:
            self.vehicleStatus = @"未认证";
            break;
       
    }
    
}

- (void)setSignStatus {
    
    switch (self.model.sign_status.intValue) {
        case 1:
            self.signStatus = @"已签到";
            self.isSignIn = YES;
            break;
            
        case 0:
            self.signStatus = @"签到";
            self.isSignIn = NO;
            break;
            
    }
}

- (void)setObtainIntegral{
    
    if ([self.model.obtain_integral isNotBlank]) {
        if (self.isSignIn) {
            self.obtainIntegral = [[@"明日+" stringByAppendingString:self.model.obtain_integral]stringByAppendingString:@"积分"];
        }else{
            self.obtainIntegral = [[@"今日+" stringByAppendingString:self.model.obtain_integral]stringByAppendingString:@"积分"];
        }
    }
}

@end
