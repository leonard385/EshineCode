//
//  ZHCMessagesAudioProgressHUD.m
//  ZHChat
//
//  Created by aimoke on 16/8/30.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesAudioProgressHUD.h"
#import "UIImage+ZHCMessages.h"
#import "NSString+ZHCMessages.h"
#import "NSBundle+ZHCMessages.h"
#import "ZHCMessagesCommonParameter.h"

@interface ZHCMessagesAudioProgressHUD()
@property (assign, nonatomic) CGFloat angle;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) UIImageView *edgeImageView;
@property (strong, nonatomic) UILabel *centerLabel;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *subTitleLabel;
@property (assign, nonatomic) ZHCAudioProgressState progressState;
@property (assign, nonatomic) NSTimeInterval seconds;

@property (nonatomic, strong, readonly) UIWindow *overlayWindow;

@end
@implementation ZHCMessagesAudioProgressHUD
@synthesize overlayWindow = _overlayWindow;


#pragma mark - View Life
-(instancetype) initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        self.contentMode = UIViewContentModeCenter;
        self.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin
								| UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        [self initialSubViews];
    }
    return self;
}

#pragma mark - Private Methods
-(void)initialSubViews
{
    [self addSubview:self.edgeImageView];
    [self addSubview:self.centerLabel];
    [self addSubview:self.subTitleLabel];
    [self addSubview:self.titleLabel];
    
}

- (void)show {
    self.angle = 0.0f;
    self.seconds = 0;
    self.subTitleLabel.text = [NSBundle zhc_localizedStringForKey:@"Slipe_Up_CancelRecording"];
    self.centerLabel.text = @"60";
    self.titleLabel.text = [NSBundle zhc_localizedStringForKey:@"Recording_Time"];
    [self timer];
    ZHCWeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!weakSelf.superview)
            [weakSelf.overlayWindow addSubview:self];
        [UIView animateWithDuration:.5 animations:^{
            weakSelf.alpha = 1;
        } completion:nil];
        [weakSelf setNeedsDisplay];
    });
}


- (void)timerAction {
    self.angle -= 3;
    self.seconds ++ ;
    float second = [self.centerLabel.text floatValue];
    if (second<=0.0f) {
        [self dismiss];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.09];
    UIView.AnimationRepeatAutoreverses = YES;
    self.edgeImageView.transform = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    if (second <= 10.0f) {
        self.centerLabel.textColor = [UIColor redColor];
    } else {
        self.centerLabel.textColor = [UIColor yellowColor];
    }
    self.centerLabel.text = [NSString stringWithFormat:@"%.1f",second-0.1];
    [UIView commitAnimations];
}

- (void)setSubTitle:(NSString *)subTitle {
    self.subTitleLabel.text = subTitle;
}


- (void)dismiss{
    ZHCWeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.timer invalidate];
        weakSelf.timer = nil;
        weakSelf.subTitleLabel.text = nil;
        weakSelf.titleLabel.text = nil;
        weakSelf.centerLabel.textColor = [UIColor whiteColor];
        
        CGFloat timeLonger;
        if (weakSelf.progressState == ZHCAudioProgressShort) {
            timeLonger = 1;
        } else {
            timeLonger = 0.6;
        }
        [UIView animateWithDuration:timeLonger
                              delay:0
                            options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             weakSelf.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             if(weakSelf.alpha == 0) {
                                 [weakSelf removeFromSuperview];
                                 
                                 NSMutableArray *windows = [[NSMutableArray alloc] initWithArray:[UIApplication sharedApplication].windows];
                                 [windows removeObject:self.overlayWindow];
                                 
                                 [windows enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
                                     if([window isKindOfClass:[UIWindow class]] && window.windowLevel == UIWindowLevelNormal) {
                                         [window makeKeyWindow];
                                         *stop = YES;
                                     }
                                 }];
                             }
                         }];
    });
}


