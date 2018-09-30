//
//  YFLDragConfigure.h
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/26.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import <UIKit/UIKit.h>

// 边界比
static const CGFloat boundaryRation = 0.8f;
static const CGFloat secondCardScale = 0.95f;
static const CGFloat thirdCardScale = 0.90f;

typedef NS_ENUM(NSInteger, ContainerDragDirection)
{
    ContainerDragDefaults,
    ContainerDragLeft,
    ContainerDragRight
};

@interface YFLDragConfigure : NSObject

@property (nonatomic,assign) ContainerDragDirection direction;

/** 可见个数 默认为 3 **/
@property (nonatomic,assign) NSInteger visableCount;
/** 卡片边距 默认为10.0f **/
@property (nonatomic,assign) CGFloat containerEdge;
/** 卡片内边距 默认为5.0f **/
@property (nonatomic,assign) CGFloat cardEdge;
/** 卡片圆角  默认为10.0f **/
@property (nonatomic,assign) CGFloat cardCornerRadius;
/** 卡片边缘宽度 默认为0.45f **/
@property (nonatomic,assign) CGFloat cardCornerBorderWidth;
/** 卡片边缘颜色 **/
@property (nonatomic,strong) UIColor *cardBordColor;


/** 物理屏幕宽度 **/
#define ScreenWidth  UIScreen.mainScreen.bounds.size.width
/** 物理屏幕高度 **/
#define ScreenHeight UIScreen.mainScreen.bounds.size.height



@end
