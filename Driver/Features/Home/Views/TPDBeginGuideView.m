//
//  BeginGuideView.m
//  TopjetPicking
//
//  Created by lish on 2017/8/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDBeginGuideView.h"
#import "TPAppVersionHelper.h"
@interface TPDBeginGuideView()

@property (nonatomic , strong) UIView *blackBg;
@property (nonatomic , strong) UIImageView *guideImage;
@property (nonatomic , strong) UIButton *nextBtn;

@property (nonatomic , assign) NSInteger selectIndex;
@property (nonatomic , strong) NSMutableArray *guideImageArr;

@property (nonatomic , copy) void(^completeBlock)(void);

@end
@implementation TPDBeginGuideView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {

            _selectIndex = 0;
            [self addSubview:self.blackBg];
            [self addSubview:self.guideImage];
            [self addSubview:self.nextBtn];
            [self setFrame];
        
    }
    return self;
}

+ (void)startBeginGuideCompleteBlock:(void(^)(BOOL isFirst))completeBlock {
    
    if ([TPAppVersionHelper isFirstInstall]) {
    
        [TPDBeginGuideView beginGuideViewCompleteBlock:^{
            if (completeBlock) {
                completeBlock(YES);
            }
        }];
    }else{
        
        if (completeBlock) {
            completeBlock(NO);
        }
    }
}
+ (instancetype)beginGuideViewCompleteBlock:(void(^)(void))completeBlock {
    
    TPDBeginGuideView *beginGuideView = [[TPDBeginGuideView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [beginGuideView show];
    beginGuideView.completeBlock = completeBlock;
    return beginGuideView;
}
- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)setFrame {
    

    CGFloat btnBottomOffset = 0.0;
    CGFloat guideImageBottomOffeset = 0.0;
    switch (_selectIndex) {
        case 0:
            guideImageBottomOffeset = -2;
            btnBottomOffset = -455/2;
            break;
        case 1:
            
             guideImageBottomOffeset = 0;
             btnBottomOffset = -170/2;

            break;
        case 2:
            guideImageBottomOffeset = -4;
            btnBottomOffset = -573/2;

            
            break;
    }
 
    UIImage *guideImage = [UIImage imageNamed:self.guideImageArr[_selectIndex]];
    [_guideImage mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(guideImageBottomOffeset));
        make.centerX.equalTo(self);
        make.width.mas_equalTo(TPAdaptedWidth(guideImage.size.width));
        make.height.mas_equalTo(TPAdaptedHeight(guideImage.size.height));
        
        
    }];
    [_nextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(TPAdaptedHeight(35));
        make.width.mas_offset(TPAdaptedWidth(85));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(btnBottomOffset));
    }];
    
    if (_selectIndex == 1) {
        
        [_nextBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(TPAdaptedHeight(35));
            make.width.mas_offset(TPAdaptedWidth(85));
            make.left.equalTo(self.mas_left).offset(TPAdaptedWidth(110));
            make.bottom.equalTo(self.mas_bottom).offset(TPAdaptedHeight(btnBottomOffset));
        }];
    }

}

- (void)tapClickBtn:(UIButton *)nextBtn {
    
    
    _selectIndex++;
    if (_selectIndex == _guideImageArr.count) {
        _nextBtn.enabled = NO;
        [self removeFromSuperview];
        if (_completeBlock) {
            [TPAppVersionHelper updateInstallStatus:YES];
            _completeBlock();
        }
        return;
    }
    _guideImage.image = [UIImage imageNamed:self.guideImageArr[_selectIndex]];
    [self setFrame];
    
    
}

- (UIView *)blackBg {
    
    if (!_blackBg) {
        _blackBg = [[UIView alloc]initWithFrame:self.frame];
        _blackBg.backgroundColor = [UIColor blackColor];
        _blackBg.alpha = 0.7;
        
    }
    return _blackBg;
}

- (UIImageView *)guideImage {
    
    if (!_guideImage) {
        _guideImage = [[UIImageView alloc]init];
        _guideImage.image = [UIImage imageNamed:self.guideImageArr[_selectIndex]];
    }
    return _guideImage;
}

- (UIButton *)nextBtn {
    
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn addTarget:self action:@selector(tapClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        _nextBtn.backgroundColor = [UIColor clearColor];
    }
    return _nextBtn;
}
- (NSMutableArray *)guideImageArr {
    
    if (!_guideImageArr ) {
        _guideImageArr = @[@"begin_guide_first",@"begin_guide_second",@"begin_guide_third"].mutableCopy;
        
    }
    return _guideImageArr;
}


@end
