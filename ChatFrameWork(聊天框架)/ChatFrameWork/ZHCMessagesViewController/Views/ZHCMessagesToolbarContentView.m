//
//  ZHCMessagesToolbarContentView.m
//  ZHChat
//
//  Created by aimoke on 16/8/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesToolbarContentView.h"
#import "UIView+ZHCMessages.h"
#import "ZHCMessagesToolbarButtonFactory.h"

const CGFloat kZHCMessagesToolbarContentViewHorizontalSpacingDefault = 8.0f;


@interface ZHCMessagesToolbarContentView ()

@property (weak, nonatomic) IBOutlet ZHCMessagesComposerTextView *textView;

@property (weak, nonatomic) IBOutlet UIView *leftBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *middleBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet UIView *rightBarButtonContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBarButtonContainerViewWidthConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightHorizontalSpacingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *middleHorizontalSpacingConstraint;
@end

@implementation ZHCMessagesToolbarContentView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([ZHCMessagesToolbarContentView class])
                          bundle:[NSBundle bundleForClass:[ZHCMessagesToolbarContentView class]]];
}



#pragma mark - Initialization
- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.leftHorizontalSpacingConstraint.constant = kZHCMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightHorizontalSpacingConstraint.constant = kZHCMessagesToolbarContentViewHorizontalSpacingDefault;
    self.middleHorizontalSpacingConstraint.constant = kZHCMessagesToolbarContentViewHorizontalSpacingDefault;
    self.backgroundColor = [UIColor clearColor];
    
}

#pragma mark - Setters

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.leftBarButtonContainerView.backgroundColor = backgroundColor;
    self.middleBarButtonContainerView.backgroundColor = backgroundColor;
    self.rightBarButtonContainerView.backgroundColor = backgroundColor;
}

- (void)setLeftBarButtonItem:(UIButton *)leftBarButtonItem
{
    if (_leftBarButtonItem) {
        [_leftBarButtonItem removeFromSuperview];
    }
    
    if (!leftBarButtonItem) {
        _leftBarButtonItem = nil;
        self.leftHorizontalSpacingConstraint.constant = 0.0f;
        self.leftBarButtonItemWidth = 0.0f;
        self.leftBarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(leftBarButtonItem.frame, CGRectZero)) {
        leftBarButtonItem.frame = self.leftBarButtonContainerView.bounds;
    }
    
    self.leftBarButtonContainerView.hidden = NO;
    self.leftHorizontalSpacingConstraint.constant = kZHCMessagesToolbarContentViewHorizontalSpacingDefault;
    self.leftBarButtonItemWidth = CGRectGetWidth(leftBarButtonItem.frame);
    
    [leftBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.leftBarButtonContainerView addSubview:leftBarButtonItem];
    [self.leftBarButtonContainerView zhc_pinAllEdgesOfSubview:leftBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    
    _leftBarButtonItem = leftBarButtonItem;
}

- (void)setLeftBarButtonItemWidth:(CGFloat)leftBarButtonItemWidth
{
    self.leftBarButtonContainerViewWidthConstraint.constant = leftBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}

- (void)setMiddleBarButtonItem:(UIButton *)middleBarButtonItem
{
    if (_middleBarButtonItem) {
        [_middleBarButtonItem removeFromSuperview];
    }
    
    if (!middleBarButtonItem) {
        _middleBarButtonItem = nil;
        self.middleHorizontalSpacingConstraint.constant = 0.0f;
        self.middleBarButtonItemWidth = 0.0f;
        self.middleBarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(middleBarButtonItem.frame, CGRectZero)) {
        middleBarButtonItem.frame = self.middleBarButtonContainerView.bounds;
    }
    
    self.middleBarButtonContainerView.hidden = NO;
    self.middleHorizontalSpacingConstraint.constant = kZHCMessagesToolbarContentViewHorizontalSpacingDefault;
    self.middleBarButtonItemWidth = CGRectGetWidth(middleBarButtonItem.frame);
    
    [middleBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.middleBarButtonContainerView addSubview:middleBarButtonItem];
    [self.middleBarButtonContainerView zhc_pinAllEdgesOfSubview:middleBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _middleBarButtonItem = middleBarButtonItem;
}


-(void)setLongPressButton:(UIButton *)longPressButton
{
    if (_longPressButton) {
        [_longPressButton removeFromSuperview];
    }
    if (!longPressButton) {
        _longPressButton = nil;
        return;
    }
    if (CGRectEqualToRect(longPressButton.frame, CGRectZero)) {
        longPressButton.frame = self.textView.bounds;
    }
    longPressButton.hidden = NO;
    longPressButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:longPressButton];
    
    [self setLongPressConstraintswithView:longPressButton];
    [self setNeedsUpdateConstraints];
    _longPressButton = longPressButton;
}


-(void)setLongPressConstraintswithView:(UIView *)longpressView
{
    CGFloat top = 0.0f,bottom = 0.0f,left = 0.0f,right=0.0f;
    
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstItem == _textView || constraint.secondItem == _textView) {
            if (constraint.firstAttribute == NSLayoutAttributeTop) {
                top = constraint.constant;
            }else if (constraint.secondAttribute == NSLayoutAttributeBottom){
                bottom = constraint.constant;
            }else if (constraint.firstAttribute == NSLayoutAttributeLeading && constraint.firstItem == _textView){
                left = constraint.constant;
            }else if (constraint.secondAttribute == NSLayoutAttributeTrailing && constraint.secondItem == _textView){
                right = constraint.constant;
            }
        }
        
    }
    [self addConstraint:[NSLayoutConstraint constraintWithItem:longpressView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:top]];
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:longpressView attribute:NSLayoutAttributeBottom multiplier:1 constant:bottom]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:longpressView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:_leftBarButtonContainerView attribute:NSLayoutAttributeTrailing multiplier:1 constant:left]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_middleBarButtonContainerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:longpressView attribute:NSLayoutAttributeTrailing multiplier:1 constant:right]];

    
}


