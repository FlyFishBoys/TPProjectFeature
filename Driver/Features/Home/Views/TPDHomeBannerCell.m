//
//  TPHomeBannerCell.m
//  TopjetPicking
//
//  Created by leeshuangai on 2017/9/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeBannerCell.h"
#import "TYCyclePagerView.h"
#import "TPDHomeBannerItemCell.h"
@interface TPDHomeBannerCell ()<TYCyclePagerViewDataSource, TYCyclePagerViewDelegate>

//轮播图

@property (nonatomic , strong) TYCyclePagerView *pagerView;

@end


@implementation TPDHomeBannerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
         self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = TPBackgroundColor;
        TPAdvertModel *model = [[TPAdvertModel alloc]init];
        model.picture_url = @"homepage_banner";
        _bannerImages = @[model];
        [self addSubview:self.pagerView];
        [self.pagerView reloadData];
        [self setFrame];
       
    }
    return self;
}

- (void)setFrame {
    
    [_pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self);
        make.height.equalTo(self);
        make.top.equalTo(self.mas_top);
        
    }];
    
}

#pragma mark - Custom Delegate
#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.bannerImages.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    
    TPDHomeBannerItemCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.model = self.bannerImages[index];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(TPAdaptedWidth(320), TPAdaptedHeight(160));
    layout.itemSpacing = TPAdaptedWidth(10);
    layout.itemHorizontalCenter = YES;
    layout.layoutType = TYCyclePagerTransformLayoutLinear;
    
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:( UICollectionViewCell *)cell atIndex:(NSInteger)index {
    
    DDLog(@"点击了%ld",(long)index);
    if (self.tapBannerHandler) {
        self.tapBannerHandler(index);
    }
}

#pragma mark - Getters and Setters

- (TYCyclePagerView *)pagerView {
    
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]init];
        _pagerView.autoScrollInterval = 3.0;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerClass:[TPDHomeBannerItemCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _pagerView;
}

- (void)setBannerImages:(NSArray *)bannerImages {
    _bannerImages = bannerImages;
    [_pagerView reloadData];
    
}
@end
