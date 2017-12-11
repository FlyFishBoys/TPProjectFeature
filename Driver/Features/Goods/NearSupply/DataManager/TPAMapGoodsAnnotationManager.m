//
//  TPAMapGoodsAnnotationManager.m
//  Shipper
//
//  Created by 尹腾翔 on 2017/10/24.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPAMapGoodsAnnotationManager.h"

#import "TPCustomPolyAnnotationView.h"
#import "TPCustomDistrictAnnotationView.h"

#import "TPCustomSingleAnnotation.h"
#import "TPCustomDistrictAnnotation.h"
#import "TPCustomPolyAnnotation.h"
#import "CoordinateQuadTree.h"

@interface TPAMapGoodsAnnotationManager ()

@property (nonatomic, assign) BOOL shouldRegionChangeReCalculate;

@property (nonatomic, strong) CoordinateQuadTree* coordinateQuadTree;

@end

@implementation TPAMapGoodsAnnotationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _shouldRegionChangeReCalculate = NO;
        self.coordinateQuadTree = [[CoordinateQuadTree alloc] init];
    }
    return self;
}
- (void)addGoodsAnnotationWithModel:(TPNearSupplyMapModel *)model mapView:(MAMapView *)mapView {
    if ([model.parameter_level integerValue] == 1)
    {
        [self addStatisticalData:model.goods_statistical mapView:mapView];
    }
    else if ([model.parameter_level integerValue] == 2)
    {
        [self addClusterData:model.near_goods_response_list mapView:mapView];
    }
    else {
        [mapView removeAnnotations:mapView.annotations];
    }
}

