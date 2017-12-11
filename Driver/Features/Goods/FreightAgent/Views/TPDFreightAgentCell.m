//
//  TPDFreightAgentCell.m
//  TopjetPicking
//
//  Created by lish on 2017/8/30.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDFreightAgentCell.h"
#import "TPDFreightAgrentViewModel.h"
@interface TPDFreightAgentCell()

@property (nonatomic , strong) UIImageView *userIcon;
@property (nonatomic , strong) UILabel *userName;
@property (nonatomic , strong) UILabel *titleLabel;
@property (nonatomic , strong) UIImageView *agreeIcon;
@property (nonatomic , strong) UIButton *chatBtn;
@property (nonatomic , strong) UIButton *callBtn;
@property (nonatomic , strong) UILabel *line1;
@property (nonatomic , strong) UILabel *line2;
@property (nonatomic , strong) UILabel *line3;

@end

@implementation TPDFreightAgentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
   self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubviews];
        [self setFrame];
        
    }
    return self;
}
- (void)addSubviews {
    
    [self addSubview:self.userIcon];
    [self addSubview:self.userName];
    [self addSubview:self.titleLabel];
    [self addSubview:self.agreeIcon];
    [self addSubview:self.chatBtn];
    [self addSubview:self.callBtn];
    [self addSubview:self.line1];
    [self addSubview:self.line2];
    [self addSubview:self.line3];
}

- (void)setFrame {
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.top.equalTo(self).offset(TPAdaptedHeight(15));
        make.width.mas_equalTo(TPAdaptedWidth(35));
        make.height.mas_equalTo(TPAdaptedWidth(35));
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.top.equalTo(self.userIcon.mas_bottom).offset(TPAdaptedHeight(8));
    }];
    [_agreeIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(TPAdaptedWidth(12));
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-12));
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userIcon.mas_right).offset(TPAdaptedWidth(12));
        make.top.equalTo(self).offset(TPAdaptedHeight(13));
    }];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(TPAdaptedHeight(4));
        make.height.mas_equalTo(TPAdaptedHeight(16));
        make.width.mas_equalTo(TPAdaptedWidth(188));
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line1.mas_bottom);
        make.left.height.width.equalTo(_line1);
    }];
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_line2.mas_bottom);
        make.left.height.width.equalTo(_line1);
    }];
    
    [_callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
        
    }];
    
    [_chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(TPAdaptedWidth(-64));
        make.centerY.equalTo(self);
        
    }];
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    return TPAdaptedHeight(100);
}
 #pragma mark - Event Response
- (void)tapChatBtn {
    
    if ([self.delagete respondsToSelector:@selector(didClickFreightAgentCellButton:object:)]) {
        [self.delagete didClickFreightAgentCellButton:FreightAgentCellButtonType_Message object:(TPDFreightAgrentItemViewModel *)self.object];
    }
}

- (void)tapCallBtn {
    if ([self.delagete respondsToSelector:@selector(didClickFreightAgentCellButton:object:)]) {
        [self.delagete didClickFreightAgentCellButton:FreightAgentCellButtonType_Call object:(TPDFreightAgrentItemViewModel *)self.object];
    }
}
#pragma mark - Getters and Setters
- (UILabel *)userName {
    
    if (!_userName) {
        _userName = [[UILabel alloc]init];
        _userName.textColor = TPTitleTextColor;
        _userName.font = TPSystemFontSize(12);
        _userName.text = @"王梦飞";
    }
    
    return _userName;
}
- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = TPMainTextColor;
        _titleLabel.font = TPAdaptedFontSize(13);
        _titleLabel.text = @"经营路线";
    }
    return _titleLabel;
}
- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc]init];
        _userIcon.image = [UIImage imageNamed:@"smart_find_goods_user_image"];
    }
    return _userIcon;
}
- (UIImageView *)agreeIcon {
    if (!_agreeIcon) {
        _agreeIcon = [[UIImageView alloc]init];
        _agreeIcon.image = [UIImage imageNamed:@"smart_find_goods_offline_approve_blue"];
    }
    return _agreeIcon;
}

- (UILabel *)line1 {
    
    if (!_line1) {
        _line1 = [[UILabel alloc]init];
        _line1.textColor = TPTitleTextColor;
        _line1.font = TPAdaptedFontSize(13);
        
    }
    
    return _line1;
}

- (UILabel *)line2 {
    
    if (!_line2) {
        _line2 = [[UILabel alloc]init];
        _line2.textColor = TPTitleTextColor;
        _line2.font = TPAdaptedFontSize(13);
        
    }
    
    return _line2;
}

- (UILabel *)line3 {
    
    if (!_line3) {
        _line3 = [[UILabel alloc]init];
        _line3.textColor = TPTitleTextColor;
        _line3.font = TPAdaptedFontSize(13);
        
    }
    
    return _line3;
}
- (UIButton *)chatBtn {
    
    if (!_chatBtn) {
        _chatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatBtn setImage:[UIImage imageNamed:@"smart_find_goods_message_blue"] forState:0];
        [_chatBtn addTarget:self action:@selector(tapChatBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatBtn;
}

- (UIButton *)callBtn {
    
    if (!_callBtn) {
        _callBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_callBtn setImage:[UIImage imageNamed:@"smart_find_goods_call_nor"] forState:0];
        [_callBtn addTarget:self action:@selector(tapCallBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _callBtn;
}

- (void)setObject:(TPDFreightAgrentItemViewModel *)object {
    
    [super setObject:object];
    self.delagete = object.target;
    _userIcon.image = object.avatarImage;
    _userName.text = object.name;
    _agreeIcon.image = object.authenticationIcon;
    _titleLabel.text = object.title;
    _line1.text = object.firstBrokerRoute;
    _line2.text = object.secondBrokerRoute;
    _line3.text = object.thirdBrokerRoute;
    [_callBtn setImage:object.callIcon forState:0];
    [_chatBtn setImage:object.messageIcon forState:0];

}
@end
