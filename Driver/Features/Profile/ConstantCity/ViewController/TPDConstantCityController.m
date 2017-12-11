//
//  TPConstantCityController.m
//  TopjetPicking
//
//  Created by lish on 2017/10/20.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDConstantCityController.h"
#import "TPDConstantCityViewModel.h"
#import "TPDAddConstantCell.h"
#import "UIImage+Gradient.h"
#import "TPDConstantCityDataManager.h"
#import "TPCitySelectView.h"
@interface TPDConstantCityController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) TPDConstantCityViewModel *constantCityViewModel;

@property (nonatomic , strong) UIButton *submitBtn;

@property (nonatomic , assign) BOOL needUpdateRequest;//是否需要请求

@end

@implementation TPDConstantCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = TPBackgroundColor;
    [self initNavigation];
    [self addSubviews];
    [self setFrame];
    [self requestConstantCityApi];
   
}


//添加常跑城市
- (void)addConstantCity {
    
    if (_constantCityViewModel.constantCitysArr.count >= 8) {
        
        TPShowToast(@"最多允许添加八个城市！");
        return;
    }
    _needUpdateRequest = YES;
    @weakify(self);
    [TPCitySelectView citySelectViewWithType:SELECTVIEW_Third_ALL_AREA block:^(TPAddressModel *selectCityModel) {
         @strongify(self);
        [self.constantCityViewModel addAdressModel:selectCityModel];
        [self.tableView reloadData];
    } dismissBlock:^{
        
    }];
    
}
//更改常跑城市
- (void)updateConstantCity:(NSInteger)index {
    
    _needUpdateRequest = YES;
    [TPCitySelectView citySelectViewWithType:SELECTVIEW_Third_ALL_AREA block:^(TPAddressModel *selectCityModel) {
        
        [self.constantCityViewModel updateConstantCity:selectCityModel index:index];
        [self.tableView reloadData];
        
    }dismissBlock:^{
        
    }];
}
//删除常跑城市
- (void)deleteConstantCity:(NSInteger)index {
    _needUpdateRequest = YES;
    //删除
    [self.constantCityViewModel deleteConstantCity:index];
    [self.tableView reloadData];
}

//请求常跑城市系列表
- (void)requestConstantCityApi {

    
    [TPDConstantCityDataManager requestPersonCenterConstantCityListAPIWithCompleteBlock:^(BOOL succeed, id responseObjet, TPBusinessError *error) {
        if (succeed) {

            [self.constantCityViewModel blindConstantCityViewModel:responseObjet];
            [self.tableView reloadData];
        }else{
            TPShowToast(error.business_msg);
        }
    }];
    
}
//请求提交常跑城市API
- (void)requestSubmitConstantCityApi{
    
    if (!_needUpdateRequest) {
         TPShowToast(@"您未修改信息，无需提交");
         return;
    }
    

    [TPDConstantCityDataManager requestPersonCenterSubmitConstantCityAPIWithAddBusinessLineCityCodes:self.constantCityViewModel.addBusinessLineCityCodesArr updateBusinessLines:self.constantCityViewModel.updateBusinessLinesArr deleteBusinessLineIds:self.constantCityViewModel.deleteBusinessLineIdsArr completeBlock:^(BOOL succeed, id responseObjet, TPBusinessError *error) {
       
        if (succeed) {
            [self.navigationController popViewControllerAnimated:YES];
            TPShowToast(@"提交成功");
        }else{
            TPShowToast(@"提交失败，请重试");
        }
    }];
}

#pragma mark - System Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TPDAddConstantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addConstantCityCell"];
    
    if (cell) {
        cell.right_btn_type = indexPath.row?RIGHT_BTN_DELETE:RIGHT_BTN_ARROWS;
        cell.model = _constantCityViewModel.constantCitysArr[indexPath.row].addressModel;
        cell.hideLocationIcon = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        @weakify(self);
        cell.AddConstantCellTapArrowHandler = ^{
            @strongify(self);
            [self deleteConstantCity:indexPath.row];
            
        };
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    _needUpdateRequest = YES;
    [self updateConstantCity:(indexPath.row)];

   
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TPAdaptedHeight(48);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.constantCityViewModel.constantCitysArr.count;
}

#pragma mark - custom UI
- (void)initNavigation {
    
    self.title = @"添加常跑城市";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addConstantCity)];
    
}
- (void)addSubviews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitBtn];
}

- (void)setFrame {
    
    [_submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.height.mas_equalTo(TPAdaptedHeight(44));
        make.width.mas_equalTo(TPAdaptedWidth(351));
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-16));
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.top.equalTo(self);
        make.bottom.equalTo(_submitBtn.mas_top);
        
    }];
    
   
}
#pragma mark - Getters and Setters
- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = TPBackgroundColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TPDAddConstantCell class] forCellReuseIdentifier:@"addConstantCityCell"];
    }
    return _tableView;
}

- (UIButton *)submitBtn {
    
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType: UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:0];
        [_submitBtn setTitleColor:TPWhiteColor forState:0];
        _submitBtn.layer.cornerRadius = TPAdaptedHeight(22);
        _submitBtn.layer.masksToBounds = YES;
        [_submitBtn setBackgroundImage:[UIImage createGradientImageWithSize:CGSizeMake(TPAdaptedWidth(351), TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor] forState:0];
        [_submitBtn addTarget:self action:@selector(requestSubmitConstantCityApi) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitBtn;
    
}

- (TPDConstantCityViewModel *)constantCityViewModel {
    if (!_constantCityViewModel) {
        _constantCityViewModel = [[TPDConstantCityViewModel alloc]init];
    }
    return _constantCityViewModel;
    
}
@end
