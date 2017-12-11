//
//  TPHomeFuctionCell.m
//  TopjetPicking
//
//  Created by leeshuangai on 2017/9/9.
//  Copyright © 2017年 ShangHai Topjet Information & Technology Co. Ltd. All rights reserved.
//

#import "TPDHomeFuctionCell.h"
#import "TPDHomeFuctionCollectionCell.h"
@interface TPDHomeFuctionCell()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) UIPageControl *pageControll;
@property (nonatomic , strong) UICollectionView *collectionView;

@end

@implementation TPDHomeFuctionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
          self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubview:self.pageControll];
        [self addSubview:self.collectionView];
        self.backgroundColor  = TPBackgroundColor;
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self).offset(TPAdaptedHeight(10));
        make.bottom.equalTo(self).offset(TPAdaptedHeight(-18));

        
    }];
    [_pageControll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(_collectionView.mas_bottom);
        
    }];
}

#pragma mark - System Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = _collectionView.contentOffset.x/(TPAdaptedWidth(180));
    _pageControll.currentPage = page;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return (_fuctionItemArr.count %6 == 0 ?_fuctionItemArr.count / 6:_fuctionItemArr.count / 6+1)*6;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.fuctionItemArr.count > 0 && indexPath.item <= self.fuctionItemArr.count-1) {
        if (self.tapItemBlock) {
            self.tapItemBlock(_fuctionItemArr[indexPath.item].url);
        }
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString * collectionIdentifier = @"FuctionCollectionCell";
    TPDHomeFuctionCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];

    if (cell) {
        if (self.fuctionItemArr.count > 0 && indexPath.item <= self.fuctionItemArr.count-1) {
           cell.model = self.fuctionItemArr[indexPath.item];
        }else{
            cell.model = nil;
        }
       
    }
    
    return cell;
}

#pragma mark - Getters and Setters
- (UIPageControl *)pageControll
{
    if (!_pageControll) {
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.numberOfPages = 2;
        _pageControll.currentPageIndicatorTintColor = TPGradientStartColor;
        _pageControll.pageIndicatorTintColor = TPUNEnbleColor_LineColor;
        _pageControll.currentPage = 0;
        _pageControll.backgroundColor = TPWhiteColor;
        
    }
    return _pageControll;
}


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0;
        layout.itemSize = CGSizeMake(TPAdaptedWidth(187), TPAdaptedHeight(75));
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,  TPAdaptedHeight(10), self.frame.size.width,self.frame.size.height-TPAdaptedHeight(28)) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = TPWhiteColor;
        _collectionView.bounces = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        
        //注册Cell
        [_collectionView registerClass:[TPDHomeFuctionCollectionCell class] forCellWithReuseIdentifier:@"FuctionCollectionCell"];
    }
    return _collectionView;
    
}
- (void)setFuctionItemArr:(NSArray *)fuctionItemArr {
    
    _fuctionItemArr = fuctionItemArr;
    _pageControll.numberOfPages = _fuctionItemArr.count %6 == 0 ?_fuctionItemArr.count / 6:_fuctionItemArr.count / 6+1;
    _collectionView.contentSize = CGSizeMake(self.collectionView.width, _pageControll.numberOfPages *TPScreenWidth);
    [self.collectionView reloadData];
    
}
@end
