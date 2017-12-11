//
//  TPDDestinationView.m
//  TopjetPicking
//
//  Created by 尹腾翔 on 2017/9/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDDestinationView.h"

#import "TPBaseTableView.h"

#import "TPDestinationDataSource.h"

#import "TPDestinationDataManager.h"

#import "TPCitySelectView.h"

#import "TPBaseTableViewSectionObject.h"

#import "TPDDestinationCell.h"

@interface TPDDestinationView ()<TPBaseTableViewDelegate,TPDestinationCellDelegate>

@property (nonatomic, strong)  TPBaseTableView * tableView;

@property (nonatomic, strong)  TPDestinationDataSource * dataSource;

@property (nonatomic, copy)    DestinationComplete destinationComplete;

@property (nonatomic, copy)    DestinationDismiss destinationDismiss;

@property (nonatomic, strong)  TPDDestinationViewModel *viewModel;

@property (nonatomic, strong)  TPDestinationItemViewModel *lastMTModel;

@property (nonatomic, strong)  NSMutableArray *selectRows;

@end

@implementation TPDDestinationView

#pragma mark -

- (TPBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.isNeedPullDownToRefreshAction = NO;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
    }
    return _tableView;
}

- (TPDestinationDataSource *)dataSource {
    if (!_dataSource) {
        _dataSource = [[TPDestinationDataSource alloc] init];
    }
    return _dataSource;
    
}

- (NSMutableArray *)selectRows
{
    if (!_selectRows) {
        _selectRows = @[].mutableCopy;
    }
    return _selectRows;
}

- (void)setSelectDestinations:(NSArray<TPDestinationItemViewModel *> *)selectDestinations
{
    _selectDestinations = selectDestinations;

    [self.viewModel.viewModels enumerateObjectsUsingBlock:^(TPDestinationItemViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        for (int i = 0; i < _selectDestinations.count; i ++) {
            TPDestinationItemViewModel *model = [_selectDestinations objectAtIndex:i];
            if ([obj.business_line_city_id isEqualToString:model.business_line_city_id]) {
                obj.isSelectCell = YES;
            }
        }
        
    }];
    [self.tableView reloadData];
    
}

#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4/1.0];

        [self addSubview:self.tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@(0));
            make.width.mas_equalTo(TPScreenWidth);
            make.left.equalTo(self);
            make.height.equalTo(@(TPAdaptedHeight(468.0)));
            
        }];
        
        [self loadData];
        
    }
    return self;
}

- (void)showViewInWindowWithTop:(CGFloat)top
                 handleComplete:(DestinationComplete)destinationComplete
                  filterDismiss:(DestinationDismiss)destinationDismiss
{
    
    
    self.destinationComplete = destinationComplete;
    self.destinationDismiss = destinationDismiss;

    //重新设置view的坐标
    self.top = top;
    self.height = 0;
    self.alpha = 1;

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.height = TPScreenHeight - top;
    } completion:^(BOOL finished) {
        
    }];
    
}


- (void)disMissFilterView
{
    [self clickClose:nil];
}

#pragma mark -

- (void)clickConfirm:(id)sender
{
    if (self.destinationComplete) {
        self.destinationComplete(self.selectRows);
        self.destinationComplete = nil;
    }
    
    [self disMissFilterView];
}

- (void)clickClose:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.destinationComplete = nil;
        if (self.destinationDismiss) {
            self.destinationDismiss();
            self.destinationDismiss = nil;
        }
    }];
    
}

#pragma mark - TPDestinationCellDelegate

- (void)selectIconBtn:(id)data
{
    [self resetModel:(TPDestinationItemViewModel *)data];
}

#pragma mark -
- (void)resetModel:(TPDestinationItemViewModel *)model
{
    if (![self.selectRows containsObject:model]) {
        model.isSelectCell = YES;
        
        [self.selectRows addObject:model];
        
    }else {
        model.isSelectCell = NO;
        
        [self.selectRows removeObject:model];
        
    }
    
    [self.tableView reloadData];
}

#pragma mark -
- (void)didSelectObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == self.viewModel.viewModels.count - 1) {
        @weakify(self);
        [TPCitySelectView citySelectViewWithType:SELECTVIEW_Gloab_NO_ALL_AREA block:^(TPAddressModel *selectCityModel) {
            @strongify(self);

            TPDestinationItemViewModel *model = (TPDestinationItemViewModel *)[((TPBaseTableViewSectionObject *)[self.dataSource.sections lastObject]).items lastObject];
            
            model.business_line_city = selectCityModel.formatted_area;
            model.business_line_city_id = selectCityModel.adcode;
            model.isSelectCell = YES;
            
            if (self.lastMTModel) {
                [self.selectRows removeObject:self.lastMTModel];
            }
            [self.selectRows addObject:model];
            self.lastMTModel = model;
            
            
            
            [self.tableView reloadData];

        }dismissBlock:^{
            
        }];
        
        return;
    }
    
    TPDestinationItemViewModel *model = (TPDestinationItemViewModel *)[((TPBaseTableViewSectionObject *)[self.dataSource.sections lastObject]).items objectAtIndex:indexPath.row];
    [self resetModel:model];
}



- (UIView *)footerViewForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section
{
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TPScreenWidth, 84.0)];
    
    UIButton *button = [UIButton buttonWithType:0];
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 22.0;
    button.backgroundColor = UIColorHex(646FFF);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    button.frame = CGRectMake(12, 24, TPScreenWidth-24, 44);
    [button addTarget:self action:@selector(clickConfirm:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:button];
    
    
    return footerView;
}

- (CGFloat)footerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section
{
    return 84.0;
}

- (CGFloat)headerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section
{
    return 0.001;
}
#pragma mark -


- (void)loadData
{
    [TPDestinationDataManager requestNearSupplyListCallback:^(BOOL success, id  _Nullable responseObject, TPBusinessError * _Nullable error) {
        if (success && !error) {
            
            [self.tableView stopRefreshingAnimation];

            
            self.viewModel = [[TPDDestinationViewModel alloc] initWithModels:responseObject target:self];
            [self.dataSource appendItems:self.viewModel.viewModels];
            
            TPDestinationItemViewModel *model = [[TPDestinationItemViewModel alloc] init];
            model.bussiness_line_id = @"-1";
            model.driver_id = @"-1";
            model.business_line_city = @"手动选择城市";
            model.business_line_city_id = @"-1";
            model.isSelectCell = NO;
            [self.dataSource appendItem:model atSection:0];
            
            [self.viewModel appendModel:model target:self];
                        
            [self.tableView reloadData];
            
        }
    }];
    
}
@end
