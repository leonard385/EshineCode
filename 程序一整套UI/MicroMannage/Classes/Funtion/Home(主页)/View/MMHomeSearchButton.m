//
//  MMHomeSearchButton.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/8.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMHomeSearchButton.h"

@implementation MMHomeSearchButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15.0, 0,13.0f, self.height);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat  lableX = CGRectGetMaxX(self.imageView.frame) + 7.0f;
    CGFloat  lableW = self.width - lableX - 7.0f;
    self.titleLabel.frame  = CGRectMake(lableX, 0, lableW, self.height);
}

@end
