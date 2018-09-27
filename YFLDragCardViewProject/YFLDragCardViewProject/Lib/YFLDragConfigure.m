//
//  YFLDragConfigure.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/26.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "YFLDragConfigure.h"

@implementation YFLDragConfigure

- (NSInteger)visableCount
{
    return _visableCount == 0 ? 3 : _visableCount;
}

- (CGFloat)containerEdge
{
    return !(_containerEdge>0) ? 10.0f: _containerEdge;
}

- (CGFloat)cardEdge
{
    return !(_cardEdge>0) ?  10.0f:_cardEdge;
}

- (CGFloat)cardCornerRadius
{
    return !(_cardCornerRadius>0) ?  10.0f:_cardCornerRadius;
}

- (CGFloat)cardCornerBorderWidth
{
    return !(_cardCornerBorderWidth>0) ?  0.45f:_cardCornerBorderWidth;
}

- (UIColor*)cardBordColor
{
    return !_cardBordColor ? [UIColor colorWithRed:176.0f/255.0f green:176.0f/255.0f blue:176.0f/255.0f alpha:1]:_cardBordColor;
}


@end
