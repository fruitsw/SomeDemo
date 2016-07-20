//
//  ViewController.m
//  CycleScrollDemo
//
//  Created by wanjinguo on 16/7/19.
//  Copyright © 2016年 Geeko. All rights reserved.
//

#import "ViewController.h"
#import "FWCycleScrollView.h"

@interface ViewController ()<FWCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FWCycleScrollView *fwView = [[FWCycleScrollView alloc] init];
    fwView.frame = CGRectMake(0, 20, 320, 100);
    fwView.dataArray = [NSArray arrayWithObjects:[UIColor redColor], [UIColor orangeColor], [UIColor blueColor], [UIColor grayColor], nil];
    fwView.delegate = self;
    [self.view addSubview:fwView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)cycleScrollView:(FWCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击了第 %@ 张", @(index));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
