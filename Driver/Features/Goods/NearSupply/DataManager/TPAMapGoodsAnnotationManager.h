//
//  TPAMapGoodsAnnotationManager.h
//  Shipper
//
//  Created by 尹腾翔 on 2017/10/24.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

#import "TPNearSupplyMapModel.h"


@interface TPAMapGoodsAnnotationManager : NSObject

- (void)addGoodsAnnotationWithModel:(TPNearSupplyMapModel *)model mapView:(MAMapView *)mapView;

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation;

@end
