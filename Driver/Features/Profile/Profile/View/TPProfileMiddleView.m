//
//  TPPersonalCenterMiddleCell.m
//  TopjetPicking
//
//  Created by lish on 2017/10/19.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDProfileMiddleView.h"

@interface TPDProfileMiddleItem()

@property (nonatomic , strong) UILabel *title;


@property (nonatomic , strong) UIButton *stateBtn;


@property (nonatomic , strong) UIImageView *icon;

@property (nonatomic , copy) NSString *titleStr;

@property (nonatomic , copy) NSString *iconStr;

@end
@implementation TPDProfileMiddleItem
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubviews];
        [self setFrame];
        
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon gestureRecognizer:(void(^)(void))gestureRecognizer {
    
    self = [super init];
    if(self){
        self.iconStr = icon;
        self.titleStr = title;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
            
            if (gestureRecognizer) {
                gestureRecognizer();
            }
            
        }];
        [self addGestureRecognizer:tap];
    }
    return self;
    
}

- (void)setFrame {
   
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(TPAdaptedHeight(32));
        make.centerX.equalTo(self);
        
        
    }];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.icon.mas_bottom).offset(TPAdaptedHeight(13));
        make.centerX.equalTo(self);
    }];
    
    [_stateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self).offset(TPAdaptedHeight(10));
        make.right.equalTo(self).offset(TPAdaptedHeight(-8));;
        make.height.mas_equalTo(TPAdaptedHeight(14));
        make.width.mas_equalTo(TPAdaptedWidth(39));
    }];
    
}

- (void)addSubviews {
    [self addSubview:self.title];
     [self addSubview:self.stateBtn];
     [self addSubview:self.icon];
}
- (UILabel *)title {
    
    if (!_title) {
        _title = [[UILabel alloc]init];
       // _title.text = @"刘诗诗";
        _title.font = TPAdaptedFontSize(12);
        _title.textColor = TPTitleTextColor;
    }
    return _title;
    
}
- (UIButton *)stateBtn {
    
    if (!_stateBtn) {
        _stateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_stateBtn setBackgroundImage:[UIImage imageNamed:@"personal_center_hint_bg"] forState:0];
       // [_stateBtn setTitle:@"签到" forState:0];
        [_stateBtn setTitleColor:TPWhiteColor forState:0];
        _stateBtn.titleLabel.font = TPAdaptedFontSize(8);
        _stateBtn.hidden = YES;
    }
    return _stateBtn;
    
    
}
- (UIImageView *)icon {
    
    
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
       // _icon.image = [UIImage imageNamed:@"personal_center_authentication_icon"];
        
    }
    return _icon;
    
}

-(void)setTitleStr:(NSString *)titleStr {
    
    _titleStr = titleStr;
    _title.text = _titleStr;
}

- (void)setIconStr:(NSString *)iconStr {
    
    _iconStr = iconStr;
    _icon.image = [UIImage imageNamed:_iconStr];
    
}

- (void)setStatusStr:(NSString *)statusStr {
    
    if ([statusStr isNotBlank]) {
        _statusStr = statusStr;
        [_stateBtn setTitle:_statusStr forState:0];
        _stateBtn.hidden = NO;
    }
    
}

@end


@interface TPDProfileMiddleView()

@property (nonatomic , strong) NSArray *icons;

@property (nonatomic , strong) NSArray *titles;

@property (nonatomic , copy) TPDProfileMiddleItemHandler handler;

@property (nonatomic , strong) NSMutableArray <TPDProfileMiddleItem *>*middlerItemViews;
@end


@implementation TPDProfileMiddleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = TPWhiteColor;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
    }
    return self;
}
- (instancetype)initWithIcons:(NSArray *)icons titles:(NSArray *)titles handler:(TPDProfileMiddleItemHandler)handelr{
    
    self = [super init];
    if (self) {
        
        _icons = [NSArray arrayWithArray:icons];
        _titles = [NSArray arrayWithArray:titles];
        _middlerItemViews = [NSMutableArray array];
        _handler = handelr;
        [self addSubviews];
    }
    return self;
    
}
- (void)blindViewModel:(TPDProfileViewModel *)viewModel {
    

    [_middlerItemViews enumerateObjectsUsingBlock:^(TPDProfileMiddleItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        switch (idx) {
            case 0:
                obj.statusStr = viewModel.userStatus;
                break;
                
            case 1:
                obj.statusStr = viewModel.userAuthStatus;
                break;
                
            case 2:
                obj.statusStr = viewModel.vehicleStatus;
                break;
        }
        
    }];
  
}

- (void)addSubviews {
   
    NSInteger count = _titles.count;
    NSInteger row = 4;
    NSInteger remainder = count % row;
    NSInteger line = remainder ? count / row + 1:remainder;
    CGFloat cellHeight = TPAdaptedHeight(106);
    CGFloat cellWidth = TPAdaptedWidth(88);
    int index = 0;
    for(int i = 0; i < line; i++) {
        for(int j = 0; j < row; j++) {
            if (index >= count) {
                break;
            }
            @weakify(self);
            TPDProfileMiddleItem *item = [[TPDProfileMiddleItem alloc]initWithTitle:_titles[index] icon:_icons[index] gestureRecognizer :^{
                @strongify(self);
                if (self.handler) {
                    self.handler(index);
                }
            }];
            [self addSubview:item];
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self).offset(cellWidth*j);
                make.top.mas_equalTo(self).offset(cellHeight*i);
                make.width.mas_equalTo(cellWidth);
                make.height.mas_equalTo(cellHeight);
            }];
            [_middlerItemViews addObject:item];
            index++;
        }
    }
   
}

@end
