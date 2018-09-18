//
//  YFLDragCardBaseView.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "YFLDragCardView.h"

@interface YFLDragCardView()

@property (nonatomic,strong) UIImageView *like;

@property (nonatomic,strong) UIImageView *dislike;

@end

@implementation YFLDragCardView

#pragma mark - Init Method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setUp];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setUp];
}

#pragma mark - Private Method
- (void)setUp
{
    //为了添加手势
    self.userInteractionEnabled = YES;
    self.layer.cornerRadius = cardCornerRadius;
    self.layer.borderWidth = cardCornerBorderWidth;
    CGFloat colorRate = 176.0f/255.0f;
    self.layer.borderColor = [UIColor colorWithRed:colorRate green:colorRate blue:colorRate alpha:1].CGColor;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = [UIColor redColor];
}

#pragma mark - Public Method
- (void)YFLDragCardViewLayoutSubviews
{
    
}


- (void)startAnimatingForDirection:(ContainerDragDirection)direction
{
    
    
}



@end
