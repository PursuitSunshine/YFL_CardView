//
//  YFLDragCardContainer.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "YFLDragCardContainer.h"
#import "YFLDragConfigure.h"
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

@property (nonatomic,strong) YFLDragConfigure *configure;

@end

@implementation YFLDragCardContainer

#pragma mark - Init Methods
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame configure:[self setDefaultsConfigures]];
}

- (instancetype)initWithFrame:(CGRect)frame configure:(YFLDragConfigure*)configure
{
    self = [super initWithFrame:frame];
    if (self){
        [self initDataConfigure:configure];
    }
    return self;
}

#pragma mark - Private Methods
- (YFLDragConfigure*)setDefaultsConfigures
{
    YFLDragConfigure *configure = [[YFLDragConfigure alloc]init];
    configure.visableCount = 3;
    configure.containerEdge = 10.0f;
    configure.cardEdge = 5.0f;
    configure.cardCornerRadius = 10.0f;
    configure.cardCornerBorderWidth = 0.45f;
    configure.cardBordColor = [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1];
    return configure;
}

- (void)initDataConfigure:(YFLDragConfigure*)configure
{
    [self resetInitData];
    self.cards = [[NSMutableArray alloc]init];
    self.backgroundColor = [UIColor whiteColor];
    self.configure = !configure ? [self setDefaultsConfigures] : configure;
}

- (void)resetInitData
{
    self.loadedIndex = 0;
    self.direction = ContainerDragDefaults;
    self.isMoveIng = NO;
    
}//重置数据(为了二次调用reload)


- (void)addSubViews
{
    NSInteger sum = [self.dataSource numberOfRowsInYFLDragCardContainer:self];
    NSInteger preLoadViewCount = (sum <= self.configure.visableCount) ? sum : self.configure.visableCount;
    //预防越界
    if (self.loadedIndex <  sum)
    {
        // 当手势滑动，加载第四个，最多创建4个。不存在内存warning。(手势停止，滑动的view没消失，需要干掉多创建的+1)
        for (NSInteger i = self.cards.count; i < (self.isMoveIng ? preLoadViewCount+1:preLoadViewCount); i++)
        {
            YFLDragCardView *cardView = [self.dataSource container:self viewForRowsAtIndex:self.loadedIndex];
            cardView.frame = CGRectMake(self.configure.containerEdge, self.configure.containerEdge, self.frame.size.width-2*self.configure.containerEdge, self.frame.size.height-2*(self.configure.containerEdge+self.configure.cardEdge));
            [cardView setConfigure:self.configure];
            [cardView YFLDragCardViewLayoutSubviews];
            [self recordFrame:cardView];
            cardView.tag = self.loadedIndex;
            [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)]];
            [cardView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)]];
            [self addSubview:cardView];
            [self sendSubviewToBack:cardView];
            [self.cards addObject:cardView];
            self.loadedIndex += 1;
        }
    }
}//添加子视图

- (void)resetLayoutSubviews
{
    //动画时允许用户交流，比如触摸 | 时间曲线函数，缓入缓出，中间快
    [UIView animateWithDuration:0.5f delay:0.0f usingSpringWithDamping:0.6 initialSpringVelocity:0.6 options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionCurveEaseInOut animations:^{
        
        if ([self.delegate respondsToSelector:@selector(container:dargingForCardView:direction:widthRate:heightRate:)]) {
            [self.delegate container:self dargingForCardView:self.cards.firstObject direction:self.direction widthRate:0 heightRate:0];
        }
      
        for (int i = 0; i < self.cards.count; i++){
            YFLDragCardView *cardView = [self.cards objectAtIndex:i];
            cardView.transform = CGAffineTransformIdentity;
            CGRect frame = self.firstCardFrame;
            
            switch (i) {
                case 0:
                    cardView.frame = frame;
                    break;
                case 1:
                {
                    frame.origin.y = frame.origin.y+self.configure.cardEdge;
                    cardView.frame = frame;
                    cardView.transform = CGAffineTransformScale(CGAffineTransformIdentity, secondCardScale, 1);
                }
                    break;
                 case 2:
                {
                    frame.origin.y = frame.origin.y+2*self.configure.cardEdge;
                    cardView.frame = frame;
                    cardView.transform = CGAffineTransformScale(CGAffineTransformIdentity, thirdCardScale, 1);
                    if (CGRectIsEmpty(self.lastCardFrame)) {
                        self.lastCardFrame = frame;
                        self.lastCardTransform = cardView.transform;
                    }
                }
                    break;
                default:
                    break;
            }
            
            cardView.originTransForm = cardView.transform;

        }
        
    } completion:^(BOOL finished) {
        
        BOOL isEmpty = self.cards.count == 0 ? YES : NO;
        if (self.delegate && [self.delegate respondsToSelector:@selector(container:dataSourceIsEmpty:)]) {
            [self.delegate container:self dataSourceIsEmpty:isEmpty];
        }
    }];


}//布局子视图

