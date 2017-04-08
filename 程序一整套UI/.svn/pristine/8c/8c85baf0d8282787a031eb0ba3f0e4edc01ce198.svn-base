//
//  MMHomeFuncBtnItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/8.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMHomeFuncBtnItem.h"
@interface MMHomeFuncBtnItem()
@property(nonatomic,strong)UIImageView *iconNew;
@property(nonatomic,assign)CGSize iconSize;
@end

@implementation MMHomeFuncBtnItem

-(UIImageView *)iconNew{
    if(_iconNew == nil){
        _iconNew = [UIImageView new];
        _iconNew.image = [UIImage imageNamed:@"xinrenwu"];
    }
    return _iconNew;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self FBsetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         [self FBsetUpSubviews];
    }
    return self;
}

#pragma mark - 设置子视图
-(void)FBsetUpSubviews{
    _iconSize = CGSizeMake(0, 0);
    [self addSubview:self.iconNew];
}

-(void)setHasTask:(BOOL)hasTask{
    if(_hasTask == hasTask){
        return;
    }else{
    _hasTask = hasTask;
    if(hasTask){
        _iconSize =  CGSizeMake(29.0f, 14.0f);
    }else{
        _iconSize =  CGSizeMake(0.0f, 0.0f);
    }
    [self setNeedsLayout];
    [UIView animateWithDuration:0.2 delay:0.0f usingSpringWithDamping:0.7 initialSpringVelocity:10.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
        
    } completion:nil];
    }
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
    
    
    CGFloat imageH = 46.0f;
    CGFloat imageW = 46.0f;
    CGFloat imageX = (self.width - imageH)/2;
    CGFloat imageY = 13.0f;
    self.imageView.frame = CGRectMake(imageX,imageY,imageW,imageH);
    self.imageView.contentMode = UIViewContentModeScaleToFill;
    
    CGFloat iconW = _iconSize.width;
    CGFloat iconH = _iconSize.height;
    CGFloat iconX = CGRectGetMaxX(self.imageView.frame) - 29.0f/2.0f;
    CGFloat iconY = imageY - 14.0f / 2.0f;
    _iconNew.frame = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    CGFloat  lableY = CGRectGetMaxY(self.imageView.frame) + 7.0f;
    CGFloat  lableH = self.height - lableY;
    self.titleLabel.frame  = CGRectMake(0, lableY, self.width, lableH);
}

@end