- (void)setMiddleBarButtonItemWidth:(CGFloat)middleBarButtonItemWidth
{
    self.middleBarButtonContainerViewWidthConstraint.constant = middleBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}



- (void)setRightBarButtonItem:(UIButton *)rightBarButtonItem
{
    if (_rightBarButtonItem) {
        [_rightBarButtonItem removeFromSuperview];
    }
    
    if (!rightBarButtonItem) {
        _rightBarButtonItem = nil;
        self.rightHorizontalSpacingConstraint.constant = 0.0f;
        self.rightBarButtonItemWidth = 0.0f;
        self.rightBarButtonContainerView.hidden = YES;
        return;
    }
    
    if (CGRectEqualToRect(rightBarButtonItem.frame, CGRectZero)) {
        rightBarButtonItem.frame = self.rightBarButtonContainerView.bounds;
    }
    
    self.rightBarButtonContainerView.hidden = NO;
    self.rightHorizontalSpacingConstraint.constant = kZHCMessagesToolbarContentViewHorizontalSpacingDefault;
    self.rightBarButtonItemWidth = CGRectGetWidth(rightBarButtonItem.frame);
    
    [rightBarButtonItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.rightBarButtonContainerView addSubview:rightBarButtonItem];
    [self.rightBarButtonContainerView zhc_pinAllEdgesOfSubview:rightBarButtonItem];
    [self setNeedsUpdateConstraints];
    
    _rightBarButtonItem = rightBarButtonItem;
}

- (void)setRightBarButtonItemWidth:(CGFloat)rightBarButtonItemWidth
{
    self.rightBarButtonContainerViewWidthConstraint.constant = rightBarButtonItemWidth;
    [self setNeedsUpdateConstraints];
}


#pragma mark - Getters

- (CGFloat)leftBarButtonItemWidth
{
    return self.leftBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightBarButtonItemWidth
{
    return self.rightBarButtonContainerViewWidthConstraint.constant;
}

- (CGFloat)rightContentPadding
{
    return self.rightHorizontalSpacingConstraint.constant;
}

- (CGFloat)leftContentPadding
{
    return self.leftHorizontalSpacingConstraint.constant;
}

#pragma mark - UIView overrides

- (void)setNeedsDisplay
{
    [super setNeedsDisplay];
    [self.textView setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
