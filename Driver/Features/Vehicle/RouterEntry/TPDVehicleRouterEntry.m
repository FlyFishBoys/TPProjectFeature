//
//  TPDVehicleRouterEntry.m
//  Driver
//
//  Created by Mr.mao on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDVehicleRouterEntry.h"
#import "TPDMyVehicleTeamViewController.h"
#import "TPDVehicleDetailViewController.h"
#import "TPDAddModifyVehicleViewController.h"
#import "TPDAddModifyVehicleModel.h"

@implementation TPDVehicleRouterEntry

+ (void)registerVehicleMyVehicleTeam {
    [MGJRouter registerURLPattern:TPRouter_Vehicle_MyVehicleTeam_List toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDMyVehicleTeamViewController * vc = [[TPDMyVehicleTeamViewController alloc] init];
        return vc;
    }];
}

+ (void)registerVehicleDetail {
    [MGJRouter registerURLPattern:TPRouter_Vehicle_Detail toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDVehicleDetailViewController * vc = [[TPDVehicleDetailViewController alloc] init];
        vc.driverTruckId = routerParameters[MGJRouterParameterUserInfo][@"driverTruckId"];
        return vc;
    }];
}

    
+ (void)registerAddMOdifyVehicle {
    [MGJRouter registerURLPattern:TPRouter_Vehicle_Add_Modify toObjectHandler:^id(NSDictionary *routerParameters) {
        TPDAddModifyVehicleViewController * vc = [[TPDAddModifyVehicleViewController alloc] init];
        TPDAddModifyVehicleModel * model = [TPDAddModifyVehicleModel yy_modelWithJSON:routerParameters[MGJRouterParameterUserInfo][@"mdifyVehicleModel"]];
        vc.model = model;
        return vc;
    }];
}

@end
