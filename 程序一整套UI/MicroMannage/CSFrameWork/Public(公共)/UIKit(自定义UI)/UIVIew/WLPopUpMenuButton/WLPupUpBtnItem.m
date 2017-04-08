//
//  WLPupUpBtnItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/25.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "WLPupUpBtnItem.h"
@interface WLPupUpBtnItem()

@end
@implementation WLPupUpBtnItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self PUSetUpSubviews];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self PUSetUpSubviews];
    }
    return self;
}

-(void)PUSetUpSubviews{
    self.imageView.layer.cornerRadius = 20.5f;
    self.imageView.layer.borderWidth = 0.5f;
    self.imageView.layer.borderColor = HEXCOLOR(0xe3e3e3).CGColor;
    self.imageView.layer.shadowRadius = 4.0f;
    self.imageView.layer.shadowOpacity = 0.5f;
    self.imageView.layer.shadowColor = HEXCOLOR(0xe3e3e3).CGColor;
    
    self.titleLabel.layer.cornerRadius = 2.5f;
    self.titleLabel.layer.borderWidth = 0.5f;
    self.titleLabel.layer.borderColor = HEXCOLOR(0xe3e3e3).CGColor;
    self.titleLabel.layer.shadowRadius = 4.0f;
    self.titleLabel.layer.shadowOpacity = 0.5f;
    self.titleLabel.layer.shadowColor = HEXCOLOR(0xe3e3e3).CGColor;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat contentW = self.frame.size.width;
    CGFloat contentH = self.frame.size.height;
    
    
    CGFloat imageW = 41.0f;
    CGFloat imageH = 41.0f;
    CGFloat imageX = contentW - 9.0f - imageW;
    CGFloat imageY = (contentH - imageH) / 2;
    
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    CGFloat titleLableX = 9.0f;
    CGFloat titleLableY = 10.5f;
    CGFloat titleLableW = CGRectGetMinX(self.imageView.frame) - 13.0f - titleLableX;
    CGFloat titleLableH = contentH - titleLableY * 2.0f;
    
    self.titleLabel.frame = CGRectMake(titleLableX, titleLableY, titleLableW, titleLableH);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
