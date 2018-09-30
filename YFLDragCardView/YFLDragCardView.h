//
//  YFLDragCardBaseView.h
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YFLDragConfigure.h"
@interface YFLDragCardView : UIView


@property (nonatomic,assign) CGAffineTransform originTransForm;


@property (nonatomic,strong) YFLDragConfigure *configure;

/**
 布局子视图，其子类重写，并在其进行布局
 */
- (void)YFLDragCardViewLayoutSubviews;


/**
 执行卡片上动画(喜欢、不喜欢)
 */
- (void)startAnimatingForDirection:(ContainerDragDirection)direction;


@end
