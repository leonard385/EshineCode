//
//  ZHCMessagesTableviewLayoutAttributes.m
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesTableviewLayoutAttributes.h"
#import "ZHCMessagesCommonParameter.h"

@implementation ZHCMessagesTableviewLayoutAttributes

+(instancetype)shareZHCMessagesTableviewLayoutAttributesFactory
{
    static ZHCMessagesTableviewLayoutAttributes *attributes = nil;
    static dispatch_once_t onecePredicate;
    dispatch_once(&onecePredicate, ^{
        attributes = [[ZHCMessagesTableviewLayoutAttributes alloc]init];
    });
    
    return attributes;
}


-(instancetype)init
{
    self = [super init];
    if (self) {
        _messageBubbleFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        _textViewTextContainerInsets = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        _textViewTextFrameInsets = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 6.0f);
        _incomingAvatarViewSize = CGSizeMake(kZHCMessagesTableViewCellAvatarSizeDefault, kZHCMessagesTableViewCellAvatarSizeDefault);
        _outgoingAvatarViewSize = CGSizeMake(kZHCMessagesTableViewCellAvatarSizeDefault, kZHCMessagesTableViewCellAvatarSizeDefault);
        _cellTopLabelHeight = kZHCMessagesTableViewCellLabelHeightDefault;
        _messageBubbleTopLabelHeight = kZHCMessagesTableViewCellLabelHeightDefault;
        _cellBottomLabelHeight = kZHCMessagesTableViewCellLabelHeightDefault;
        _messageBubbleSpaceWithAvatar = 2.0;
        _messageBubbleHorizontallySpaceWithSuperView = 32.0;
        _messageAvatarHorizontallySpaceWithSuperView = 8.0;
        _messageBubbleContainerViewWidth = 244;
    }
    return self;
}

#pragma mark - NSObject
-(BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    ZHCMessagesTableviewLayoutAttributes *layoutAttibutes = (ZHCMessagesTableviewLayoutAttributes *)object;
    if (!UIEdgeInsetsEqualToEdgeInsets(layoutAttibutes.textViewTextFrameInsets, self.textViewTextFrameInsets)
        ||layoutAttibutes.messageAvatarHorizontallySpaceWithSuperView != self.messageAvatarHorizontallySpaceWithSuperView
        || layoutAttibutes.messageBubbleHorizontallySpaceWithSuperView != self.messageBubbleHorizontallySpaceWithSuperView
        || layoutAttibutes.messageBubbleSpaceWithAvatar != self.messageBubbleSpaceWithAvatar
        || layoutAttibutes.messageBubbleContainerViewWidth != self.messageBubbleContainerViewWidth
        || !UIEdgeInsetsEqualToEdgeInsets(layoutAttibutes.textViewTextContainerInsets, self.textViewTextContainerInsets)
        || !CGSizeEqualToSize(layoutAttibutes.incomingAvatarViewSize, self.incomingAvatarViewSize)
        || !CGSizeEqualToSize(layoutAttibutes.outgoingAvatarViewSize, self.outgoingAvatarViewSize)
        || layoutAttibutes.cellTopLabelHeight != self.cellTopLabelHeight
        || layoutAttibutes.messageBubbleTopLabelHeight != self.messageBubbleTopLabelHeight
        || layoutAttibutes.cellBottomLabelHeight != self.cellBottomLabelHeight) {
        return NO;
    }
    
    return [super isEqual:object];
}

-(NSUInteger)hash
{
    return self.hash;
}


