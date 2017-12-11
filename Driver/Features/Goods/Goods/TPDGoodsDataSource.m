//
//  TPDGoodsDataSource.m
//  TopjetPicking
//
//  Created by lish on 2017/11/10.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDGoodsDataSource.h"
#import "TPDGoodsCell.h"
#import "TPDGoodsAdvertCell.h"
#import "TPBaseTableViewSectionObject.h"
#import "TPDGoodsViewModel.h"
@implementation TPDGoodsDataSource {
    id _target;
    BOOL _isNeedNoResultView;
}
- (instancetype)init {
    if (self = [super init]) {
        TPBaseTableViewSectionObject * baseTableViewSectionObject = [[TPBaseTableViewSectionObject alloc] init];
        self.sections = [NSMutableArray arrayWithObject:baseTableViewSectionObject];
    }
    
    return self;
}

- (instancetype)initWithTarget:(id)target {
    
    self = [super init];
    if (self) {
       _target = target;
    }
    return self;
    
}
- (Class)tableView:(UITableView *)tableView cellClassForObject:(TPBaseTableViewItem *)object {
    
    if ([object isKindOfClass:[TPDGoodsItemViewModel class]]) {
        
        return [TPDGoodsCell class];
        
    } else {
        
        return [TPDGoodsAdvertCell class];
        
    }
}

- (TPNoResultViewType)noResultViewTypeForTableView:(UITableView *)tableView {
    return self.noResultViewType;
}

//刷新货源
- (void)refreshItemsWithGoodsModels:(NSArray <TPDGoodsModel *>*)goodsModels {
    [self clearSections];
    [self clearAllItems];
    TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:goodsModels target:_target];
    
    [self appendItems:viewModel.itemViewModels];
    
}
//刷新货源
- (void)refreshItemsWithResponseObject:(id)responseObject {
      if ([responseObject isKindOfClass:[NSDictionary class]]) {
          NSString *Icon_key = responseObject[@"Icon_key"];
          NSString *Icon_url = responseObject[@"Icon_url"];
          NSString *Icon_image_key = responseObject[@"Icon_image_key"];
          NSString *Icon_image_url = responseObject[@"Icon_image_url"];
          NSArray *list = [NSArray yy_modelArrayWithClass:[TPDGoodsModel class] json:responseObject[@"list"]];
          NSMutableArray *tempList = [NSMutableArray array];
          [list enumerateObjectsUsingBlock:^(TPDGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
              obj.Icon_key = Icon_key;
              obj.Icon_url = Icon_url;
              obj.Icon_image_key = Icon_image_key;
              obj.Icon_image_url = Icon_image_url;
              [tempList addObject:obj];
          }];
          [self clearSections];
          [self clearAllItems];
          TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:tempList target:_target];
          [self appendItems:viewModel.itemViewModels];
      } 
}

//加载更多数据
- (void)appendItemsWithResponseObject:(id)responseObject {
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        NSString *Icon_key = responseObject[@"Icon_key"];
        NSString *Icon_url = responseObject[@"Icon_url"];
        NSString *Icon_image_key = responseObject[@"Icon_image_key"];
        NSString *Icon_image_url = responseObject[@"Icon_image_url"];
        NSArray *list = [NSArray yy_modelArrayWithClass:[TPDGoodsModel class] json:responseObject[@"list"]];
        NSMutableArray *tempList = [NSMutableArray array];
        [list enumerateObjectsUsingBlock:^(TPDGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.Icon_key = Icon_key;
            obj.Icon_url = Icon_url;
            obj.Icon_image_key = Icon_image_key;
            obj.Icon_image_url = Icon_image_url;
            [tempList addObject:obj];
        }];
        TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:tempList target:_target];
        [self appendItems:viewModel.itemViewModels];
        
    }

    
}

//加载更多货源
- (void)appendItemsWithGoodsModels:(NSArray <TPDGoodsModel *>*)goodsModels {
    
    TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:goodsModels target:_target];
    [self appendItems:viewModel.itemViewModels];
    
}

//插入货源广告
- (void)insertGoodsAdvertWithResponseObject:(id)responseObject {
    

    NSArray *advertArr = [NSArray arrayWithArray:responseObject];
    
    TPGoodsListAdvertViewModel *viewModel = [[TPGoodsListAdvertViewModel alloc]initWithAdvertArray:advertArr target:_target];
    
    [viewModel.goodsListAdvertArr enumerateObjectsUsingBlock:^(TPGoodsListAdvertItemViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self clearItemAtIndex:obj.model.index_number.intValue];
        [self insertItem:obj atIndex:obj.model.index_number.intValue];
    }];
}

