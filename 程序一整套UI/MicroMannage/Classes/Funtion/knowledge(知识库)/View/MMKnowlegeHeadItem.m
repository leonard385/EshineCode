//
//  MMKnowlegeHeadItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/28.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKnowlegeHeadItem.h"

@implementation MMKnowlegeHeadItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat contentW = self.frame.size.width;
    CGFloat contentH = self.frame.size.height;
    CGFloat imageW = 13.0f;
    CGFloat imageH = contentH;
    CGFloat imageX = contentW - 12.0f - imageW;
    CGFloat imageY = 0.0f;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    CGFloat lableX = 12.0f;
    CGFloat lableY = 0.0f;
    CGFloat lableW = CGRectGetMinX(self.imageView.frame) - 8.0f - lableX;
    CGFloat lableH = contentH;
    
    self.titleLabel.frame =  CGRectMake(lableX, lableY, lableW, lableH);
}


@end
