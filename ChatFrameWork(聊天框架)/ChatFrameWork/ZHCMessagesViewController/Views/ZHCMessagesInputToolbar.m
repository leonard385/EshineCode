//
//  ZHCMessagesInputToolbar.m
//  ZHChat
//
//  Created by aimoke on 16/8/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesInputToolbar.h"
#import "ZHCMessagesComposerTextView.h"
#import "ZHCMessagesToolbarButtonFactory.h"
#import "UIColor+ZHCMessages.h"
#import "UIImage+ZHCMessages.h"
#import "UIView+ZHCMessages.h"
#import "NSBundle+ZHCMessages.h"



static void * kZHCMessagesInputToolbarKeyValueObservingContext = &kZHCMessagesInputToolbarKeyValueObservingContext;


@interface ZHCMessagesInputToolbar ()
@property (assign, nonatomic) BOOL zhc_isObserving;
@property (strong, nonatomic) ZHCMessagesVoiceRecorder *recorder;
@end

@implementation ZHCMessagesInputToolbar
@dynamic delegate;

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
    self.zhc_isObserving = NO;
    self.sendButtonOnRight = YES;
    
    self.preferredDefaultHeight = 44.0f;
    self.maximumHeight = NSNotFound;
    
    self.recorder = [[ZHCMessagesVoiceRecorder alloc]init];
    self.recorder.delegate = self;
    
    ZHCMessagesToolbarContentView *toolbarContentView = [self loadToolbarContentView];
    toolbarContentView.frame = self.frame;
    [self addSubview:toolbarContentView];
    [self zhc_pinAllEdgesOfSubview:toolbarContentView];
    [self setNeedsUpdateConstraints];
    _contentView = toolbarContentView;
     [self zhc_addObservers];
    
    ZHCMessagesToolbarButtonFactory *toolbarButtonFactory = [[ZHCMessagesToolbarButtonFactory alloc] initWithFont:[UIFont boldSystemFontOfSize:17.0]];
    self.contentView.leftBarButtonItem = [toolbarButtonFactory defaultInputViewBarLeftButtonItem];
    self.contentView.rightBarButtonItem = [toolbarButtonFactory defaultInputViewBarRightButtonItem];
    self.contentView.middleBarButtonItem = [toolbarButtonFactory defaultInputViewBarMiddelButtonItem];
    self.contentView.longPressButton = [toolbarButtonFactory defaultInputViewVoiceLongPressButtonItem];
    self.contentView.longPressButton.hidden = YES;

    [self.contentView.longPressButton addTarget:self action:@selector(zhc_startRecordVoice:) forControlEvents:UIControlEventTouchDown];
     [self.contentView.longPressButton addTarget:self action:@selector(zhc_cancelRecordVoice:) forControlEvents:UIControlEventTouchUpOutside];
    [self.contentView.longPressButton addTarget:self action:@selector(zhc_confirmRecordVoice:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView.longPressButton addTarget:self action:@selector(zhc_updateCancelRecordVoice) forControlEvents:UIControlEventTouchDragExit];
    [self.contentView.longPressButton addTarget:self action:@selector(zhc_updateContinueRecordVoice) forControlEvents:UIControlEventTouchDragEnter];
    
    
    [self toggleSendButtonEnabled];
   

}

- (ZHCMessagesToolbarContentView *)loadToolbarContentView
{
    NSArray *nibViews = [[NSBundle bundleForClass:[ZHCMessagesInputToolbar class]] loadNibNamed:NSStringFromClass([ZHCMessagesToolbarContentView class])
                                                                                          owner:nil
                                                                                        options:nil];
    return nibViews.firstObject;
}

- (void)dealloc
{
    [self zhc_removeObservers];
    self.recorder.delegate = nil;
}


#pragma mark - Setters

- (void)setPreferredDefaultHeight:(CGFloat)preferredDefaultHeight
{
    NSParameterAssert(preferredDefaultHeight > 0.0f);
    _preferredDefaultHeight = preferredDefaultHeight;
}



#pragma mark - Actions

/**
 * Start Record Voice.
 */
-(void)zhc_startRecordVoice:(UIButton *)sender
{
    sender.highlighted = YES;
    [ZHCMessagesAudioProgressHUD zhc_show];
    [_recorder zhc_startRecording];
}

/**
 * Cancel Record Voice.
 */
-(void)zhc_cancelRecordVoice:(UIButton *)sender
{
    sender.highlighted = NO;
    [ZHCMessagesAudioProgressHUD zhc_dismissWithMessage:[NSBundle zhc_localizedStringForKey:@"Cancel_Recording"]];
    [_recorder zhc_cancelRecord];
}

/**
 * Finish Record Voice.
 */
-(void)zhc_confirmRecordVoice:(UIButton *)sender
{
     sender.highlighted = NO;
    [_recorder zhc_stopRecording];
}

/**
 * Update Voice HUD Status.
 */
-(void)zhc_updateCancelRecordVoice
{
    [ZHCMessagesAudioProgressHUD zhc_changeSubTitle:[NSBundle zhc_localizedStringForKey:@"Release_Cancel_Recording"]];
    
}

/**
 * Update Voice HUD Status.
 */
-(void)zhc_updateContinueRecordVoice
{
    [ZHCMessagesAudioProgressHUD zhc_changeSubTitle:[NSBundle zhc_localizedStringForKey:@"Slipe_Up_CancelRecording"]];
}