////加载找货更多数据
//- (void)appendFindGoodsItemsWithResponseObject:(id)responseObject{
//    
//    
//    
//    NSString *Icon_key = responseObject[@"Icon_key"];
//    NSString *Icon_url = responseObject[@"Icon_url"];
//    NSString *Icon_image_key = responseObject[@"Icon_image_key"];
//    NSString *Icon_image_url = responseObject[@"Icon_image_url"];
//    NSArray *list = [NSArray yy_modelArrayWithClass:[TPDGoodsModel class] json:responseObject[@"list"]];
//    NSMutableArray *tempList = [NSMutableArray array];
//    [list enumerateObjectsUsingBlock:^(TPDGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.Icon_key = Icon_key;
//        obj.Icon_url = Icon_url;
//        obj.Icon_image_key = Icon_image_key;
//        obj.Icon_image_url = Icon_image_url;
//        [tempList addObject:obj];
//    }];
//    
//    TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:tempList target:_target];
//    [self appendItems:viewModel.itemViewModels];
//}
//
//
////刷新找货货源
//- (void)refreshFindGoodsItemsWithResponseObject:(id)responseObject{
//    
//    [self clearSections];
//    [self clearAllItems];
//    NSString *Icon_key = responseObject[@"Icon_key"];
//    NSString *Icon_url = responseObject[@"Icon_url"];
//    NSString *Icon_image_key = responseObject[@"Icon_image_key"];
//    NSString *Icon_image_url = responseObject[@"Icon_image_url"];
//    NSArray *list = [NSArray yy_modelArrayWithClass:[TPDGoodsModel class] json:responseObject[@"list"]];
//    NSMutableArray *tempList = [NSMutableArray array];
//    [list enumerateObjectsUsingBlock:^(TPDGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.Icon_key = Icon_key;
//        obj.Icon_url = Icon_url;
//        obj.Icon_image_key = Icon_image_key;
//        obj.Icon_image_url = Icon_image_url;
//        [tempList addObject:obj];
//    }];
//    
//    TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:tempList target:_target];
//    [self appendItems:viewModel.itemViewModels];
//    
//}
//
//
//-(void)refreshGoodsItemsWithResponseObject:(id)responseObject {
//   
//    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//       
//        NSString *Icon_key = responseObject[@"Icon_key"];
//        NSString *Icon_url = responseObject[@"Icon_url"];
//        NSString *Icon_image_key = responseObject[@"Icon_image_key"];
//        NSString *Icon_image_url = responseObject[@"Icon_image_url"];
//        NSArray *list = [NSArray yy_modelArrayWithClass:[TPDGoodsModel class] json:responseObject[@"list"]];
//        NSMutableArray *tempList = [NSMutableArray array];
//        [list enumerateObjectsUsingBlock:^(TPDGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.Icon_key = Icon_key;
//            obj.Icon_url = Icon_url;
//            obj.Icon_image_key = Icon_image_key;
//            obj.Icon_image_url = Icon_image_url;
//            [tempList addObject:obj];
//        }];
//        [self clearSections];
//        [self clearAllItems];
//        TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:tempList target:_target];
//        [self appendItems:viewModel.itemViewModels];
//        
//    } else if([responseObject isKindOfClass:[NSArray class]]) {
//        NSArray *goodsModels = [NSArray arrayWithArray:responseObject];
//       __block BOOL check = YES;
//        [goodsModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (![obj isKindOfClass:[TPDGoodsModel class]]) {
//                check = NO;
//                *stop = YES;
//                
//            }
//        }];
//        if (!check) {
//            return;
//        }
//        [self clearSections];
//        [self clearAllItems];
//        TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:goodsModels target:_target];
//        
//        [self appendItems:viewModel.itemViewModels];
//        
//        
//    }
//    
//}
//-(void)appendGoodsItemsWithResponseObject:(id)responseObject {
//    
//    if ([responseObject isKindOfClass:[NSDictionary class]]) {
//        
//        NSString *Icon_key = responseObject[@"Icon_key"];
//        NSString *Icon_url = responseObject[@"Icon_url"];
//        NSString *Icon_image_key = responseObject[@"Icon_image_key"];
//        NSString *Icon_image_url = responseObject[@"Icon_image_url"];
//        NSArray *list = [NSArray yy_modelArrayWithClass:[TPDGoodsModel class] json:responseObject[@"list"]];
//        NSMutableArray *tempList = [NSMutableArray array];
//        [list enumerateObjectsUsingBlock:^(TPDGoodsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.Icon_key = Icon_key;
//            obj.Icon_url = Icon_url;
//            obj.Icon_image_key = Icon_image_key;
//            obj.Icon_image_url = Icon_image_url;
//            [tempList addObject:obj];
//        }];
//        TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:tempList target:_target];
//        [self appendItems:viewModel.itemViewModels];
//        
//    } else if([responseObject isKindOfClass:[NSArray class]]) {
//        NSArray *goodsModels = [NSArray arrayWithArray:responseObject];
//        __block BOOL check = YES;
//        [goodsModels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (![obj isKindOfClass:[TPDGoodsModel class]]) {
//                check = NO;
//                *stop = YES;
//                
//            }
//        }];
//        if (!check) {
//            return;
//        }
//
//        TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:goodsModels target:_target];
//        
//        [self appendItems:viewModel.itemViewModels];
//        
//        
//    }
//    
//}
//
///**
// 加载听单的货源
// 
// @param responseObject 听单的货源数据
// */
//-(void)appendListenOrderGoodsItemsWithResponseObject:(NSArray <TPDGoodsModel *>*)responseObject {
//    
//    if([responseObject isKindOfClass:[NSArray class]]) {
//        TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:responseObject target:_target];
//        [self appendItems:viewModel.itemViewModels];
//        
//    }
//}
//
///**
// 刷新听单的货源
// 
// @param responseObject 听单的货源数据
// */
//-(void)refreshListenOrderGoodsItemsWithResponseObject:(NSArray <TPDGoodsModel *>*)responseObject {
//    
//    if([responseObject isKindOfClass:[NSArray class]]) {
//        [self clearSections];
//        [self clearAllItems];
//        TPDGoodsViewModel *viewModel = [[TPDGoodsViewModel alloc] initWithGoodsModels:responseObject target:_target];
//        
//        [self appendItems:viewModel.itemViewModels];
//    }
//}

@end
