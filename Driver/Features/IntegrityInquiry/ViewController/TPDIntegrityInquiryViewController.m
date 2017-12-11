//
//  TPDIntegrityInquiryViewController.m
//  TopjetPicking
//
//  Created by Mr.mao on 2017/11/13.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDIntegrityInquiryViewController.h"
#import "TPDIntegrityInquiryEntry.h"
#import "TXLimitedTextField.h"
#import "UIImage+Gradient.h"
#import "UIButton+ResetContent.h"
#import "LJContactManager.h"
#import "NSFileManager+Category.h"
#import "LTPContactModel.h"
#import "IQKeyboardManager.h"
#import "NSString+Regular.h"
#import "TPDIntegrityInquiryDataManager.h"
#import "LJContactManager.h"
#import "TPAlertView.h"

@interface TPDIntegrityInquiryViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong) TXLimitedTextField * textField;
@property (nonatomic,strong) UIView * lineView;
@property (nonatomic,strong) UIButton * openContactButton;
@property (nonatomic,strong) UIButton * inquiryButton;
@property (nonatomic,strong) NSArray * selectedContracts;
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) TPDIntegrityInquiryDataManager * dataManager;

@end

@implementation TPDIntegrityInquiryViewController

+ (void)load {
    [TPDIntegrityInquiryEntry registerIntegrityInquiry];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"诚信查询";
    self.view.backgroundColor = TPBackgroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self ii_addSubviews];
    [self ii_getContracts];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selectedContracts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const identifier = @"TPIntegrityInquiryTableViewCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView * line = [[UIView alloc] initWithFrame:CGRectMake(TPAdaptedWidth(12), TPAdaptedHeight(52) - 0.5, kScreenWidth - TPAdaptedWidth(12), 0.5)];
        line.backgroundColor = TPUNEnbleColor_LineColor;
        [cell addSubview:line];
    }
    cell.imageView.image = [UIImage imageNamed:@"nav_icon_search24"];
    LTPContactModel * model = self.selectedContracts[indexPath.row];
    cell.textLabel.text = model.contactMobile;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LTPContactModel * model = self.selectedContracts[indexPath.row];
    self.textField.text = model.contactMobile;
    [self.textField endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.tableView.hidden = YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.tableView.hidden = NO;
    [self ii_getContracts];
}

#pragma mark - Events
- (void)ii_textFieldValueChanged:(TXLimitedTextField *)textField {
    [self.dataManager matchContactsWithMobile:textField.text complection:^(NSArray<LTPContactModel *> *contacts) {
        self.selectedContracts = contacts;
        [self.tableView reloadData];
    }];
}

- (void)ii_openContactEvent {
    @weakify(self);
    [[LJContactManager sharedInstance] selectContactAtController:self complection:^(NSString *name, NSString *phone) {
        @strongify(self);
        self.textField.text = phone;
    }];
}

- (void)ii_inquiryButtonEvent {
    if (!self.textField.text.length) {
        TPShowToast(@"请输入手机号");
        return;
    }
    if (![self.textField.text checkPhoneNumber]) {
        TPShowToast(@"请输入有效手机号");
        return;
    }
    
    [self ii_saveContactHistory];

    //如果是自己弹提示去个人中心查看到自己的资料
    if ([TPCurrentUser.mobile isEqualToString:self.textField.text]) {
        [self ii_showAlert];
        return;
    }
    
    [self ii_inquireIntegrityRequest];
}

#pragma mark - Privates
//保存联系人数据
- (void)ii_saveContactHistory {
    [self.dataManager saveContactWithMobile:self.textField.text];
}

//获取联系人列表
- (void)ii_getContracts {
    TPShowLoading;
    @weakify(self);
    [self.dataManager contactsWithComplection:^(NSArray<LTPContactModel *> *contacts) {
        TPHiddenLoading;
        @strongify(self);
        self.selectedContracts = contacts;
        [self.tableView reloadData];
    }];
}

//诚信查询请求
- (void)ii_inquireIntegrityRequest {
    @weakify(self);
    [self.dataManager inquireIntegrityWithMobile:self.textField.text complection:^(BOOL success, TPBusinessError *error, NSDictionary *queryIntegrityInfo) {
        @strongify(self);
        if (success) {
            //去诚信查询结果页面
            [TPRouterAnalytic openInteriorURL:TPRouter_IntegrityInquiryResult_Conteroller parameter:@{@"queryIntegrityInfo":queryIntegrityInfo} type:PUSHCONTROLLERTYPE_PUSH];
        } else {
            //当输入的手机号为当前用户的手机号时，点击按钮弹出弹框
            if ([error.business_code isEqualToString:@"E_USER_27"]) {
                [self ii_showAlert];
            } else {
                TPShowToast(error.business_msg);
            }
        }
    }];
}

