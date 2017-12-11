//
//  TPDListenOrderSetUpView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/31.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//听单点击设置view

#import "TPDListenOrderSetView.h"
#import "TPBaseTableView.h"
#import "TPDListenOrderSetTableViewHeader.h"
#import "TPDListenOrderSetViewModel.h"
#import "UIImage+Gradient.h"
#import "UIButton+ResetContent.h"
#import "TPDListenOrderSetViewModel.h"
@interface TPDListenOrderSetView()<TPBaseTableViewDelegate>

@property (nonatomic , strong) UIView *contentView;

@property (nonatomic , strong) TPBaseTableView *tableView;

@property (nonatomic , strong) TPDListenOrderSetTableViewHeader *firstSectionHeaderView;

@property (nonatomic , strong) TPDListenOrderSetTableViewHeader *secondSectionHeaderView;

@property (nonatomic , strong) UIButton *confirmBtn;

@property (nonatomic , strong) id dataSource;

@end

@implementation TPDListenOrderSetView
- (instancetype)initWithDataSource:(id)dataSource {
    
    self = [super init];
    if (self) {
        self.dataSource = dataSource;
    }
    return self;
    
}
- (void)addSubviews {
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    [self.contentView addSubview:self.confirmBtn];
    
}

- (void)setFrame {
 
    
    
    [_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(TPAdaptedHeight(276+128));
    }];
    
    
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(TPAdaptedHeight(327));
    }];
    
    [_confirmBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(TPAdaptedHeight(-16));
        make.left.equalTo(self.contentView.mas_left).offset(TPAdaptedWidth(12));
        make.right.equalTo(self.contentView.mas_right).offset(TPAdaptedWidth(-12));
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if (touches.anyObject.view == self) {
        [self disappearView];
    }
    
}
- (void)tableViewReload {
    [self.tableView reloadDataSource];
}
- (void)showInView:(UIView *)contentView {
    
    
    if (![contentView.subviews containsObject:self]) {
       [contentView addSubview:self];
        [self addSubviews];
        [self setFrame];
    }
    
    self.hidden = NO;
    self.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
  
    self.frame = CGRectMake(0, 64, TPScreenWidth, TPScreenHeight-64);
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(-TPAdaptedHeight(276+128));
    }];
    
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
       
         self.backgroundColor = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0.4];
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top);
        }];
        [self layoutIfNeeded];
    }];
  
}

- (void)disappearView {
    
    [UIView animateWithDuration:0.3 animations:^{
      self.backgroundColor  = [UIColor colorWithRed:0/255 green:0/255 blue:0/255 alpha:0];
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self).offset(-TPAdaptedHeight(276+128));
        }];
        
    } completion:^(BOOL finished) {
       
        self.hidden=  YES;
        
    }];
    
}

- (void)tapConfirmBtn:(UIButton *)tapConfirmBtn {
    
    if (self.tapConfirmBtn) {
        self.tapConfirmBtn();
    }
    [self disappearView];
    
}
#pragma mark - System Delegate
- (UIView *)headerViewForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
    
    if (section == 0) {
        return self.firstSectionHeaderView;
    }else if (section == 1) {
        return self.secondSectionHeaderView;
    }
    else{
        return nil;
    }
}

- (CGFloat)headerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
    
    if (section == 2) {
        return CGFLOAT_MIN;
    }
    else{
       return TPAdaptedHeight(40);
    }
}

- (CGFloat)footerHeightForSectionObject:(TPBaseTableViewSectionObject *)sectionObject atSection:(NSInteger)section {
    
    return CGFLOAT_MIN;
}
- (void)didSelectObject:(TPDListenOrderSetDestinationViewModel *)object atIndexPath:(NSIndexPath *)indexPath {
    
    if ([object isKindOfClass:[TPDListenOrderSetDestinationViewModel class]] && [object.model.type isEqualToString:@"3"]) {
        //选择城市
        if ([self.delegate respondsToSelector:@selector(didSelectOptionalCityWithObject:)]) {
            [self.delegate didSelectOptionalCityWithObject:object];
        }
        
    }
}

#pragma mark - Getters and Setters
- (TPBaseTableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[TPBaseTableView alloc]init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = TPWhiteColor;
        _tableView.tpDelegate = self;
        _tableView.tpDataSource = self.dataSource;
        _tableView.bounces = NO;
    }
    return _tableView;
}

- (UIView *)contentView {
    
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = TPWhiteColor;
    }
    return _contentView;
}
- (UIButton *)confirmBtn {
    
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"确认" forState:0];
        _confirmBtn.titleLabel.font = TPSystemFontSize(17);
        [_confirmBtn setTitleColor:TPWhiteColor forState:0];
        [_confirmBtn setBackgroundImage:[UIImage createGradientImageWithSize:CGSizeMake(TPAdaptedWidth(351), TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor] forState:0];
        _confirmBtn.layer.cornerRadius = TPAdaptedHeight(22);
        _confirmBtn.layer.masksToBounds = YES;
        [_confirmBtn addTarget:self action:@selector(tapConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _confirmBtn;
}


- (TPDListenOrderSetTableViewHeader *)firstSectionHeaderView {
    if (!_firstSectionHeaderView) {
        _firstSectionHeaderView = [[TPDListenOrderSetTableViewHeader alloc]initWithTitle:@"出发地" icon:@"listen_order_ depart_icon"];
        
    }
    return _firstSectionHeaderView;
}
- (TPDListenOrderSetTableViewHeader *)secondSectionHeaderView {
    if (!_secondSectionHeaderView) {
        _secondSectionHeaderView = [[TPDListenOrderSetTableViewHeader alloc]initWithTitle:@"目的地" icon:@"listen_order_ destination_icon"];
    }
    return _secondSectionHeaderView;
}

@end
