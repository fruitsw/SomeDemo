//
//  FWCustomerFlowLayout.m
//  CycleScrollDemo
//
//  Created by wanjinguo on 16/7/19.
//  Copyright © 2016年 Geeko. All rights reserved.
//

#import "FWCustomerFlowLayout.h"

@implementation FWCustomerFlowLayout

//  自定义需要的动画形式

/*
- (void)prepareLayout
{
    [super prepareLayout];
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    UICollectionView *collectionView = self.collectionView;
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attribute in attrs) {
        
        CGFloat deltaX = fabs(attribute.center.x - collectionView.bounds.size.width * .5f - collectionView.contentOffset.x);
        CGFloat scale = 1 - deltaX / collectionView.bounds.size.width * .5f;
        attribute.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return attrs;
}


-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}


-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    UICollectionView *collectionView = self.collectionView;
    
    CGRect rect = CGRectMake(proposedContentOffset.x, 0, collectionView.bounds.size.width, collectionView.bounds.size.height);
    NSArray *attrs = [super layoutAttributesForElementsInRect:rect];
    CGFloat miniumDistance = MAXFLOAT;
    CGFloat deltaX = 0;
    for (UICollectionViewLayoutAttributes *attr in attrs) {
        deltaX = attr.center.x - proposedContentOffset.x - collectionView.bounds.size.width * .5f;
        if (fabs(deltaX) < fabs(miniumDistance)) {
            miniumDistance = deltaX;
        }
    }
    proposedContentOffset.x = proposedContentOffset.x + miniumDistance;
    if (proposedContentOffset.x < 0) {
        proposedContentOffset.x = 0;
    }
    NSLog(@"%f",proposedContentOffset.x);
    return proposedContentOffset;
}
 */
@end
