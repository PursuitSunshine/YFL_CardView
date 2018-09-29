//
//  CardView.h
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "YFLDragCardView.h"

@interface CardView : YFLDragCardView

- (void)setAnimationwithDriection:(ContainerDragDirection)direction;

- (void)setImage:(NSString*)imageName title:(NSString*)title;

@end