- (void)addStatisticalData:(NSArray <TPGoodsStatistical *> *)data mapView:(MAMapView *)mapView
{
    //每次添加 先清空之前
    if (data.count <= 0) {
        return;
    }
    [mapView removeAnnotations:mapView.annotations];
    
    for (NSInteger i = 0; i < data.count; i++) {
        
        TPGoodsStatistical *goodsStatistical = (TPGoodsStatistical *)[data objectAtIndex:i];
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake([goodsStatistical.latitude doubleValue],
                                                                       [goodsStatistical.longitude doubleValue]);
        TPCustomDistrictAnnotation *annotation = [[TPCustomDistrictAnnotation alloc] initWithCoordinate:coordinate];
        annotation.cityCode = goodsStatistical.city_id;
        annotation.cityName = goodsStatistical.city_name;
        annotation.count = [goodsStatistical.count integerValue];
        annotation.model = goodsStatistical; //数据的model
        annotation.customAnnotationType = CustomAnnotationType_NearSupply;
        [mapView addAnnotation:annotation];
    }
}
- (void)addClusterData:(NSArray<TPDGoodsModel *> *)data mapView:(MAMapView *)mapView {
    
    if (data.count <= 0) {
        return;
    }
    
    [mapView removeAnnotations:mapView.annotations];
    
    //异步计算聚合
    @synchronized(self) {
        self.shouldRegionChangeReCalculate = NO;
        // 清理
        [mapView removeAnnotations:mapView.annotations];
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            /* 建立四叉树. */
            [weakSelf.coordinateQuadTree buildTreeWithTruckData:data];
            self.shouldRegionChangeReCalculate = YES;
            [weakSelf addAnnotationsToMapViewForRefresh:mapView];
        });
    }
}
- (void)addAnnotationsToMapViewForRefresh:(MAMapView *)mapView
{
    @synchronized(self)
    {
        if (self.coordinateQuadTree.root == nil || !self.shouldRegionChangeReCalculate)
        {
            DDLog(@"tree is not ready.");
            return;
        }
        
        /* 根据当前zoomLevel和zoomScale 进行annotation聚合. */
        MAMapRect visibleRect = mapView.visibleMapRect;
        double zoomScale = mapView.bounds.size.width / visibleRect.size.width;
        double zoomLevel = mapView.zoomLevel;
        
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSArray *annotations = [weakSelf.coordinateQuadTree clusteredAnnotationsWithinMapRect:visibleRect
                                                                                    withZoomScale:zoomScale
                                                                                     andZoomLevel:zoomLevel];
            /* 更新annotation. */
            [weakSelf updateMapViewAnnotationsWithAnnotations:annotations :mapView];
        });
    }
}
#pragma mark - update Annotation
/* 更新annotation. */
- (void)updateMapViewAnnotationsWithAnnotations:(NSArray *)annotations :(MAMapView *)mapView
{
    /* 用户滑动时，保留仍然可用的标注，去除屏幕外标注，添加新增区域的标注 */
    NSMutableSet *before = [NSMutableSet setWithArray:mapView.annotations];
    [before removeObject:[mapView userLocation]];
    NSSet *after = [NSSet setWithArray:annotations];
    
    /* 保留仍然位于屏幕内的annotation. */
    NSMutableSet *toKeep = [NSMutableSet setWithSet:before];
    [toKeep intersectSet:after];
    
    /* 需要添加的annotation. */
    NSMutableSet *toAdd = [NSMutableSet setWithSet:after];
    [toAdd minusSet:toKeep];
    
    /* 删除位于屏幕外的annotation. */
    NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
    [toRemove minusSet:after];
    
    /* 更新. */
    dispatch_async(dispatch_get_main_queue(), ^{
        [mapView addAnnotations:[toAdd allObjects]];
        [mapView removeAnnotations:[toRemove allObjects]];
    });
}
#pragma mark - 生成annotationView
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    //单个点
    if ([annotation isKindOfClass:[TPCustomSingleAnnotation class]])
    {
        /* dequeue重用annotationView. */
        static NSString *const AnnotatioViewReuseID = @"TPCustomPolyAnnotationView";
        
        TPCustomPolyAnnotationView *annotationView = [TPCustomPolyAnnotationView initWithIdentifier:AnnotatioViewReuseID
                                                                                            mapView:mapView
                                                                                  viewForAnnotation:annotation];
        
        annotationView.bgImage = [UIImage imageNamed:@"im_icon_locate_village"];
        /* 不弹出原生annotation */
        annotationView.canShowCallout = NO;
        /* 设置annotationView的属性. */
        annotationView.annotation = annotation;
        annotationView.count = 1;
        annotationView.countLabel.hidden = YES;
        return annotationView;
    }
    
    //聚合点
    if ([annotation isKindOfClass:[TPCustomPolyAnnotation class]])
    {
        /* dequeue重用annotationView. */
        static NSString *const AnnotatioViewReuseID = @"TPCustomPolyAnnotationView";
        
        TPCustomPolyAnnotationView *annotationView = [TPCustomPolyAnnotationView initWithIdentifier:AnnotatioViewReuseID
                                                                                            mapView:mapView
                                                                                  viewForAnnotation:annotation];
        annotationView.bgImage = [UIImage imageNamed:@"im_icon_locate_town"];
        /* 不弹出原生annotation */
        annotationView.canShowCallout = NO;
        /* 设置annotationView的属性. */
        annotationView.annotation = annotation;
        annotationView.count = [(TPCustomPolyAnnotation *)annotation count];
        annotationView.countLabel.hidden = NO;
        return annotationView;
        
    }
    
    //省市标注
    if ([annotation isKindOfClass:[TPCustomDistrictAnnotation class]]) {
        /* dequeue重用annotationView. */
        static NSString *const AnnotatioViewReuseID = @"TPCustomDistrictAnnotationView";
        
        TPCustomDistrictAnnotationView *annotationView = [TPCustomDistrictAnnotationView initWithIdentifier:AnnotatioViewReuseID
                                                                                                    mapView:mapView
                                                                                          viewForAnnotation:annotation];
        
        TPCustomDistrictAnnotation * districtAnnotation = (TPCustomDistrictAnnotation *)annotation;
        
        NSString *text = [NSString stringWithFormat:@"%@\n%zd\n单",districtAnnotation.cityName,districtAnnotation.count];
        annotationView.titleText = text;//拼接字符串
        
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:text];
        [labelString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[text rangeOfString:[NSString stringWithFormat:@"%zd",districtAnnotation.count]]];
        annotationView.attTitleText = labelString;
        
        /* 不弹出原生annotation */
        annotationView.canShowCallout = NO;
        /* 设置annotationView的属性. */
        annotationView.annotation = annotation;
        annotationView.dataModel = ((TPCustomDistrictAnnotation *)annotation).model;
        
        return annotationView;
    }
    
    return nil;
}
@end
