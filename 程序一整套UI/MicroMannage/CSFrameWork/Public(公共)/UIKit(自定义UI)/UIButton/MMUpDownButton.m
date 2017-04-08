//
//  MMUpDownButton.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMUpDownButton.h"

@implementation MMUpDownButton
-(instancetype)init{
    self = [super init];
    if(self){
        [self UDSetUpSubviews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UDSetUpSubviews];
    }
    return self;
}

-(void)UDSetUpSubviews{
    [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.imageView setContentMode:UIViewContentModeCenter];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat ImgW = self.frame.size.width;
    CGFloat ImgH = self.frame.size.height/2;
    self.imageView.frame = CGRectMake(0, 0,ImgW, ImgH);
    CGFloat Orginy = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.frame = CGRectMake(0, Orginy, ImgW, ImgH);
}
@end
