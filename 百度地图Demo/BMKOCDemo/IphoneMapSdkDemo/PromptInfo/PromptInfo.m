//
//  PromptInfo.m
//  KTVCommunity
//
//  Created by mac on 12-11-13.
//  Copyright (c) 2012年 ThunderStone. All rights reserved.
//

#import "PromptInfo.h"
#define DEFAULT_DISPLAY_DURATION 0.3

@interface PromptInfo(Private) 

-(id)initWithText:(NSString *)text;  
-(void)setDuration:(CGFloat) duration;  

-(void)dismisToast;  
-(void)toastTaped:(UIButton *)sender;  

-(void)showAnimation;  
-(void)hideAnimation;  

-(void)show;  
-(void)showFromTopOffset:(CGFloat) topOffset;  
-(void)showFromBottomOffset:(CGFloat) bottomOffset;  

@end  

@implementation PromptInfo
static PromptInfo *toast=nil;

- (void)dealloc{  
    [[NSNotificationCenter defaultCenter] removeObserver:self  
                                                    name:UIDeviceOrientationDidChangeNotification  
                                                  object:[UIDevice currentDevice]];  
    [contentView release],contentView = nil;  
    [text release],text = nil; 
  //  [toast release];
    [super dealloc];      
}  

//弹窗
- (id)initWithText:(NSString *)text_ firstIn:(BOOL) a{
 if (a) {

    if (self = [super init]) {  
        
        text = [text_ copy];  
        
        UIFont *font = [UIFont boldSystemFontOfSize:15];  
        CGSize textSize = [text sizeWithFont:font  
                           constrainedToSize:CGSizeMake(280, MAXFLOAT)  
                               lineBreakMode:NSLineBreakByWordWrapping];
        
        textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, textSize.width + 12, textSize.height + 12)];  //UILabel *
        textLabel.backgroundColor = [UIColor clearColor];  
        textLabel.textColor = [UIColor whiteColor];  
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.font = font;  
        textLabel.text = text;  
        textLabel.numberOfLines = 0;  
        
        contentView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, textLabel.frame.size.width+20, textLabel.frame.size.height+20)];  
        contentView.layer.cornerRadius = 5.0f;  
        contentView.layer.borderWidth = 1.0f;  
        contentView.layer.borderColor = [[UIColor grayColor] colorWithAlphaComponent:0.5].CGColor;  
        //contentView.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f  blue:0.2f alpha:0.75f];  
        
        contentView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [contentView addSubview:textLabel];  
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;  
        [contentView addTarget:self  
                        action:@selector(toastTaped:)  
              forControlEvents:UIControlEventTouchDown];  
        contentView.alpha = 0.0f;  
        [textLabel release];  
        duration = DEFAULT_DISPLAY_DURATION;  
        [[NSNotificationCenter defaultCenter] addObserver:self  
                                                 selector:@selector(deviceOrientationDidChanged:)  
                                                     name:UIDeviceOrientationDidChangeNotification  
                                                   object:[UIDevice currentDevice]];  
    }  
    return self;  
     
 }
 else //add
 {
     text = [text_ copy];  
     
     UIFont *font = [UIFont boldSystemFontOfSize:15];  
     CGSize textSize = [text sizeWithFont:font  
                        constrainedToSize:CGSizeMake(280, MAXFLOAT)  
                            lineBreakMode:NSLineBreakByWordWrapping];
     
 
     textLabel.frame=CGRectMake(10, 10, textSize.width + 12, textSize.height + 12);
     textLabel.font = font;  
     textLabel.text = text;  
     textLabel.numberOfLines = 0;  
     
     //contentView.backgroundColor = [UIColor colorWithRed:0.2f green:0.2f  blue:0.2f alpha:0.75f];  
     
     contentView.frame=CGRectMake(0, 0, textLabel.frame.size.width+20, textLabel.frame.size.height+20); 
//     [contentView addSubview:textLabel];  
//     contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;  
//     [contentView addTarget:self  
//                     action:@selector(toastTaped:)  
//           forControlEvents:UIControlEventTouchDown];  
//     contentView.alpha = 0.0f;  
//     [textLabel release];  
     duration = DEFAULT_DISPLAY_DURATION;
     return nil;
 }
}  

