//
//  TPDAddConstantCityView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDAddConstantCityView.h"
#import "TPDAddConstantCell.h"
#import "TPLocationServices.h"
#import "TPCityAdressService.h"
#import "TPDAddConstantCityView.h"
#import "TPCitySelectView.h"
#import "TPDConstantCityDataManager.h"

@interface TPDAddConstantCityView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic , strong) UIView *whiteBg;

@property (nonatomic , strong) UILabel *titleLabel;

@property (nonatomic , strong) UILabel *tipLabel;

@property (nonatomic , strong) UIView *line;

@property (nonatomic , strong) UITableView *tableView;

@property (nonatomic , strong) UIButton *addCityBtn;

@property (nonatomic , strong) UIButton *confirmBtn;

@property (nonatomic , strong) NSMutableArray *constantCityArr;

@property (nonatomic , assign) SELECTVIEW_TYPE selectView_type;
@end


@implementation TPDAddConstantCityView

- (instancetype)initWithSelectViewType:(SELECTVIEW_TYPE)selectView_type {
    
    self = [super init];
    if (self) {
        _constantCityArr = [NSMutableArray array];
        self.selectView_type = selectView_type;
        [self location];
        [self addSubviews];
        [self setFrame];
    }
    return self;
}

#pragma mark - Custom Delegate
- (void)layoutSubviews{
    
    [super layoutSubviews];
    [_confirmBtn addGradientWithStartColor:UIColorHex(646FFF) endColor:UIColorHex(729DFF)];
    
}
- (void)addSubviews {
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.whiteBg];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.tipLabel];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.addCityBtn];
    [self.contentView addSubview:self.confirmBtn];
}
- (void)setFrame {

    self.frame = [UIScreen mainScreen].bounds;
    self.contentView.frame = CGRectMake(TPAdaptedWidth(24), TPAdaptedHeight(109),TPScreenWidth - TPAdaptedWidth(48) ,TPAdaptedHeight(450));
   
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(TPAdaptedHeight(16));
        make.centerX.equalTo(self.contentView);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(TPAdaptedHeight(12));
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(23.5));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-22.5));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_tipLabel.mas_bottom).offset(TPAdaptedHeight(12));
        make.height.mas_equalTo(0.5);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
    }];

    [_whiteBg  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(_line.mas_bottom);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        
    }];
    
    [_addCityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView.frame.size.width/2);
        make.height.mas_equalTo(TPAdaptedHeight(45));
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(_addCityBtn);
        make.width.equalTo(_addCityBtn);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(_addCityBtn);
    }];
    
      [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(_line.mas_bottom);
          make.left.equalTo(self.contentView.mas_left);
          make.right.equalTo(self.contentView.mas_right);
          make.height.mas_equalTo(TPAdaptedHeight(48*6));
    }];
    
}
#pragma mark - Private Methods
- (void)location {
    
    TPShowLoading;
    [[TPLocationServices locationService]requestSingleLocationWithReGeocode:YES completionHandler:^(TPAddressModel *addressModel, NSError *error) {
        TPHiddenLoading;
        if (error == nil && ![addressModel isKindOfClass:[NSNull class]]) {
            
            [TPCityAdressService getCityIdWithProvinceName:addressModel.province cityName:addressModel.city distName:nil completeBlock:^(BOOL success, TPAddressModel *currentCityModel) {
               
                if (success) {
                   [_constantCityArr insertObject:currentCityModel atIndex:0];
                }else{
                    //手动添加
                    TPAddressModel *model = [self creatCityModel];
                    [_constantCityArr insertObject:model atIndex:0];
                }
                 [_tableView reloadData];
            }];
            
        }else{
            
            
            [TPCityAdressService getCityNameWithCityId:@"020000" completeBlock:^(BOOL success, TPAddressModel *currentCityModel) {
                if (success) {
                   [_constantCityArr insertObject:currentCityModel atIndex:0];
                }
                else{
                  //手动添加
                    TPAddressModel *model = [self creatCityModel];
                    [_constantCityArr insertObject:model atIndex:0];
                   
                }

                 [_tableView reloadData];
            }];
        }
    }];
    
    
}

- (TPAddressModel *)creatCityModel{
    
    TPAddressModel *model =[[TPAddressModel alloc]init];
    model.adcode = @"020000";
    model.formatted_area = @"上海";
    return model;
}

