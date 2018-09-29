//
//  MainViewController.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "MainViewController.h"
#import "YFLDragCardContainer.h"
#import "CardView.h"
@interface MainViewController ()<YFLDragCardContainerDataSource,YFLDragCardContainerDelegate>

@property (nonatomic,strong) NSMutableArray *names;

@property (nonatomic,strong) NSMutableArray *titles;

@property (nonatomic,strong)  YFLDragCardContainer *container;

@end

@implementation MainViewController

#pragma mark - ViewController  Life
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"仿探探、陌陌左右滑动";
    
    self.container = [[YFLDragCardContainer alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 500)];
    self.container .dataSource = self;
    self.container .delegate = self;
    [self.view addSubview:self.container ];
    
    self.names = [[NSMutableArray alloc]init];
    self.titles = [[NSMutableArray alloc]init];
    
    for (int i = 1; i < 9; i++) {
        
        [self.names addObject:[NSString stringWithFormat:@"image_%d.jpg",i]];
        [self.titles addObject:[NSString stringWithFormat:@"Page %d",i]];
        
    }

    [self.container reloadData];
}

#pragma mark -  YFLDragCardContainer  DataSource
- (NSInteger)numberOfRowsInYFLDragCardContainer:(YFLDragCardContainer *)container
{
    return self.names.count;
}


- (YFLDragCardView *)container:(YFLDragCardContainer *)container viewForRowsAtIndex:(NSInteger)index
{
    CardView *cardView = [[CardView alloc]initWithFrame:container.bounds];
    [cardView setImage:self.names[index] title:self.titles[index]];
    return cardView;
}


#pragma mark -  YFLDragCardContainer  Delegate
- (void)container:(YFLDragCardContainer *)container didSelectRowAtIndex:(NSInteger)index
{
    NSLog(@"didSelectRowAtIndex :%ld",(long)index);
}


- (void)container:(YFLDragCardContainer *)container dataSourceIsEmpty:(BOOL)isEmpty
{
    NSLog(@"数据已经空了");
    [container  reloadData];
}


- (void)container:(YFLDragCardContainer *)container willShowCardView:(YFLDragCardView *)cardView
{
    NSLog(@"willShowCardViewTag:%ld",cardView.tag);
}

/**  当前cardview 是否可以拖拽，默认YES **/
- (BOOL)container:(YFLDragCardContainer *)container canDragForCardView:(YFLDragCardView *)cardView
{
    return YES;
}

///** 卡片处于拖拽中回调**/
//- (void)container:(YFLDragCardContainer *)container dargingForCardView:(YFLDragCardView *)cardView direction:(ContainerDragDirection)direction widthRate:(float)widthRate  heightRate:(float)heightRate
//{
//
//}

/** 卡片拖拽结束回调（卡片消失） **/
- (void)container:(YFLDragCardContainer *)container dragDidFinshForDirection:(ContainerDragDirection)direction forCardView:(YFLDragCardView *)cardView
{
    NSLog(@" dragDidFinsh:%ld",(long)cardView.tag);
}

#pragma mark - Private Methods
#pragma mark - Action Methods
#pragma mark - OverRide Methods

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
