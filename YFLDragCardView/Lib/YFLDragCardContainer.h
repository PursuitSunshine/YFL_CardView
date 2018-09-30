//
//  YFLDragCardContainer.h
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFLDragCardView.h"
@class YFLDragCardContainer;

@protocol YFLDragCardContainerDataSource <NSObject>

@required

/** 数据源个数 **/
- (NSInteger)numberOfRowsInYFLDragCardContainer:(YFLDragCardContainer *)container;

/** 显示数据源 **/
- (YFLDragCardView *)container:(YFLDragCardContainer *)container viewForRowsAtIndex:(NSInteger)index;

@end

@protocol YFLDragCardContainerDelegate <NSObject>

@optional

/** 点击卡片回调 **/
- (void)container:(YFLDragCardContainer *)container didSelectRowAtIndex:(NSInteger)index;

/** 拖到最后一张卡片 YES，空，可继续调用reloadData分页数据**/
- (void)container:(YFLDragCardContainer *)container dataSourceIsEmpty:(BOOL)isEmpty;

/**  当前cardview 是否可以拖拽，默认YES **/
- (BOOL)container:(YFLDragCardContainer *)container canDragForCardView:(YFLDragCardView *)cardView;

/** 卡片处于拖拽中回调**/
- (void)container:(YFLDragCardContainer *)container dargingForCardView:(YFLDragCardView *)cardView direction:(ContainerDragDirection)direction widthRate:(float)widthRate  heightRate:(float)heightRate;

/** 卡片拖拽结束回调（卡片消失） **/
- (void)container:(YFLDragCardContainer *)container dragDidFinshForDirection:(ContainerDragDirection)direction forCardView:(YFLDragCardView *)cardView;

@end


@interface YFLDragCardContainer : UIView


/** 初始化方法 **/
- (instancetype)initWithFrame:(CGRect)frame configure:(YFLDragConfigure*)configure;

/** 默认初始化方法 **/
- (instancetype)initWithFrame:(CGRect)frame;

/** 数据源代理 **/
@property (nonatomic, weak, nullable) id <YFLDragCardContainerDataSource> dataSource;

/**  动作代理 **/
@property (nonatomic, weak, nullable) id <YFLDragCardContainerDelegate> delegate;

/** 刷新数据 **/
- (void)reloadData;

/** 主动调用拖拽 **/
- (void)removeCardViewForDirection:(ContainerDragDirection)direction;

/** 获取显示当前卡片 **/
- (YFLDragCardView *)getCurrentShowCardView;

/** 获取显示当前卡片的index **/
- (NSInteger)getCurrentShowCardViewIndex;

@end