//给出提示
- (void)ii_showAlert {
    TPAlertView * alertView = [[TPAlertView alloc] initWithTitle:nil message:@"您可以在个人中心查看到自己的资料" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:@"去看看"];
    @weakify(self);
    alertView.otherButtonAction = ^{
        @strongify(self);
        [self cyl_popSelectTabBarChildViewControllerAtIndex:4 completion:nil];
    };
    [alertView show];
}

- (void)ii_addSubviews {
    [self.view addSubview:self.textField];
    [self.textField addSubview:self.lineView];
    [self.view addSubview:self.openContactButton];
    [self.view addSubview:self.inquiryButton];
    [self.view addSubview:self.tableView];

    [self ii_makeConstraints];
}

- (void)ii_makeConstraints {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuideBottom).offset(TPAdaptedHeight(12));
        make.height.mas_equalTo(TPAdaptedHeight(48));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(self.textField);
        make.left.equalTo(self.textField.mas_left).offset(TPAdaptedWidth(12));
        make.height.mas_equalTo(0.5);
    }];
    
    [self.openContactButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.textField.mas_bottom);
        make.height.mas_equalTo(TPAdaptedHeight(48));
    }];
    
    [self.inquiryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(TPAdaptedWidth(12));
        make.right.equalTo(self.view.mas_right).offset(TPAdaptedWidth(-12));
        make.top.equalTo(self.openContactButton.mas_bottom).offset(TPAdaptedHeight(20));
        make.height.mas_equalTo(TPAdaptedHeight(44));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.textField.mas_bottom);
    }];
}

#pragma mark - Setters and Getters
- (TXLimitedTextField *)textField {
    if (!_textField) {
        _textField = [[TXLimitedTextField alloc] init];
        _textField.limitedNumber = 11;
        _textField.delegate = self;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.placeholder = @"请输入被查询者的联系号码";
        _textField.textColor = TPTitleTextColor;
        [_textField addTarget:self action:@selector(ii_textFieldValueChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.font = TPAdaptedFontSize(15);
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.leftView = [self textFieldLeftView];
        _textField.backgroundColor = TPWhiteColor;
        _textField.borderStyle = UITextBorderStyleNone;
    }
    return _textField;
}

- (UILabel *)textFieldLeftView {
    UILabel * label = [[UILabel alloc] init];
    label.textColor = TPTitleTextColor;
    label.font = TPAdaptedFontSize(15);
    label.frame = CGRectMake(0, 0, TPAdaptedWidth(94), TPAdaptedHeight(48));
    label.text = @"   联系号码";
    return label;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = TPUNEnbleColor_LineColor;
    }
    return _lineView;
}

- (UIButton *)openContactButton {
    if (!_openContactButton) {
        _openContactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _openContactButton.frame = CGRectMake(0, TPAdaptedHeight(60), kScreenWidth, TPAdaptedHeight(48));
        _openContactButton.backgroundColor = TPWhiteColor;
        [_openContactButton setImage:[UIImage imageNamed:@"common_cell_arrow"] forState:UIControlStateNormal];
        [_openContactButton setTitle:@"打开通讯录" forState:UIControlStateNormal];
        [_openContactButton setTitleColor:TPTitleTextColor forState:UIControlStateNormal];
        _openContactButton.titleLabel.font = TPAdaptedFontSize(15);
        [_openContactButton horizontalCenterTitleAndImageWithEdge:TPAdaptedWidth(12)];
        _openContactButton.adjustsImageWhenHighlighted = NO;
        [_openContactButton addTarget:self action:@selector(ii_openContactEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openContactButton;
}

- (UIButton *)inquiryButton {
    if (!_inquiryButton) {
        _inquiryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _inquiryButton.titleLabel.font = TPAdaptedFontSize(17);
        [_inquiryButton setTitle:@"立即查询" forState:UIControlStateNormal];
        _inquiryButton.backgroundColor = TPUNEnbleColor_LineColor;
        _inquiryButton.clipsToBounds = YES;
        _inquiryButton.layer.cornerRadius = TPAdaptedWidth(20);
        [_inquiryButton addTarget:self action:@selector(ii_inquiryButtonEvent) forControlEvents:UIControlEventTouchUpInside];
        UIImage * selectedBackgroundImage = [UIImage createGradientImageWithSize:CGSizeMake(kScreenWidth - TPAdaptedHeight(24), TPAdaptedHeight(44)) startColor:TPGradientStartColor endColor:TPGradientEndColor];
        [_inquiryButton setBackgroundImage:selectedBackgroundImage forState:UIControlStateNormal];
    }
    return _inquiryButton;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.hidden = YES;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = TPAdaptedHeight(52);
    }
    return _tableView;
}

- (TPDIntegrityInquiryDataManager *)dataManager {
    if (!_dataManager) {
        _dataManager = [[TPDIntegrityInquiryDataManager alloc] init];
    }
    return _dataManager;
}

@end
