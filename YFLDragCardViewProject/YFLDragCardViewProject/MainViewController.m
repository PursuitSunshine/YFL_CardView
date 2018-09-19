//
//  MainViewController.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "MainViewController.h"
#import "YFLDragCardContainer.h"
@interface MainViewController ()<YFLDragCardContainerDataSource,UICollectionViewDelegate>

@end

@implementation MainViewController

#pragma mark - ViewController  Life
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"仿探探、陌陌左右滑动";
    
    YFLDragCardContainer *container = [[YFLDragCardContainer alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 300)];
    container.dataSource = self;
    [self.view addSubview:container];

    [container reloadData];


}

- (NSInteger)numberOfRowsInYFLDragCardContainer:(YFLDragCardContainer *)container
{
    return 10;
}

/** 显示数据源 **/
- (YFLDragCardView *)container:(YFLDragCardContainer *)container viewForRowsAtIndex:(NSInteger)index
{
    YFLDragCardView *cardView = [[YFLDragCardView alloc]initWithFrame:container.bounds];
    return cardView;
}

#pragma mark - Private Methods
#pragma mark - Action Methods
#pragma mark - OverRide Methods

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
