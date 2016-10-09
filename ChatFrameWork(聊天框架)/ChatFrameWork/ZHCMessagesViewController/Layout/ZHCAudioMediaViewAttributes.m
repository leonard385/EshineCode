//
//  ZHCAudioMediaViewAttributes.m
//  ZHChat
//
//  Created by aimoke on 16/8/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCAudioMediaViewAttributes.h"
#import "UIImage+ZHCMessages.h"
#import "UIColor+ZHCMessages.h"


@implementation ZHCAudioMediaViewAttributes

-(instancetype)initWithPlayButtonImage:(UIImage *)playButtonImage pauseButtonImage:(UIImage *)pauseButtonImage labelFont:(UIFont *)labelFont showFractionalSecodns:(BOOL)showFractionalSeconds backgroundColor:(UIColor *)backgroundColor tintColor:(UIColor *)tintColor controlInsets:(UIEdgeInsets)controlInsets controlPadding:(CGFloat)controlPadding audioCategory:(NSString *)audioCategory audioCategoryOptions:(AVAudioSessionCategoryOptions)audioCategoryOptions
{
    NSParameterAssert(playButtonImage != nil);
    NSParameterAssert(pauseButtonImage != nil);
    NSParameterAssert(labelFont != nil);
    NSParameterAssert(backgroundColor != nil);
    NSParameterAssert(tintColor != nil);
    NSParameterAssert(audioCategory != nil);
    
    self = [super init];
    if (self) {
        _playButtonImage = playButtonImage;
        _pauseButtonImage = pauseButtonImage;
        _labelFont = labelFont;
        _showFractionalSeconds = showFractionalSeconds;
        _backgroundColor = backgroundColor;
        _tintColor = tintColor;
        _controlInsets = controlInsets;
        _controlPadding = controlPadding;
        _audioCategory = audioCategory;
        _audioCategoryOptions = audioCategoryOptions;
    }
    return self;

}


- (instancetype)init
{
    UIColor *tintColor = [UIColor zhc_messagesBubbleBlueColor];
    AVAudioSessionCategoryOptions options = AVAudioSessionCategoryOptionDuckOthers
    | AVAudioSessionCategoryOptionDefaultToSpeaker
    | AVAudioSessionCategoryOptionAllowBluetooth;
    
    return [self initWithPlayButtonImage:[[UIImage zhc_defaultPlayImage] zhc_imageMaskedWithColor:tintColor]
                        pauseButtonImage:[[UIImage zhc_defaultPauseImage] zhc_imageMaskedWithColor:tintColor]
                               labelFont:[UIFont systemFontOfSize:12]
                   showFractionalSecodns:NO
                         backgroundColor:[UIColor zhc_messagesBubbleLightGrayColor]
                               tintColor:tintColor
                           controlInsets:UIEdgeInsetsMake(6, 6, 6, 18)
                          controlPadding:6
                           audioCategory:@"AVAudioSessionCategoryPlayback"
                    audioCategoryOptions:options];
}


- (void)setPlayButtonImage:(UIImage *)playButtonImage
{
    NSParameterAssert(playButtonImage != nil);
    _playButtonImage = playButtonImage;
}

- (void)setPauseButtonImage:(UIImage *)pauseButtonImage
{
    NSParameterAssert(pauseButtonImage != nil);
    _pauseButtonImage = pauseButtonImage;
}

- (void)setLabelFont:(UIFont *)labelFont
{
    NSParameterAssert(labelFont != nil);
    _labelFont = labelFont;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    NSParameterAssert(backgroundColor != nil);
    _backgroundColor = backgroundColor;
}

- (void)setTintColor:(UIColor *)tintColor
{
    NSParameterAssert(tintColor != nil);
    _tintColor = tintColor;
}

- (void)setAudioCategory:(NSString *)audioCategory
{
    NSParameterAssert(audioCategory != nil);
    _audioCategory = audioCategory;
}


@end
