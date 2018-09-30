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
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor cyanColor];
}

#pragma mark - Public Method
- (void)setConfigure:(YFLDragConfigure *)configure
{
    _configure = configure;
    self.layer.cornerRadius = configure.cardCornerRadius;
    self.layer.borderWidth = configure.cardCornerBorderWidth;
    self.layer.borderColor = configure.cardBordColor.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)YFLDragCardViewLayoutSubviews
{
}


- (void)startAnimatingForDirection:(ContainerDragDirection)direction
{
    
}




@end