#pragma mark - Public Methods
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = UIColorHex(0000004c);
        self.contentView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dismiss {
    if (self.dismissBlock) {
        self.dismissBlock();
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
//隐藏
- (void)hide:(BOOL)hide {
    
    self.contentView.hidden = hide;
    self.hidden = hide;
}
//确定
- (void)addConstantCityConfirm {
    
    if (_constantCityArr.count == 0) {
        TPShowToast(@"常跑城市不能为空");
        return;
    }
    //上传接口 更新
    [TPDConstantCityDataManager requestUpdateConstantCityWithConstantCityArr:_constantCityArr completeBlock:^(BOOL succeed) {
       
        if (succeed) {
            TPShowToast(@"上传成功");
            [self dismiss];
        }else{
            TPShowToast(@"上传失败");
        }
        
    }];
    
}
//添加的
- (void)addConstantCityAdd {
    
    if (_constantCityArr.count > 8) {
        TPShowToast(@"最多允许添加八个城市");
        return;
    }
    //弹出城市选择器
    [self hide:YES];
    [TPCitySelectView citySelectViewWithType:_selectView_type block:^(TPAddressModel *selectCityModel) {
        [_constantCityArr addObject:selectCityModel];
        [self hide:NO];
        [_tableView reloadData];
        
    }dismissBlock:^{
        [self hide:NO];
    }];
    
}
//更改的
- (void)addConstantCityUpdate {
    
    //只有第一个才能更改
    //弹出城市选择器
    [self hide:YES];
    [TPCitySelectView citySelectViewWithType:_selectView_type block:^(TPAddressModel *selectCityModel) {
        [_constantCityArr removeObjectAtIndex:0];
        [_constantCityArr insertObject:selectCityModel atIndex:0];
        [self hide:NO];
        [_tableView reloadData];
        
    }dismissBlock:^{
       [self hide:NO];
    }];
    
}
//删除的
- (void)addConstantCityDeleteWithIndex:(NSInteger)index {
    
    [_constantCityArr removeObjectAtIndex:index];
    [_tableView reloadData];
}

#pragma mark - event 
- (void)tapAddCityBtn:(UIButton *)tapAddCityBtn {
    
    [self addConstantCityAdd];
    
}
- (void)tapConfirmBtn:(UIButton *)confirmBtn {
    
  
    [self addConstantCityConfirm];
}

#pragma mark - System Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TPDAddConstantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addConstanCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (cell) {
    
        if (indexPath.row == 0) {
            cell.right_btn_type = RIGHT_BTN_ARROWS;
        }else{
            cell.right_btn_type = RIGHT_BTN_DELETE;
        }
        cell.model = _constantCityArr[indexPath.row];
       
    }
    return cell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _constantCityArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return TPAdaptedHeight(48);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
       
        [self addConstantCityUpdate];
    }else{
      
        [self addConstantCityDeleteWithIndex:indexPath.row];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.anyObject.view == self) {
        [self dismiss];
    }
}
#pragma mark - Getters and Setters
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = TPBackgroundColor;
    }
    return _contentView;
}
- (UIView *)whiteBg {
    
    if (!_whiteBg) {
        _whiteBg  = [[UIView alloc]init];
        _whiteBg.backgroundColor = TPWhiteColor;
    }
    return _whiteBg;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"添加常跑城市";
        _titleLabel.font = TPSystemFontSize(17);
        _titleLabel.textColor =TPTitleTextColor;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.text = @"根据您的常跑城市，我们将为您自动推送您附近相关路线的货源。";
     
        _tipLabel.font = TPSystemFontSize(12);
        _tipLabel.textColor = TPMinorTextColor;
        _tipLabel.numberOfLines = 0;
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}
- (UIView *)line {
    
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _line;

}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TPAdaptedHeight(91), self.contentView.size.width, TPAdaptedHeight(48*6)) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = YES;
        [_tableView registerClass:[TPDAddConstantCell class] forCellReuseIdentifier:@"addConstanCell"];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc]init];
        
    }
    return _tableView;
 
}

- (UIButton *)addCityBtn {
    
    if (!_addCityBtn) {
        _addCityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addCityBtn setTitle:@"添加城市" forState:0];
        _addCityBtn.titleLabel.font = TPSystemFontSize(17);
        _addCityBtn.backgroundColor = TPWhiteColor;
        [_addCityBtn setTitleColor:TPGradientStartColor forState:0];
         [_addCityBtn addTarget:self action:@selector(tapAddCityBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addCityBtn;
}

- (UIButton *)confirmBtn {
    
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确定" forState:0];
        _confirmBtn.titleLabel.font = TPSystemFontSize(17);
        [_confirmBtn setTitleColor:[UIColor whiteColor] forState:0];
        _confirmBtn.backgroundColor = TPGradientStartColor;
        [_confirmBtn addTarget:self action:@selector(tapConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _confirmBtn;
}
@end