- (void)recordFrame:(YFLDragCardView *)cardView
{
    if (self.loadedIndex >= 3){
        
        cardView.frame = self.lastCardFrame;
        
    }else{
        
        CGRect frame = cardView.frame;
        if (CGRectIsEmpty(self.firstCardFrame)){
            self.firstCardFrame = frame;
            self.cardCenter = cardView.center;
        }
    }
}

- (void)moveIngStatusChange:(float)scale
{
    //如果正在移动，添加第四个
    if (!self.isMoveIng) {
        
        self.isMoveIng = YES;
        [self addSubViews];
        
    }else{
        
        //第四个加载完，立马改变没作用在手势上其他cardview的scale
        scale = fabsf(scale) >= boundaryRation ? boundaryRation : fabsf(scale);
        CGFloat transFormtxPoor = (secondCardScale-thirdCardScale)/(boundaryRation/scale);
        CGFloat frameYPoor = self.configure.cardEdge/(boundaryRation/scale); // frame y差值
        
        for (int index = 1; index < self.cards.count ; index++) {
           
            YFLDragCardView *cardView = (YFLDragCardView *)self.cards[index];
            
            switch (index) {
                case 1:
                {
                    CGAffineTransform scale = CGAffineTransformScale(CGAffineTransformIdentity, transFormtxPoor + secondCardScale, 1);
                    CGAffineTransform translate = CGAffineTransformTranslate(scale, 0, -frameYPoor);
                    cardView.transform = translate;
                }
                    break;
                    
                case 2:
                {
                    CGAffineTransform scale = CGAffineTransformScale(CGAffineTransformIdentity, transFormtxPoor + thirdCardScale, 1);
                    CGAffineTransform translate = CGAffineTransformTranslate(scale, 0, -frameYPoor);
                    cardView.transform = translate;
                    
                }
                    break;
                    
                case 3:
                {
                    cardView.transform = self.lastCardTransform;
                }
                    break;
                    
                default:
                    break;
            }
            
        }
  
        
    }
    
}//移动卡片

- (void)panGesturemMoveFinishOrCancle:(YFLDragCardView*)cardView direction:(ContainerDragDirection)direction scale:(float)scale isDisappear:(BOOL)isDisappear
{
    if (!isDisappear) {
        
        //干掉多创建的第四个.重置标量
        if (self.isMoveIng && self.cards.count > self.configure.visableCount) {
            
            YFLDragCardView *lastView = (YFLDragCardView *)self.cards.lastObject;
            [lastView removeFromSuperview];
            [self.cards removeObject:lastView];
            self.loadedIndex = lastView.tag;
        }
        self.isMoveIng = NO;
        [self resetLayoutSubviews];
    }else{
        
        
        if ([self.delegate respondsToSelector:@selector(container:dragDidFinshForDirection:forCardView:)]) {
            
            [self.delegate container:self dragDidFinshForDirection:self.direction forCardView:cardView];
            
        }
        
        NSInteger flag = (direction == ContainerDragLeft?-1:2);
        
        [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction animations:^{
            
            cardView.center = CGPointMake(flag*ScreenWidth, flag*ScreenWidth/scale+self.cardCenter.y);
            
        } completion:^(BOOL finished) {
            
            [cardView removeFromSuperview];
            
        }];
        
        [self.cards removeObject:cardView];
        self.isMoveIng = NO;
        [self resetLayoutSubviews];

        
    }
    
}//手势结束

