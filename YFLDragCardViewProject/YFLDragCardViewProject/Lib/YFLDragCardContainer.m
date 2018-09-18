//
//  YFLDragCardContainer.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "YFLDragCardContainer.h"

@implementation YFLDragCardContainer

#pragma mark - Init Methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUp];
        
    }
    
    return self;
}

#pragma mark - Private Methods
- (void)setUp
{
    
}


#pragma mark - Public Methods
- (void)reloadData
{
    
}

- (void)removeCardViewForDirection:(ContainerDragDirection)direction
{
    
}

- (YFLDragCardView *)getCurrentShowCardView
{
    return nil;
}

- (NSInteger)getCurrentShowCardViewIndex
{
    return 0;
}

@end
