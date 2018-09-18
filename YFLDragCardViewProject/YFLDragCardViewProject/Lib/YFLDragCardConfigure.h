//
//  YFLDragCardConfigure.h
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#ifndef YFLDragCardConfigure_h
#define YFLDragCardConfigure_h

/** 滑动方向 **/
typedef NS_OPTIONS(NSInteger, ContainerDragDirection)
{
    ContainerDragDefaults,
    ContainerDragLeft,
    ContainerDragRight
};

/** 可见卡片个数 **/
static const NSInteger visableCount = 3;

/** 卡片边距 **/
static const CGFloat containerEdge = 10.0f;

/** 卡片内边距 **/
static const CGFloat cardEdge =  5.0f;

/** 卡片圆角 **/
static const CGFloat cardCornerRadius = 10.0f;

/** 卡片边缘宽度**/
static const CGFloat cardCornerBorderWidth = 0.45f;

/** 第二张卡片的sx缩放系数 **/
static const CGFloat secondCardSxScale = 0.95f;

/** 第三张卡片sx缩放系数 **/
static const CGFloat thirdCardSxScale = 0.9f;

/** 物理屏幕宽度 **/
#define screenWidth UIApplication.sharedApplication.keyWindow.bounds.size.width

/** 物理屏幕高度 **/
#define screenHeight UIApplication.sharedApplication.keyWindow.bounds.size.height


#endif /* YFLDragCardConfigure_h */