#pragma mark - Public Methods
- (void)reloadData
{
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfRowsInYFLDragCardContainer:)] && [self.dataSource respondsToSelector:@selector(container:viewForRowsAtIndex:)]) {
        
        [self resetInitData];
        
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
    if (self.isMoveIng) return;
    CGPoint cardCenter = CGPointZero;
    NSInteger flag = 0;
    switch (direction) {
            
        case ContainerDragLeft:
        {  cardCenter = CGPointMake(-ScreenWidth/2.0, self.cardCenter.y);
            flag = -1;
        }
            break;
        case ContainerDragRight:
        {
            cardCenter = CGPointMake(ScreenWidth*1.5, self.cardCenter.y);
            flag = 1;
            
        }
            break;
        default:
            break;
    }
    
    YFLDragCardView *currentShowCardView = self.cards.firstObject;
    [UIView animateWithDuration:0.35 animations:^{
        CGAffineTransform translate = CGAffineTransformTranslate(CGAffineTransformIdentity, flag * 20, 0);
        currentShowCardView.transform = CGAffineTransformRotate(translate, flag * M_PI_4 / 4);
        currentShowCardView.center = cardCenter;
    } completion:^(BOOL finished) {
        
        [currentShowCardView removeFromSuperview];
        [self.cards removeObject:currentShowCardView];
        [self addSubViews];
        [self resetLayoutSubviews];
        
    }];

    //卡片滑动结束的代理(可用户发送数据请求)
    if ([self.delegate respondsToSelector:@selector(container:dragDidFinshForDirection:forCardView:)]) {
        
        [self.delegate container:self dragDidFinshForDirection:direction forCardView:currentShowCardView];
    }
    
    
}//手动点击移除

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
        
        if (pan.state == UIGestureRecognizerStateBegan){
            // TO DO
        }else if (pan.state == UIGestureRecognizerStateChanged){
            
            YFLDragCardView *cardView = (YFLDragCardView *)pan.view;
            //以自身的左上角为原点；每次移动后，原点都置0；计算的是相对于上一个位置的偏移；
            CGPoint point = [pan translationInView:self];
            cardView.center = CGPointMake(pan.view.center.x+point.x, pan.view.center.y+point.y);
            
            //当angle为正值时,逆时针旋转坐标系统,反之顺时针旋转坐标系统
            cardView.transform = CGAffineTransformRotate(cardView.originTransForm, (pan.view.center.x-self.cardCenter.x)/self.cardCenter.x*(M_PI_4/12));
           
            [pan setTranslation:CGPointZero inView:self]; // 设置坐标原点位上次的坐标
           
            if ([self.delegate respondsToSelector:@selector(container:dargingForCardView:direction:widthRate:heightRate:)]) {
                
            //计算横向滑动比例 >0 向右  <0 向左
            float horizionSliderRate = (pan.view.center.x-self.cardCenter.x)/self.cardCenter.x;
            float verticalSliderRate = (pan.view.center.y-self.cardCenter.y)/self.cardCenter.y;
            
            //正在滑动，需要创建第四个。
            [self moveIngStatusChange:horizionSliderRate];
            
            if (horizionSliderRate > 0) {
                self.direction = ContainerDragRight;
            }else if (horizionSliderRate < 0){
                self.direction = ContainerDragLeft;
            }else{
                self.direction = ContainerDragDefaults;
            }

           
            [self.delegate container:self dargingForCardView:cardView direction:self.direction widthRate:horizionSliderRate heightRate:verticalSliderRate];
            }
        }else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateEnded){
            //还原，或者消失
            float horizionSliderRate = (pan.view.center.x-self.cardCenter.x)/self.cardCenter.x;
            float moveY = (pan.view.center.y-self.cardCenter.y);
            float moveX = (pan.view.center.x-self.cardCenter.x);
            [self panGesturemMoveFinishOrCancle:(YFLDragCardView*)pan.view direction:self.direction scale:moveX/moveY isDisappear:fabs(horizionSliderRate)>boundaryRation];

     
     
        }
        
    }
}

@end
