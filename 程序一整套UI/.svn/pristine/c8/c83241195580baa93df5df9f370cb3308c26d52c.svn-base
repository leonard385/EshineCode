//
//  MMTrainOffdetailItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainOffdetailItem.h"

@implementation MMTrainOffdetailItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self TOSetUpSubviews];
    }
    return self;
}

-(void)TOSetUpSubviews{
    [self.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.imageView.layer.cornerRadius = 21.0f;
    self.imageView.layer.masksToBounds = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentW = self.frame.size.width;

    CGFloat imageW = 42.0f;
    CGFloat imageH = imageW;
    CGFloat imageX = (contentW - imageW) / 2;
    CGFloat imageY = 2.0f;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    CGFloat lableW = contentW;
    CGFloat lableH = 13.0f;
    CGFloat lableX = 0.0f;
    CGFloat lableY = CGRectGetMaxY(self.imageView.frame) + 4.0f;
    self.titleLabel.frame =  CGRectMake(lableX, lableY, lableW, lableH);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