- (void)zhc_leftBarButtonPressed:(UIButton *)sender
{
    
    self.contentView.rightBarButtonItem.selected = NO;
    self.contentView.middleBarButtonItem.selected = NO;
    sender.selected = !sender.selected;
    [self.delegate messagesInputToolbar:self didPressLeftBarButton:sender];
    if (sender.selected) {
        [self.contentView.textView resignFirstResponder];
        self.contentView.textView.hidden = YES;
        self.contentView.longPressButton.hidden = NO;
        
    }else{
        [self.contentView.textView becomeFirstResponder];
        self.contentView.textView.hidden = NO;
        self.contentView.longPressButton.hidden = YES;
    }

}

- (void)zhc_rightBarButtonPressed:(UIButton *)sender
{
    self.contentView.leftBarButtonItem.selected = NO;
    self.contentView.middleBarButtonItem.selected = NO;
    self.contentView.longPressButton.hidden = YES;
    self.contentView.textView.hidden = NO;
    sender.selected = !sender.selected;
    [self.delegate messagesInputToolbar:self didPressRightBarButton:sender];
    if (sender.selected) {
        [self.contentView.textView resignFirstResponder];
    }else{
        [self.contentView.textView becomeFirstResponder];
    }
    
}

-(void)zhc_middelBarButtonPressed:(UIButton *)sender
{
    self.contentView.leftBarButtonItem.selected = NO;
    self.contentView.rightBarButtonItem.selected = NO;
    self.contentView.longPressButton.hidden = YES;
    self.contentView.textView.hidden = NO;
    sender.selected = !sender.selected;
    [self.delegate messagesInputToolbar:self didPressMiddelBarButton:sender];
    if (sender.selected) {
        [self.contentView.textView resignFirstResponder];
    }else{
        [self.contentView.textView becomeFirstResponder];
    }
    
}

#pragma mark - ZHCMessagesVoiceDelegate
- (void)zhc_voiceRecorded:(NSString *)recordPath length:(float)recordLength
{
    if (recordPath) {
        [ZHCMessagesAudioProgressHUD zhc_dismissWithProgressState:ZHCAudioProgressSuccess];
        [self sendVoiceMessage:recordPath seconds:recordLength];
    }else{
        [ZHCMessagesAudioProgressHUD zhc_dismissWithProgressState:ZHCAudioProgressError];
    }
}

- (void)zhc_failRecord
{
    [ZHCMessagesAudioProgressHUD zhc_dismissWithProgressState:ZHCAudioProgressError];
}

#pragma mark - Private Methods
-(void)sendVoiceMessage:(NSString *)voiceFileName seconds:(NSTimeInterval)seconds
{
    if ((seconds > 0) && self.delegate && [self.delegate respondsToSelector:@selector(messagesInputToolbar:sendVoice:seconds:)]) {
        [self.delegate messagesInputToolbar:self sendVoice:voiceFileName seconds:seconds];
    }

}


#pragma mark - Input toolbar

- (void)toggleSendButtonEnabled
{
    BOOL hasText = [self.contentView.textView hasText];
    if (hasText) {
        self.contentView.textView.enablesReturnKeyAutomatically = NO;
    }else{
        self.contentView.textView.enablesReturnKeyAutomatically = YES;
    }
    
}


#pragma mark - Key-value observing

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kZHCMessagesInputToolbarKeyValueObservingContext) {
        if (object == self.contentView) {
            
            if ([keyPath isEqualToString:NSStringFromSelector(@selector(leftBarButtonItem))]) {
                
                [self.contentView.leftBarButtonItem removeTarget:self
                                                          action:NULL
                                                forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.leftBarButtonItem addTarget:self
                                                       action:@selector(zhc_leftBarButtonPressed:)
                                             forControlEvents:UIControlEventTouchUpInside];
            }
            else if ([keyPath isEqualToString:NSStringFromSelector(@selector(rightBarButtonItem))]) {
                
                [self.contentView.rightBarButtonItem removeTarget:self
                                                           action:NULL
                                                 forControlEvents:UIControlEventTouchUpInside];
                
                [self.contentView.rightBarButtonItem addTarget:self
                                                        action:@selector(zhc_rightBarButtonPressed:)
                                              forControlEvents:UIControlEventTouchUpInside];
            }else if ([keyPath isEqualToString:NSStringFromSelector(@selector(middleBarButtonItem))]){
                [self.contentView.middleBarButtonItem removeTarget:self action:NULL forControlEvents:UIControlEventTouchUpInside];
                [self.contentView.middleBarButtonItem addTarget:self action:@selector(zhc_middelBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            [self toggleSendButtonEnabled];
        }
    }
}

- (void)zhc_addObservers
{
    if (self.zhc_isObserving) {
        return;
    }
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                          options:0
                          context:kZHCMessagesInputToolbarKeyValueObservingContext];
    
    [self.contentView addObserver:self
                       forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                          options:0
                          context:kZHCMessagesInputToolbarKeyValueObservingContext];
    
    [self.contentView addObserver:self forKeyPath:NSStringFromSelector(@selector(middleBarButtonItem)) options:0 context:kZHCMessagesInputToolbarKeyValueObservingContext];
    
    self.zhc_isObserving = YES;
}


- (void)zhc_removeObservers
{
    if (!_zhc_isObserving) {
        return;
    }
    
    @try {
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(leftBarButtonItem))
                             context:kZHCMessagesInputToolbarKeyValueObservingContext];
        
        [_contentView removeObserver:self
                          forKeyPath:NSStringFromSelector(@selector(rightBarButtonItem))
                             context:kZHCMessagesInputToolbarKeyValueObservingContext];
        
        [_contentView removeObserver:self forKeyPath:NSStringFromSelector(@selector(middleBarButtonItem)) context:kZHCMessagesInputToolbarKeyValueObservingContext];
    }
    @catch (NSException *__unused exception) { }
    
    _zhc_isObserving = NO;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
