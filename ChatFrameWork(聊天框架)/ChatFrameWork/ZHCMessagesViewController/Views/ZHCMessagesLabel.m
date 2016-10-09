//
//  ZHCMessagesLabel.m
//  ZHChat
//
//  Created by aimoke on 16/8/9.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesLabel.h"

@implementation ZHCMessagesLabel

#pragma mark - Initialization
-(void)zhc_configureLabel
{
    self.textInsets = UIEdgeInsetsZero;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self zhc_configureLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self zhc_configureLabel];
}

#pragma mark - Setters

- (void)setTextInsets:(UIEdgeInsets)textInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_textInsets, textInsets)) {
        return;
    }
    
    _textInsets = textInsets;
    [self setNeedsDisplay];
}


#pragma mark - Drawing

- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:CGRectMake(CGRectGetMinX(rect) + self.textInsets.left,
                                     CGRectGetMinY(rect) + self.textInsets.top,
                                     CGRectGetWidth(rect) - self.textInsets.right,
                                     CGRectGetHeight(rect) - self.textInsets.bottom)];
}


@end
