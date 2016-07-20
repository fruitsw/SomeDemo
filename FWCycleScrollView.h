//
//  FWCycleScrollView.h
//  CycleScrollDemo
//
//  Created by wanjinguo on 16/7/19.
//  Copyright © 2016年 Geeko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FWCycleScrollView;

@protocol FWCycleScrollViewDelegate <NSObject>

@optional

- (void)cycleScrollView:(FWCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;

@end

@interface FWCycleScrollView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id<FWCycleScrollViewDelegate>delegate;

@property (nonatomic, assign) BOOL isAutoScroll;
@property (nonatomic, assign) NSTimeInterval autoScrollTimeInterval;

@property (nonatomic, assign) BOOL isShowPageControl;
@property (nonatomic, strong) UIColor *currentPageContolColor;
@property (nonatomic, strong) UIColor *pageControlColor;

@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, weak) NSTimer *timer;

@end