#pragma mark - Setters
-(void)setProgressState:(ZHCAudioProgressState)progressState
{
    switch (progressState) {
        case ZHCAudioProgressSuccess:
            self.centerLabel.text = [NSBundle zhc_localizedStringForKey:@"Recording_Success"];
            break;
        case ZHCAudioProgressShort:
            self.centerLabel.text = [NSBundle zhc_localizedStringForKey:@"Recording_Time_TooShort"];
            break;
        case ZHCAudioProgressMessage:
            self.centerLabel.text = nil;
            break;
        case ZHCAudioProgressError:
            self.centerLabel.text = [NSBundle zhc_localizedStringForKey:@"Recording_Fail"];
            break;
        default:
            break;
    }
}


#pragma mark - Getters

- (NSTimer *)timer{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                              target:self
                                            selector:@selector(timerAction)
                                            userInfo:nil
                                             repeats:YES];
    return _timer;
}

- (UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
        _centerLabel.backgroundColor = [UIColor clearColor];
        _centerLabel.numberOfLines = 0;
        _centerLabel
        .center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
        _centerLabel.text = @"60";
        _centerLabel.textAlignment = NSTextAlignmentCenter;
        _centerLabel.font = [UIFont systemFontOfSize:18];
        _centerLabel.textColor = [UIColor yellowColor];
        
    }
    return _centerLabel;
}


- (UIImageView *)edgeImageView {
    if (!_edgeImageView) {
        _edgeImageView = [[UIImageView alloc]initWithImage:({
            NSString *imageName = @"chat_bar_record_circle";
            UIImage *image = [UIImage zhc_getImageWithImageName:imageName];
            image;})
                          ];
        _edgeImageView.center =  CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2);
    }
    return _edgeImageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        _titleLabel.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2 - 40);
        _titleLabel.numberOfLines = 0;
        _titleLabel.text =  [NSBundle zhc_localizedStringForKey:@"Recording_Time"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor redColor];
    }
    return _titleLabel;
}


- (UILabel *)subTitleLabel{
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 40)];
        _subTitleLabel.center = CGPointMake([[UIScreen mainScreen] bounds].size.width/2,[[UIScreen mainScreen] bounds].size.height/2 + 30);
        _subTitleLabel.text = [NSBundle zhc_localizedStringForKey:@"Slipe_Up_CancelRecording"];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font = [UIFont boldSystemFontOfSize:14];
        _subTitleLabel.textColor = [UIColor whiteColor];
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

- (UIWindow *)overlayWindow {
    if(!_overlayWindow) {
        
        _overlayWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayWindow.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayWindow.userInteractionEnabled = NO;
        [_overlayWindow makeKeyAndVisible];
        
    }
    return _overlayWindow;
}


+(ZHCMessagesAudioProgressHUD *)sharedView
{
    static dispatch_once_t once;
    static ZHCMessagesAudioProgressHUD *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[ZHCMessagesAudioProgressHUD alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        sharedView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    });
    return sharedView;
    
}


+ (void)zhc_show {
    [[ZHCMessagesAudioProgressHUD sharedView] show];
}

+ (void)zhc_dismissWithProgressState:(ZHCAudioProgressState)progressState {
    [[ZHCMessagesAudioProgressHUD sharedView] setProgressState:progressState];
    [[ZHCMessagesAudioProgressHUD sharedView] dismiss];
}

+ (void)zhc_dismissWithMessage:(NSString *)message {
    [[ZHCMessagesAudioProgressHUD sharedView] setProgressState:ZHCAudioProgressMessage];
    [ZHCMessagesAudioProgressHUD sharedView].centerLabel.text = message;
    [[ZHCMessagesAudioProgressHUD sharedView] dismiss];
}


+ (void)zhc_changeSubTitle:(NSString *)str
{
    [[ZHCMessagesAudioProgressHUD sharedView] setSubTitle:str];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
