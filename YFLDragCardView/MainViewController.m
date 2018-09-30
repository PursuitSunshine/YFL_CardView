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

@property (nonatomic,strong) NSMutableArray <NSString*>*names;

@property (nonatomic,strong) NSMutableArray <NSString*>*titles;

@property (nonatomic,strong)  YFLDragCardContainer *container;

@property (nonatomic,strong) NSMutableArray <UIButton*>*controllers;

@end

@implementation MainViewController

#pragma mark - ViewController  Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"仿探探、陌陌左右滑动";
    self.controllers = [[NSMutableArray alloc]init];
    
    self.container = [[YFLDragCardContainer alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 400)];
    self.container .dataSource = self;
    self.container .delegate = self;
    [self.view addSubview:self.container];
    
    self.names = [[NSMutableArray alloc]init];
    self.titles = [[NSMutableArray alloc]init];
    
    for (int i = 1; i < 9; i++) {
        
        [self.names addObject:[NSString stringWithFormat:@"image_%d.jpg",i]];
        [self.titles addObject:[NSString stringWithFormat:@"Page %d",i]];
        
    }
    
    [self.container reloadData];
    
    NSArray *btnImageNames = @[@"finder_dislike_btn",@"finder_like_btn"];
    NSArray *methodNames = @[@"dislikeAction:",@"likeAction:"];
    CGFloat originX = (self.view.frame.size.width-75*2-70)/2.0;
    for (int index = 0;index <  btnImageNames.count; index++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:btnImageNames[index]] forState:UIControlStateNormal];
        [btn addTarget:self action:NSSelectorFromString(methodNames[index]) forControlEvents:UIControlEventTouchUpInside];
        [self.controllers addObject:btn];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(originX+index*(75+70), self.container.frame.origin.y+self.container.frame.size.height+30, 75, 75);
    }
    
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
    if (isEmpty) {
        [container  reloadData];
    }
}

- (BOOL)container:(YFLDragCardContainer *)container canDragForCardView:(YFLDragCardView *)cardView
{
    return YES;
}

- (void)container:(YFLDragCardContainer *)container dargingForCardView:(YFLDragCardView *)cardView direction:(ContainerDragDirection)direction widthRate:(float)widthRate  heightRate:(float)heightRate
{
    CardView*currentShowCardView = (CardView*)cardView;
    CGFloat scale = 1 + ((boundaryRation > fabs(widthRate) ? fabs(widthRate) : boundaryRation)) / 4;
    NSString  *scaleString =  [NSString stringWithFormat:@"%.2f",scale];
    NSNumber *number = [NSNumber numberWithFloat:scaleString.floatValue];
    direction = [number isEqual:@1] ? ContainerDragDefaults:direction;
    [currentShowCardView  setAnimationwithDriection:direction];
    
}

- (void)container:(YFLDragCardContainer *)container dragDidFinshForDirection:(ContainerDragDirection)direction forCardView:(YFLDragCardView *)cardView
{
    NSLog(@"disappear:%ld",(long)cardView.tag);
}


#pragma mark - Action Methods
- (void)dislikeAction:(UIButton*)sender
{
    [self.container removeCardViewForDirection:ContainerDragLeft];
    CardView *cardView = (CardView *)[self.container getCurrentShowCardView];
    [cardView setAnimationwithDriection:ContainerDragLeft];
    
}

- (void)likeAction:(UIButton*)sender
{
    [self.container removeCardViewForDirection:ContainerDragRight];
    CardView *cardView = (CardView *)[self.container getCurrentShowCardView];
    [cardView setAnimationwithDriection:ContainerDragRight];
}

#pragma mark - OverRide Methods
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end

