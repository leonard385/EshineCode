//
//  UIButton+BBTButton.m
//  bangbangtang
//
//  Created by guoyun3 on 16/5/9.
//  Copyright © 2016年 guoyun3. All rights reserved.
//

#import "UIButton+BBTButton.h"

@implementation UIButton(BBTButton)
-(void)layoutButtonForTitle:(NSString *)title
                  titleFont:(UIFont *)titleFont
                      image:(UIImage *)image
                 gapBetween:(CGFloat)gap
                    layType:(NSInteger)layType
{
    switch (layType) {
        case 0:
        {
            //title---left ,image---right
            [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            CGFloat image_width = image.size.width;
            
            NSDictionary *attribute = @{NSFontAttributeName:titleFont};
            
            CGSize titleSize = [title boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
            
            CGFloat title_origin_x = (self.frame.size.width-image_width-gap-titleSize.width)/2 - image_width;
            CGFloat image_origin_x = title_origin_x + gap + titleSize.width+image_width;
            
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,title_origin_x,0,0)];
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,0,0,-image_origin_x-3)];
        }
            break;
        case 1:
        {
            //title---right ,image---left
            [self setImageEdgeInsets:UIEdgeInsetsMake(0,-gap/2,0,0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(0,gap/2+10,0,0)];
            
        }
            break;
        case 2:
        {
            //title---down ,image---up
            NSDictionary *attribute = @{NSFontAttributeName:titleFont};
            
            CGSize titleSize = [title boundingRectWithSize:CGSizeMake(self.frame.size.width,MAXFLOAT)
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
            CGFloat title_origin_x = -image.size.width/2;
            CGFloat image_origin_x = titleSize.width/2;
            CGFloat image_origin_y = - (titleSize.height+gap)/2;
            CGFloat title_origin_y = (image.size.height+gap)/2;
            [self setImageEdgeInsets:UIEdgeInsetsMake(image_origin_y,image_origin_x,-image_origin_y,-image_origin_x)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(title_origin_y,title_origin_x,-title_origin_y,-title_origin_x)];
            
        }
            break;
        default:
            break;
    }
    
}

- (void)layoutButtonWithEdgeInsetsStyle:(UKButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space
{
    /**
     *  前置知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (style) {
        case UKButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case UKButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case UKButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case UKButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color{
    
    // 倒计时时间
    __block NSInteger timeOut = timeLine;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
                
            });
            
        }else{
            
            int seconds = timeOut % 60;
            NSString * timeStr = [NSString stringWithFormat:@"%0.2d",seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            
            timeOut--;
        }
    });
    
    dispatch_resume(_timer);
}
@end
