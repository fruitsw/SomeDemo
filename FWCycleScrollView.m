//
//  FWCycleScrollView.m
//  CycleScrollDemo
//
//  Created by wanjinguo on 16/7/19.
//  Copyright © 2016年 Geeko. All rights reserved.
//

#import "FWCycleScrollView.h"
#import "FWCustomerFlowLayout.h"
#import "FWCustomerCollectionCell.h"

@interface FWCycleScrollView () <UICollectionViewDelegate, UICollectionViewDataSource>
{
    FWCustomerFlowLayout *_flowLayout;
    UICollectionView *_collectionView;
    
    UIPageControl *_pageControl;
    NSMutableArray *_imageArray;
}

@end

@implementation FWCycleScrollView

- (instancetype)init
{
    if (self = [super init]) {
        [self configSetting];
        [self configCollectionAndPageControl];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self configSetting];
        [self configCollectionAndPageControl];
    }
    return self;
}

- (void)configCollectionAndPageControl
{
    _flowLayout = [[FWCustomerFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0.f;
    _flowLayout.minimumInteritemSpacing = 0.f;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[FWCustomerCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = 0;
    _pageControl.tintColor = [UIColor whiteColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    [self addSubview:_pageControl];
}

- (void)configSetting
{
    _autoScrollTimeInterval = 4.f;
    _isShowPageControl = YES;
    _isAutoScroll = YES;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    _collectionView.frame = frame;
    [self setItemSize:self.bounds.size];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (CGSizeEqualToSize(_itemSize, CGSizeZero)) {
        [self setItemSize:self.bounds.size];
    }
    else {
        [self setItemSize:self.itemSize];
    }
    _collectionView.frame = self.frame;
    _pageControl.frame = CGRectMake(0, self.frame.origin.y + CGRectGetHeight(self.bounds) - 20, CGRectGetWidth(self.bounds), 10);
}

- (void)setItemSize:(CGSize)itemSize
{
    _itemSize = itemSize;
    _flowLayout.itemSize = _itemSize;
}

- (void)setIsShowPageControl:(BOOL)isShowPageControl
{
    _pageControl.hidden = !isShowPageControl;
}

- (void)setPageControlColor:(UIColor *)pageControlColor
{
    _pageControl.pageIndicatorTintColor = pageControlColor;
}

- (void)setCurrentPageContolColor:(UIColor *)currentPageContolColor
{
    _pageControl.currentPageIndicatorTintColor = currentPageContolColor;
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll
{
    
}

- (void)setDataArray:(NSArray *)dataArray
{
    if (dataArray.count == 0) {
        return;
    }
    
    _pageControl.numberOfPages = dataArray.count;
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    [_imageArray addObject:[dataArray lastObject]];
    [_imageArray addObjectsFromArray:dataArray];
    [_imageArray addObject:[dataArray firstObject]];
    
    static BOOL first = YES;
    if (first) {
        [_collectionView setContentOffset:CGPointMake(_itemSize.width, 0) animated:NO];
        first = NO;
    }
    
    [_collectionView reloadData];
    [self timerOn];
}

- (void)setAutoScrollTimeInterval:(NSTimeInterval)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
}

- (void)timerOn
{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(autoScrollBegin:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)timerOff
{
    [_timer invalidate];
    _timer = nil;
}

- (void)autoScrollBegin:(id)sender
{
    if (_collectionView.contentOffset.x > _collectionView.contentSize.width - self.itemSize.width) {
        [_collectionView setContentOffset:CGPointMake(self.itemSize.width - (self.bounds.size.width - self.itemSize.width - 10) / 2.0, 0) animated:NO];
    }
    NSInteger currentPage = _collectionView.contentOffset.x/_itemSize.width;
    currentPage ++;
    
    [_collectionView setContentOffset:CGPointMake(currentPage * _itemSize.width, 0) animated:YES];
}

#pragma mark -collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FWCustomerCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = _imageArray[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == _imageArray.count -1) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
        [self.delegate cycleScrollView:self didSelectItemAtIndex:(indexPath.row % (_pageControl.numberOfPages + 1)) - 1];
    }
}


#pragma mark -scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_collectionView.contentOffset.x >= _collectionView.contentSize.width - _itemSize.width) {
        [_collectionView setContentOffset:CGPointMake(_itemSize.width, 0) animated:NO];
    }
    else if (_collectionView.contentOffset.x <= 0) {
        [_collectionView setContentOffset:CGPointMake(_collectionView.contentSize.width - 2*_itemSize.width, 0) animated:NO];
    }
    else {
        NSInteger realPage = (scrollView.contentOffset.x -(self.itemSize.width - (self.bounds.size.width - self.itemSize.width) / 2.0)) / self.itemSize.width;
        if (realPage == _imageArray.count - 2) {
            realPage = 0;
        }
        _pageControl.currentPage = realPage;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self timerOff];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self timerOn];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_collectionView.contentOffset.x > _collectionView.contentSize.width - _itemSize.width) {
        [_collectionView setContentOffset:CGPointMake(_itemSize.width, 0) animated:NO];
    }
}
@end
