//
//  CardView.m
//  YFLDragCardViewProject
//
//  Created by Cherish on 2018/9/18.
//  Copyright © 2018年 Cherish. All rights reserved.
//

#import "CardView.h"

@interface CardView()

@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UILabel *title;

@end

@implementation CardView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
      
        [self setUp];
        
    }
    
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.layer.cornerRadius = 4.0f;
    self.imageView.layer.masksToBounds = YES;
    [self addSubview:self.imageView];
    
    self.title = [[UILabel alloc]init];
    self.title.textColor = [UIColor blackColor];
    self.title.backgroundColor = [UIColor whiteColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.font = [UIFont boldSystemFontOfSize:18.0f];
    [self addSubview:self.title];
}

- (void)YFLDragCardViewLayoutSubviews
{
    self.imageView.frame = CGRectMake(5, 5, self.frame.size.width-10, self.frame.size.height-50);
    self.title.frame = CGRectMake(0,self.imageView.frame.size.height+5, self.frame.size.width, 30);
}

- (void)setImage:(NSString*)imageName title:(NSString*)title
{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.title.text = title;
    
}



@end