- (void)deviceOrientationDidChanged:(NSNotification *)notify_{  
    [self hideAnimation];  
}  

-(void)dismissToast{  
    [contentView removeFromSuperview];  
}  

-(void)toastTaped:(UIButton *)sender_{  
    [self hideAnimation];  
}  

- (void)setDuration:(CGFloat) duration_{  
    duration = duration_;  
}  

-(void)showAnimation{  
    [UIView beginAnimations:@"show" context:NULL];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];  
    [UIView setAnimationDuration:0.5];  
    contentView.alpha = 1.0f;  
    [UIView commitAnimations];  
}  

-(void)hideAnimation{  
    [UIView beginAnimations:@"hide" context:NULL];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];  
    [UIView setAnimationDelegate:self];  
    [UIView setAnimationDidStopSelector:@selector(dismissToast)];  
    [UIView setAnimationDuration:2.0];  
    contentView.alpha = 0.0f;  
    [UIView commitAnimations];  
}  

- (void)show{  
    UIWindow *window = [UIApplication sharedApplication].keyWindow;  
    contentView.center = window.center;  
    [window  addSubview:contentView];  
    [self showAnimation];  
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];  
}  

- (void)showFromTopOffset:(CGFloat) top_{  
    UIWindow *window = [UIApplication sharedApplication].keyWindow;  
    contentView.center = CGPointMake(window.center.x, top_ + contentView.frame.size.height/2);  
    [window  addSubview:contentView];  
    [self showAnimation];  
    //NSLog(@"duration=%f",duration);
    [self performSelectorOnMainThread:@selector(goHideAnimation) withObject:nil waitUntilDone:NO];
}  

- (void)showFromBottomOffset:(CGFloat) bottom_{  
    UIWindow *window = [UIApplication sharedApplication].keyWindow;      
    contentView.center = CGPointMake(window.center.x, window.frame.size.height-(bottom_ + contentView.frame.size.height/2));  
    [window  addSubview:contentView];  
    [self showAnimation];  
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];  
}  

- (void)goHideAnimation
{
    [self performSelector:@selector(hideAnimation) withObject:nil afterDelay:duration];  
}

+ (void)showWithText:(NSString *)text_{  
    [PromptInfo showWithText:text_ duration:DEFAULT_DISPLAY_DURATION];  
}  

+ (void)showWithText:(NSString *)text_  
            duration:(CGFloat)duration_{  
    PromptInfo *toast = [[[PromptInfo alloc] initWithText:text_] autorelease];  
    [toast setDuration:duration_];  
    [toast show];  
}  

+ (void)showWithText:(NSString *)text_  
           topOffset:(CGFloat)topOffset_{  
    [PromptInfo showWithText:text_  topOffset:topOffset_ duration:DEFAULT_DISPLAY_DURATION];  
}  
//初始化弹窗
+ (void)showWithText:(NSString *)text_  
           topOffset:(CGFloat)topOffset_  
            duration:(CGFloat)duration_{
    
//    NSLog(@"PromptInfo:%@", text_);
    //  PromptInfo *toast = [[[PromptInfo alloc] initWithText:text_] autorelease];
    @synchronized(self)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (toast==nil)
            {
                BOOL firstIn=YES;
                toast=[[PromptInfo alloc] initWithText:text_ firstIn:firstIn];
            }
            else
            {
                BOOL firstIn=NO;
                [toast initWithText:text_ firstIn:firstIn];
            }
            [toast setDuration:duration_];
            [toast showFromTopOffset:topOffset_];
        });
    }
}

+ (void)showText:(NSString*)text_
{
    [PromptInfo showWithText:text_ topOffset:200 duration:1.4];
}

@end
