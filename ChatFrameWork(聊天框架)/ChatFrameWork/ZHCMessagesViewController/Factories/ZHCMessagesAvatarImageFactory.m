//
//  ZHCMessagesAvatarImageFactory.m
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesAvatarImageFactory.h"
#import "UIColor+ZHCMessages.h"
#import "ZHCMessagesCommonParameter.h"
#import "ZHCMessagesTableViewCell.h"


@interface ZHCMessagesAvatarImageFactory ()

@property (assign, nonatomic, readonly) NSUInteger diameter;

@end
@implementation ZHCMessagesAvatarImageFactory

#pragma mark - Initialization

- (instancetype)init
{
    return [self initWithDiameter:kZHCMessagesTableViewCellAvatarSizeDefault];
}

- (instancetype)initWithDiameter:(NSUInteger)diameter
{
    NSParameterAssert(diameter > 0);
    
    self = [super init];
    if (self) {
        _diameter = diameter;
    }
    
    return self;
}


#pragma mark - Public

- (ZHCMessagesAvatarImage *)avatarImageWithPlaceholder:(UIImage *)placeholderImage
{
    UIImage *circlePlaceholderImage = [self zhc_circularImage:placeholderImage
                                         withHighlightedColor:nil];
    
    return [ZHCMessagesAvatarImage avatarImageWithPlaceholder:circlePlaceholderImage];
}

- (ZHCMessagesAvatarImage *)avatarImageWithImage:(UIImage *)image
{
    UIImage *avatar = [self circularAvatarImage:image];
    UIImage *highlightedAvatar = [self circularAvatarHighlightedImage:image];
    
    return [[ZHCMessagesAvatarImage alloc] initWithAvatarImage:avatar
                                              highlightedImage:highlightedAvatar
                                              placeholderImage:avatar];
}

- (UIImage *)circularAvatarImage:(UIImage *)image
{
    return [self zhc_circularImage:image
              withHighlightedColor:nil];
}

- (UIImage *)circularAvatarHighlightedImage:(UIImage *)image
{
    return [self zhc_circularImage:image
              withHighlightedColor:[UIColor colorWithWhite:0.1f alpha:0.3f]];
}

-(ZHCMessagesAvatarImage *)avatarImageWithUserInitials:(NSString *)userInitials backgroundColor:(UIColor *)backgroundColor textColor:(UIColor *)textColor font:(UIFont *)font
{
    UIImage *avatarImage = [self zhc_imageWithInitials:userInitials
                                       backgroundColor:backgroundColor
                                             textColor:textColor
                                                  font:font];
    
    UIImage *avatarHighlightedImage = [self zhc_circularImage:avatarImage
                                         withHighlightedColor:[UIColor colorWithWhite:0.1f alpha:0.3f]];
    
    return [[ZHCMessagesAvatarImage alloc] initWithAvatarImage:avatarImage
                                              highlightedImage:avatarHighlightedImage
                                              placeholderImage:avatarImage];

}

- (UIImage *)zhc_imageWithInitials:(NSString *)initials
                   backgroundColor:(UIColor *)backgroundColor
                         textColor:(UIColor *)textColor
                              font:(UIFont *)font
{
    NSParameterAssert(initials != nil);
    NSParameterAssert(backgroundColor != nil);
    NSParameterAssert(textColor != nil);
    NSParameterAssert(font != nil);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, self.diameter, self.diameter);
    
    NSDictionary *attributes = @{ NSFontAttributeName : font,
                                  NSForegroundColorAttributeName : textColor };
    
    CGRect textFrame = [initials boundingRectWithSize:frame.size
                                              options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                           attributes:attributes
                                              context:nil];
    
    CGPoint frameMidPoint = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGPoint textFrameMidPoint = CGPointMake(CGRectGetMidX(textFrame), CGRectGetMidY(textFrame));
    
    CGFloat dx = frameMidPoint.x - textFrameMidPoint.x;
    CGFloat dy = frameMidPoint.y - textFrameMidPoint.y;
    CGPoint drawPoint = CGPointMake(dx, dy);
    UIImage *image = nil;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillRect(context, frame);
        [initials drawAtPoint:drawPoint withAttributes:attributes];
        
        image = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    UIGraphicsEndImageContext();
    
    return [self zhc_circularImage:image withHighlightedColor:nil];
}


#pragma mark - Private
- (UIImage *)zhc_circularImage:(UIImage *)image withHighlightedColor:(UIColor *)highlightedColor
{
    NSParameterAssert(image != nil);
    
    CGRect frame = CGRectMake(0.0f, 0.0f, self.diameter, self.diameter);
    UIImage *newImage = nil;
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, [UIScreen mainScreen].scale);
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        UIBezierPath *imgPath = [UIBezierPath bezierPathWithOvalInRect:frame];
        [imgPath addClip];
        [image drawInRect:frame];
        
        if (highlightedColor != nil) {
            CGContextSetFillColorWithColor(context, highlightedColor.CGColor);
            CGContextFillEllipseInRect(context, frame);
        }
        
        newImage = UIGraphicsGetImageFromCurrentImageContext();
        
    }
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
