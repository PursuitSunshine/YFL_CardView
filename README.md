# 仿探探、陌陌社交左右滑动找好友，效果图如下
![image](https://raw.githubusercontent.com/CoderYangFeiLong/YFL_CardView/master/YFLDragCardViewProject/YFLDragCardViewProject/resource//IMG_3694.GIF)

# 自定义说明
  支持自定义卡牌样式，继承YFLDragCardView类，并重写- (void)YFLDragCardViewLayoutSubviews 方法，在该方法里布局子视图即可。

# 示例代码
    YFLDragConfigure *configure = [[YFLDragConfigure alloc]init];
    configure.visableCount = 3;
    configure.containerEdge = 10.0f;
    configure.cardEdge = 5.0f;
    configure.cardCornerRadius = 10.0f;
    configure.cardCornerBorderWidth = 0.45f;
    configure.cardBordColor = [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1];
    self.container = [[YFLDragCardContainer alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 400) configure:configure];
    self.container.dataSource = self;
    self.container.delegate = self;
    [self.view addSubview:self.container];
    [self.container reloadData];
    
    或者默认初始化方法
    self.container = [[YFLDragCardContainer alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, 400)];
    self.container.dataSource = self;
    self.container.delegate = self;
    [self.view addSubview:self.container];
    [self.container reloadData];
    

# 数据源方法
    - (NSInteger)numberOfRowsInYFLDragCardContainer:(YFLDragCardContainer *)container
    {
       return self.data.count;
    }
    - (YFLDragCardView *)container:(YFLDragCardContainer *)container viewForRowsAtIndex:(NSInteger)index
    { 
       return [YFLDragCardView new];
    }
    
  # 代理方法
    - (void)container:(YFLDragCardContainer *)container didSelectRowAtIndex:(NSInteger)index
    {
        NSLog(@"didSelectRowAtIndex :%ld",(long)index);
    }
    - (void)container:(YFLDragCardContainer *)container dataSourceIsEmpty:(BOOL)isEmpty
    {
       // TO  DO
    }
    - (BOOL)container:(YFLDragCardContainer *)container canDragForCardView:(YFLDragCardView *)cardView
    {
       return YES;
    }
    - (void)container:(YFLDragCardContainer *)container dargingForCardView:(YFLDragCardView *)cardView direction:(ContainerDragDirection)direction widthRate:(float)widthRate  heightRate:(float)heightRate
    {
      // TO DO
    }
    - (void)container:(YFLDragCardContainer *)container dragDidFinshForDirection:(ContainerDragDirection)direction forCardView:(YFLDragCardView *)cardView
    {
        NSLog(@"disappear:%ld",(long)cardView.tag);
    }
    