#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone
{
    ZHCMessagesTableviewLayoutAttributes *copy = [[self class]allocWithZone:zone];
    
    copy.textViewTextFrameInsets = self.textViewTextFrameInsets;
    copy.messageAvatarHorizontallySpaceWithSuperView = self.messageAvatarHorizontallySpaceWithSuperView;
    copy.messageBubbleHorizontallySpaceWithSuperView = self.messageBubbleHorizontallySpaceWithSuperView;
    copy.messageBubbleSpaceWithAvatar = self.messageBubbleSpaceWithAvatar;
    
    copy.messageBubbleFont = self.messageBubbleFont;
    copy.messageBubbleContainerViewWidth = self.messageBubbleContainerViewWidth;
    
    copy.textViewTextContainerInsets = self.textViewTextContainerInsets;
    copy.incomingAvatarViewSize = self.incomingAvatarViewSize;
    copy.outgoingAvatarViewSize = self.outgoingAvatarViewSize;
    copy.cellTopLabelHeight = self.cellTopLabelHeight;
    copy.messageBubbleTopLabelHeight = self.messageBubbleTopLabelHeight;
    copy.cellBottomLabelHeight = self.cellBottomLabelHeight;
    
    return copy;
}




#pragma mark - Setters
-(void)setMessageAvatarHorizontallySpaceWithSuperView:(CGFloat)messageAvatarHorizontallySpaceWithSuperView
{
    NSParameterAssert(messageAvatarHorizontallySpaceWithSuperView >0.0f);
    _messageBubbleHorizontallySpaceWithSuperView = messageAvatarHorizontallySpaceWithSuperView;
}



-(void)setMessageBubbleHorizontallySpaceWithSuperView:(CGFloat)messageBubbleHorizontallySpaceWithSuperView
{
    NSParameterAssert(messageBubbleHorizontallySpaceWithSuperView > 0.0f);
    _messageBubbleHorizontallySpaceWithSuperView = messageBubbleHorizontallySpaceWithSuperView;
}

-(void)setMessageBubbleSpaceWithAvatar:(CGFloat)messageBubbleSpaceWithAvatar
{
    NSParameterAssert(messageBubbleSpaceWithAvatar > 0.0f);
    _messageBubbleSpaceWithAvatar = messageBubbleSpaceWithAvatar;
}


- (void)setMessageBubbleFont:(UIFont *)messageBubbleFont
{
    NSParameterAssert(messageBubbleFont != nil);
    _messageBubbleFont = messageBubbleFont;
}

- (void)setMessageBubbleContainerViewWidth:(CGFloat)messageBubbleContainerViewWidth
{
    NSParameterAssert(messageBubbleContainerViewWidth > 0.0f);
    _messageBubbleContainerViewWidth = ceilf(messageBubbleContainerViewWidth);
}

- (void)setIncomingAvatarViewSize:(CGSize)incomingAvatarViewSize
{
    NSParameterAssert(incomingAvatarViewSize.width >= 0.0f && incomingAvatarViewSize.height >= 0.0f);
    _incomingAvatarViewSize = [self zhc_correctedAvatarSizeFromSize:incomingAvatarViewSize];
}

- (void)setOutgoingAvatarViewSize:(CGSize)outgoingAvatarViewSize
{
    NSParameterAssert(outgoingAvatarViewSize.width >= 0.0f && outgoingAvatarViewSize.height >= 0.0f);
    _outgoingAvatarViewSize = [self zhc_correctedAvatarSizeFromSize:outgoingAvatarViewSize];
}

- (void)setCellTopLabelHeight:(CGFloat)cellTopLabelHeight
{
    NSParameterAssert(cellTopLabelHeight >= 0.0f);
    _cellTopLabelHeight = [self zhc_correctedLabelHeightForHeight:cellTopLabelHeight];
}

- (void)setMessageBubbleTopLabelHeight:(CGFloat)messageBubbleTopLabelHeight
{
    NSParameterAssert(messageBubbleTopLabelHeight >= 0.0f);
    _messageBubbleTopLabelHeight = [self zhc_correctedLabelHeightForHeight:messageBubbleTopLabelHeight];
}

- (void)setCellBottomLabelHeight:(CGFloat)cellBottomLabelHeight
{
    NSParameterAssert(cellBottomLabelHeight >= 0.0f);
    _cellBottomLabelHeight = [self zhc_correctedLabelHeightForHeight:cellBottomLabelHeight];
}


#pragma mark - Utilities

- (CGSize)zhc_correctedAvatarSizeFromSize:(CGSize)size
{
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CGFloat)zhc_correctedLabelHeightForHeight:(CGFloat)height
{
    return ceilf(height);
}


@end
