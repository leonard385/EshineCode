//
//  MMEmployMannagerBtnItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/15.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployMannagerBtnItem.h"

@implementation MMEmployMannagerBtnItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat ImgX = 15.0f;
    CGFloat ImgY = 10.0f;
    self.imageView.frame = CGRectMake(ImgX, ImgY, 25.0f, 25.0f);
    CGFloat lableX = CGRectGetMaxX(self.imageView.frame) + 7.0f;
    CGFloat lableW = self.width - lableX;
    
    self.titleLabel.frame = CGRectMake(lableX, 0, lableW, self.height);
}

@end
