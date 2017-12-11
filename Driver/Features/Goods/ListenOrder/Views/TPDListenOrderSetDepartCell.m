//
//  TPDListenOrderSetDepartCell.m
//  TopjetPicking
//
//  Created by lish on 2017/9/1.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDListenOrderSetDepartCell.h"
#import "UIButton+ResetContent.h"
#import "TPDArrowsButton.h"
@interface TPDListenOrderSetDepartCell()

@property (nonatomic , strong) TPDArrowsButton *arrowBtn;
@property (nonatomic , strong) UIButton *locationBtn;


@end

@implementation TPDListenOrderSetDepartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSuviews];
      
    }
    return self;
}
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(TPBaseTableViewItem *)object {
    
    return TPAdaptedHeight(48);
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    [_arrowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(TPAdaptedWidth(46));
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.width.mas_equalTo([_arrowBtn.titleLabel.text widthForFont:TPAdaptedFontSize(14)]+TPAdaptedWidth(20));
    }];
    
    [_locationBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self).offset(TPAdaptedWidth(-12));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(TPAdaptedWidth(48));
        make.height.mas_equalTo(TPAdaptedHeight(24));
    }];
   
    [self updateArrowBtn];
}

- (void)addSuviews {
    
    [self addSubview:self.arrowBtn];
    [self addSubview:self.locationBtn];
    
}
- (void)updateArrowBtn {
    
    [_arrowBtn horizontalCenterTitleAndImage];
    if ([_arrowBtn.titleLabel.text isEqualToString:@"无法获取"]) {
        [_arrowBtn setTitleColor:TPMainTextColor forState:0];
    }else{
        [_arrowBtn setTitleColor:TPTitleTextColor forState:0];
    }
 
}

- (void)tapLocation {
    
    if ([self.delegate respondsToSelector:@selector(listenOrderSetPopLocationCellDidSelectBtn:cellViewModel:)]) {
        [self.delegate listenOrderSetPopLocationCellDidSelectBtn:ListenOrderSetPopLocationCell_LocationBtn cellViewModel:self.object];
    }
    
}
- (UIButton *)locationBtn {
    
    if (!_locationBtn) {
        _locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_locationBtn setTitle:@"定位" forState:0];
        [_locationBtn setTitleColor:TPMainColor forState:0];
        _locationBtn.titleLabel.font = TPAdaptedFontSize(14);
        _locationBtn.layer.cornerRadius = 5;
        _locationBtn.layer.masksToBounds = YES;
        _locationBtn.layer.borderColor = TPMainColor.CGColor;
        _locationBtn.layer.borderWidth = 1;
        [_locationBtn addTarget:self action:@selector(tapLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationBtn;
    
}

- (TPDArrowsButton *)arrowBtn {
    
    if (!_arrowBtn) {
        _arrowBtn = [[TPDArrowsButton alloc]init];
        [_arrowBtn setTitle:@"无法获取" forState:0];
        @weakify(self);
        _arrowBtn.tapBlock = ^(UIButton *btn) {
         @strongify(self);
            
            if ([self.delegate respondsToSelector:@selector(listenOrderSetPopLocationCellDidSelectBtn:cellViewModel:)]) {
                [self.delegate listenOrderSetPopLocationCellDidSelectBtn:ListenOrderSetPopLocationCell_DepartCityBtn cellViewModel:self.object];
            }
            btn.selected = NO;
        };
        
    }
    return _arrowBtn;
}

- (void)setObject:(TPDListenOrderSetDepartViewModel *)object {
    
    [super setObject:object];
    
    if ([object.cityName isNotBlank]) {
          [self.arrowBtn setTitle:object.cityName forState:0];
    }else {
        [self.arrowBtn setTitle:@"无法获取" forState:0];
    }
  
     self.delegate = object.target;
    
}



@end
