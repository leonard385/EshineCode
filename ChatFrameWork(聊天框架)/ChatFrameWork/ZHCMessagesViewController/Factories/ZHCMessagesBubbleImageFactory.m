//
//  ZHCMessagesBubleImageFactory.m
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesBubbleImageFactory.h"
#import "UIImage+ZHCMessages.h"
#import "UIColor+ZHCMessages.h"
#import "ZHCMessagesBubbleImage.h"

@interface ZHCMessagesBubbleImageFactory ()

@property (strong, nonatomic, readonly) UIImage *bubbleImage;

@property (assign, nonatomic, readonly) UIEdgeInsets capInsets;

@property (assign, nonatomic, readonly) BOOL isRightToLeftLanguage;
@end

@implementation ZHCMessagesBubbleImageFactory

#pragma mark - Initialization
-(instancetype)initWithBubbleImage:(UIImage *)bubbleImage capInsets:(UIEdgeInsets)capInsets layoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection
{
    NSParameterAssert(bubbleImage != nil);
    self = [super init];
    if (self) {
        _bubbleImage = bubbleImage;
        _capInsets = capInsets;
        _layOutDirection = layoutDirection;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, capInsets)) {
        _capInsets = [self zhc_centerPointEdgeInsetsForImageSize:bubbleImage.size];
    }
    return self;
}

- (instancetype)init
{
    return [self initWithBubbleImage:[UIImage zhc_getBubbleCommpactImage]
                           capInsets:UIEdgeInsetsZero
                     layoutDirection:[UIApplication sharedApplication].userInterfaceLayoutDirection];
}


#pragma mark Public
-(ZHCMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color
{
    return [self zhc_messagesBubbleImageWithColor:color flippedForIncoming:NO ^ self.isRightToLeftLanguage];
}


-(ZHCMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color
{
    return [self zhc_messagesBubbleImageWithColor:color flippedForIncoming:YES ^ self.isRightToLeftLanguage];
}

#pragma mark - Private
- (BOOL)isRightToLeftLanguage
{
    return (self.layOutDirection == UIUserInterfaceLayoutDirectionRightToLeft);
}


-(UIEdgeInsets)zhc_centerPointEdgeInsetsForImageSize:(CGSize)imageSize
{
    CGPoint center = CGPointMake(imageSize.width/2.0, imageSize.height/2.0);
    return UIEdgeInsetsMake(center.y, center.x, center.y, center.x);
}


-(ZHCMessagesBubbleImage *)zhc_messagesBubbleImageWithColor:(UIColor *)color flippedForIncoming:(BOOL)flippedForIncoming
{
    NSParameterAssert(color != nil);
    UIImage *nolmalBubble = [self.bubbleImage zhc_imageMaskedWithColor:color];
    UIImage *hightlighttBubble = [self.bubbleImage zhc_imageMaskedWithColor:[color zhc_colorByDarkeningColorWithValue:0.12]];
    if (flippedForIncoming) {
        nolmalBubble = [self zhc_horizontallyFlippedImageFromImage:nolmalBubble];
        hightlighttBubble = [self zhc_horizontallyFlippedImageFromImage:hightlighttBubble];
    }
    nolmalBubble = [self zhc_stretchableImageFromImage:nolmalBubble withCapInsets:self.capInsets];
    hightlighttBubble = [self zhc_stretchableImageFromImage:hightlighttBubble withCapInsets:self.capInsets];
    return [[ZHCMessagesBubbleImage alloc]initWithMessageBubbleImage:nolmalBubble highlightedImage:hightlighttBubble];
}


- (UIImage *)zhc_horizontallyFlippedImageFromImage:(UIImage *)image
{
    return [UIImage imageWithCGImage:image.CGImage
                               scale:image.scale
                         orientation:UIImageOrientationUpMirrored];
}

- (UIImage *)zhc_stretchableImageFromImage:(UIImage *)image withCapInsets:(UIEdgeInsets)capInsets
{
    return [image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}


@end
