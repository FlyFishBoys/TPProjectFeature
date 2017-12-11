//
//  TPDProfileDefines.h
//  TopjetPicking
//
//  Created by lish on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#ifndef TPDProfileDefines_h
#define TPDProfileDefines_h

typedef void (^TPDProfileMiddleItemHandler)(NSInteger index);

#define TPDProfileMiddleView_Titles @[@"实名认证",@"身份认证",@"车辆认证",@"常跑城市",@"通话记录",@"分享下载"]


#define TPDProfileMiddleView_Icons @[@"personal_center_authentication_icon",@"personal_center_identity_icon",@"personal_center_veihcle_icon",@"personal_center_integral_task_icon",@"personal_center_call_record_icon",@"personal_center_sharae_download_icon"]


#define TPDProfileMiddleView_URLS @[TPRouter_Verified_Conteroller,TPRouter_Authentication_Conteroller,TPRouter_VehicleCertification_Conteroller,TPRouter_ConstantCity_Controller,TPRouter_CallRecords,TPRouter_ShareDownload]


#endif /* TPDProfileDefines_h */
