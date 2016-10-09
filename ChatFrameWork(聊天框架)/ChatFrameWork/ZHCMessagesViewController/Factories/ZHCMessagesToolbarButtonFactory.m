//
//  ZHCMessagesToolbarButtonFactory.m
//  ZHChat
//
//  Created by aimoke on 16/8/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesToolbarButtonFactory.h"
#import "UIColor+ZHCMessages.h"
#import "UIImage+ZHCMessages.h"
#import "NSBundle+ZHCMessages.h"

@interface ZHCMessagesToolbarButtonFactory ()

@property (strong, nonatomic, readonly) UIFont *buttonFont;

@end

@implementation ZHCMessagesToolbarButtonFactory


- (instancetype)init
{
    return [self initWithFont:[UIFont boldSystemFontOfSize:17.0]];
}

- (instancetype)initWithFont:(UIFont *)font
{
    NSParameterAssert(font != nil);
    
    self = [super init];
    if (self) {
        _buttonFont = font;
    }
    
    return self;
}


-(UIButton *)defaultInputViewBarLeftButtonItem
{
    UIImage *voiceImage = [UIImage zhc_defaultVoiceImage];
    UIImage *keyboardImage = [UIImage zhc_defaultKeyboardImage];
    
    UIButton *voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 34, 32)];
    [voiceButton setImage:voiceImage forState:UIControlStateNormal];
    [voiceButton setImage:keyboardImage forState:UIControlStateSelected];
    voiceButton.contentMode = UIViewContentModeScaleAspectFit;
    voiceButton.backgroundColor = [UIColor clearColor];
    voiceButton.tintColor = [UIColor lightGrayColor];
    voiceButton.titleLabel.font = self.buttonFont;
    
    return voiceButton;
}

-(UIButton *)defaultInputViewBarRightButtonItem
{
    UIImage *moreImage = [UIImage zhc_defaultMoreImage];
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 34, 32)];
    [moreButton setImage:moreImage forState:UIControlStateNormal];
    [moreButton setImage:moreImage forState:UIControlStateSelected];
    moreButton.contentMode = UIViewContentModeScaleAspectFit;
    moreButton.backgroundColor = [UIColor clearColor];
    moreButton.tintColor = [UIColor lightGrayColor];
    moreButton.titleLabel.font = self.buttonFont;
    return moreButton;
}


-(UIButton *)defaultInputViewBarMiddelButtonItem
{
    UIImage *emotionImage = [UIImage zhc_defaultEmotionImage];
    UIImage *keyboardImage = [UIImage zhc_defaultKeyboardImage];
    
    UIButton *emotionButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 34, 32)];
    [emotionButton setBackgroundImage:emotionImage forState:UIControlStateNormal];
    [emotionButton setBackgroundImage:keyboardImage forState:UIControlStateSelected];
    emotionButton.contentMode = UIViewContentModeScaleAspectFit;
    emotionButton.backgroundColor = [UIColor clearColor];
    emotionButton.tintColor = [UIColor lightGrayColor];
    emotionButton.titleLabel.font = self.buttonFont;
    return emotionButton;

}

-(UIButton *)defaultInputViewVoiceLongPressButtonItem
{
    UIImage *normalImage = [UIImage zhc_defaultLongPressVoiceImage];
    UIImage *highlightImage = [UIImage zhc_highlightedPressVoiceImage];
    UIButton *longPressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [longPressButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [longPressButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [longPressButton setTitle:[NSBundle zhc_localizedStringForKey:@"Press_talk"] forState:UIControlStateNormal];
    [longPressButton setTitle:[NSBundle zhc_localizedStringForKey:@"Send_release"] forState:UIControlStateHighlighted];
    [longPressButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [longPressButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    longPressButton.titleLabel.font = self.buttonFont;
    longPressButton.contentMode = UIViewContentModeScaleAspectFill;
    longPressButton.backgroundColor = [UIColor clearColor];
    return longPressButton;
    
}


- (UIButton *)defaultSendButtonItem
{
    NSString *sendTitle = [NSBundle zhc_localizedStringForKey:@"Send"];
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [sendButton setTitle:sendTitle forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor zhc_messagesBubbleBlueColor] forState:UIControlStateNormal];
    [sendButton setTitleColor:[[UIColor zhc_messagesBubbleBlueColor] zhc_colorByDarkeningColorWithValue:0.1f] forState:UIControlStateHighlighted];
    [sendButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    sendButton.titleLabel.font = self.buttonFont;
    sendButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    sendButton.titleLabel.minimumScaleFactor = 0.85f;
    sendButton.contentMode = UIViewContentModeCenter;
    sendButton.backgroundColor = [UIColor clearColor];
    sendButton.tintColor = [UIColor zhc_messagesBubbleBlueColor];
    
    CGFloat maxHeight = 32.0f;
    
    CGRect sendTitleRect = [sendTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, maxHeight)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                attributes:@{ NSFontAttributeName : sendButton.titleLabel.font }
                                                   context:nil];
    
    sendButton.frame = CGRectMake(0.0f,
                                  0.0f,
                                  CGRectGetWidth(CGRectIntegral(sendTitleRect)),
                                  maxHeight);
    
    return sendButton;
}


@end
