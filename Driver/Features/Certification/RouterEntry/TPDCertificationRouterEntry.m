//
//  TPSCertificationRouterEntry.m
//  TopjetPicking
//
//  Created by lish on 2017/9/26.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDCertificationRouterEntry.h"
#import "TPDAuthenticationViewController.h"
#import "TPDVehicleCertificationViewController.h"
@implementation TPDCertificationRouterEntry
+ (void)registerAuthentication {
    
   
    [MGJRouter registerURLPattern:TPRouter_Authentication_Conteroller toObjectHandler:^id(NSDictionary *routerParameters) {
        
        TPDAuthenticationViewController * authenticationViewController = [[TPDAuthenticationViewController alloc]init];
        NSString * isRegistered = routerParameters[MGJRouterParameterUserInfo][@"isRegistered"];
        if ([isRegistered isEqualToString:@"1"]) {
            authenticationViewController.isRegistered = YES;
        }else{
            authenticationViewController.isRegistered = NO;
        }
        return authenticationViewController;
    }];
}

+ (void)registerVehicleCertification  {
    

    
    [MGJRouter registerURLPattern:TPRouter_VehicleCertification_Conteroller toObjectHandler:^id(NSDictionary *routerParameters) {
        
                TPDVehicleCertificationViewController * vehicleCertificationViewController = [[TPDVehicleCertificationViewController alloc]init];
                NSString * isRegistered = routerParameters[MGJRouterParameterUserInfo][@"isRegistered"];
                if ([isRegistered isEqualToString:@"1"]) {
                    vehicleCertificationViewController.isRegistered = YES;
                }else{
                    vehicleCertificationViewController.isRegistered = NO;
                }
        return vehicleCertificationViewController;
    }];
}
@end
