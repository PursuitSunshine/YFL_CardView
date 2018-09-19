//
//  YFLDragCardContainer.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "YFLDragCardContainer.h"

@interface YFLDragCardContainer()

/** YFLDragCardView实例的集合 **/
@property (nonatomic,strong) NSMutableArray <YFLDragCardView *> *cards;

/** 滑动方向 **/
@property (nonatomic,assign)  ContainerDragDirection direction;

/** 是否滑动 **/
@property (nonatomic,assign) BOOL isMoveIng;

/** 已加载个数 **/
@property (nonatomic,assign) NSInteger loadedIndex;

/** 记录第一个card的farme **/
@property (nonatomic,assign) CGRect firstCardFrame;

/** 记录最后一个card的frame **/
@property (nonatomic,assign) CGRect lastCardFrame;

/** 记录card的center **/
@property (nonatomic,assign) CGPoint cardCenter;

/** 记录最后一个card的transform **/
@property (nonatomic,assign) CGAffineTransform lastCardTransform;

@end

@implementation YFLDragCardContainer

#pragma mark - Init Methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initData];
    }
    return self;
}

#pragma mark - Private Methods
- (void)initData
{
    self.cards = [[NSMutableArray alloc]init];
    self.direction = ContainerDragDefaults;
    self.isMoveIng = NO;
    self.loadedIndex = 0;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)addSubViews
{
    NSInteger sum = [self.dataSource numberOfRowsInYFLDragCardContainer:self];
    NSInteger preLoadViewCount = (sum <= visableCount) ? sum : visableCount;
    //预防越界
    if (self.loadedIndex < sum)
    {
        // 当手势滑动，加载第四个。(手势停止，滑动的view没消失，需要干掉多创建的+1)
        for (NSInteger i = self.cards.count; i < (self.isMoveIng ? preLoadViewCount+1:preLoadViewCount); i++)
        {
            YFLDragCardView *cardView = [self.dataSource container:self viewForRowsAtIndex:self.loadedIndex];
            cardView.frame = CGRectMake(containerEdge, containerEdge, self.frame.size.width-2*containerEdge, self.frame.size.height-2*(containerEdge+cardEdge));
            [cardView YFLDragCardViewLayoutSubviews];
            [self recordFrame:cardView];
            cardView.tag = self.loadedIndex;
            [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)]];
            [cardView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)]];
            [self addSubview:cardView];
            [self sendSubviewToBack:cardView];
            [self.cards addObject:cardView];
            self.loadedIndex++;
            
        }
    }
    
    
}//添加子视图

- (void)resetLayoutSubviews
{
    //动画时允许用户交流，比如触摸 | 时间曲线函数，缓入缓出，中间快
    [UIView animateWithDuration:5.0f delay:0.0f options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut animations:^{
        
        for (int i = 0; i < self.cards.count; i++){
            YFLDragCardView *cardView = [self.cards objectAtIndex:i];
            cardView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1-i*0.05, 1);
            CGRect frame = cardView.frame;
            frame.origin.y = frame.origin.y+i*cardEdge;
            cardView.frame = frame;
            cardView.originTransForm = cardView.transform;
            
            if (CGRectIsEmpty(self.lastCardFrame) && i == 2){
                self.lastCardFrame = frame;
                self.lastCardTransform = cardView.transform;
            }
            
        }
        
    } completion:^(BOOL finished) {
        
        if ([self.delegate respondsToSelector:@selector(container:dataSourceIsEmpty:)]) {
            
            [self.delegate container:self
                   dataSourceIsEmpty:self.cards.count == 0 ? YES : NO];
        }
        
        
    }];
    
    
    
}//布局子视图

- (void)recordFrame:(YFLDragCardView *)cardView
{
    if (self.loadedIndex >= 3){
        
        cardView.frame = self.lastCardFrame;
        
    }else{
        
        if (CGRectIsEmpty(self.firstCardFrame)){
            self.firstCardFrame = cardView.frame;
            self.cardCenter = cardView.center;
        }
    }
}

#pragma mark - Public Methods
- (void)reloadData
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInYFLDragCardContainer:)] && [self.dataSource respondsToSelector:@selector(container:viewForRowsAtIndex:)]) {
        
        [self addSubViews];

        [self resetLayoutSubviews];
        
    }else{
        
        NSAssert(self.dataSource, @"check dataSource and dataSource Methods!");
    }
    
}

- (YFLDragCardView *)getCurrentShowCardView
{
    return self.cards.firstObject;
}

- (NSInteger)getCurrentShowCardViewIndex
{
    return self.cards.firstObject.tag;
}

- (void)removeCardViewForDirection:(ContainerDragDirection)direction
{
    
}

#pragma mark - Action Methods
- (void)handleTapGesture:(UITapGestureRecognizer*)tap
{
    if ([self.delegate respondsToSelector:@selector(container:didSelectRowAtIndex:)])
    {
        [self.delegate container:self didSelectRowAtIndex:tap.view.tag];
    }
    
}//单击手势

- (void)handlePanGesture:(UIPanGestureRecognizer*)pan
{
    BOOL canEdit = YES;
    
    if ([self.delegate respondsToSelector:@selector(container:canDragForCardView:)]) {
        
        canEdit = [self.delegate container:self canDragForCardView:(YFLDragCardView*)pan.view];
    }
    
    if (canEdit) {
        
        if (pan.state == UIGestureRecognizerStateBegan)
        {
            
            // TO DO
            
            
        }else if (pan.state == UIGestureRecognizerStateChanged)
        {
            
            
        }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateEnded)
        {
            
        }
        
    }
    
   
}


@end
