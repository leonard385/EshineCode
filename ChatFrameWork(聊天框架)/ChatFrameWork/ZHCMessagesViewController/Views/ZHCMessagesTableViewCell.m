//
//  ZHCMessagesTableViewCell.m
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesTableViewCell.h"
#import "UIView+ZHCMessages.h"
#import "ZHCMessagesTableviewLayoutAttributes.h"
#import "ZHCMessagesTableViewCellIncoming.h"
#import "ZHCMessagesTableViewCellOutcoming.h"
#import "ZHCMessagesTableView.h"
#import "ZHCMessagesCommonParameter.h"

static NSMutableSet *zhcMessagesTableViewCellActions = nil;

@interface ZHCMessagesTableViewCell()
@property (weak, nonatomic) IBOutlet ZHCMessagesLabel *cellTopLabel;
@property (weak, nonatomic) IBOutlet ZHCMessagesLabel *messageBubbleTopLabel;
@property (weak, nonatomic) IBOutlet ZHCMessagesLabel *cellBottomLabel;

@property (weak, nonatomic) IBOutlet ZHCMessagesLabel *cellsSpaceLabel;//this label is to set cells space with vertical
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellsSpaceConstraint;


@property (weak, nonatomic) IBOutlet UIView *messageBubbleContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *messageBubbleImageView;

@property (weak, nonatomic) IBOutlet ZHCMessagesCellTextView *textView;

@property (weak, nonatomic) IBOutlet UIView *avatarContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleTopLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cellBottomLabelHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleContainerWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageBubbleContainerSpaceWithAvatarView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *avatarContainerViewHorizontallyWithSuperViewConstraint;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewTopVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewBottomVerticalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewAvatarHorizontalSpaceConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewMarginHorizontalSpaceConstraint;



@property (assign, nonatomic) UIEdgeInsets textViewFrameInsets;

@property (assign, nonatomic) CGSize avatarViewSize;

@property (weak, nonatomic, readwrite) UITapGestureRecognizer *tapGestureRecognizer;

- (void)zhc_handleTapGesture:(UITapGestureRecognizer *)tap;

- (void)zhc_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant;
@end

@implementation ZHCMessagesTableViewCell

#pragma mark - Class methods
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        zhcMessagesTableViewCellActions = [NSMutableSet new];
    });
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[NSBundle bundleForClass:[self class]]];
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (NSString *)mediaCellReuseIdentifier
{
    return [NSString stringWithFormat:@"%@_ZHCMedia", NSStringFromClass([self class])];
}

+ (void)registerMenuAction:(SEL)action
{
    [zhcMessagesTableViewCellActions addObject:NSStringFromSelector(action)];
}


#pragma mark - Initialization

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellTopLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageBubbleTopLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cellBottomLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.cellsSpaceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageBubbleContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageBubbleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    self.avatarImageView.translatesAutoresizingMaskIntoConstraints = NO;
   
    
    self.backgroundColor = [UIColor colorWithRed:243.0/255.0f
                                           green:243.0/255.0f
                                            blue:243.0/255.0f
                                           alpha:1.0f];
    
    self.cellTopLabelHeightConstraint.constant = 0.0f;
    self.messageBubbleTopLabelHeightConstraint.constant = 0.0f;
    self.cellBottomLabelHeightConstraint.constant = 0.0f;
    self.avatarViewSize = CGSizeZero;
    self.cellsSpaceConstraint.constant = kZHCMessagesTableViewCellSpaceDefault;
    self.cellsSpaceLabel.text = nil;
    self.cellTopLabel.textAlignment = NSTextAlignmentCenter;
    self.cellTopLabel.font = [UIFont boldSystemFontOfSize:12.0];
    self.cellTopLabel.textColor = [UIColor lightGrayColor];
    
    self.messageBubbleTopLabel.font = [UIFont systemFontOfSize:12.0];
    self.messageBubbleTopLabel.textColor = [UIColor grayColor];
    self.messageBubbleTopLabel.textAlignment = NSTextAlignmentCenter;
    
    self.cellBottomLabel.font = [UIFont systemFontOfSize:11.0];
    self.cellBottomLabel.textColor = [UIColor lightGrayColor];
    self.cellBottomLabel.textAlignment = NSTextAlignmentCenter;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(zhc_handleTapGesture:)];
    [self addGestureRecognizer:tap];
    self.tapGestureRecognizer = tap;
    
    // Initialization code
}




- (void)dealloc
{
    _delegate = nil;
    
    _cellTopLabel = nil;
    _messageBubbleTopLabel = nil;
    _cellBottomLabel = nil;
    
    _textView = nil;
    _messageBubbleImageView = nil;
    _mediaView = nil;
    
    _avatarImageView = nil;
    
    [_tapGestureRecognizer removeTarget:nil action:NULL];
    _tapGestureRecognizer = nil;
    _cellsSpaceLabel = nil;
}

#pragma mark - Update All Constraints
-(void)applyLayoutAttributes
{
   
    NSAssert(self.delegate != nil, @"cellDelegate Can not is nill");
    
    ZHCMessagesTableviewLayoutAttributes *attributes = self.delegate.messagesTableViewCellAttributes;
    
    self.textView.textContainerInset = attributes.textViewTextContainerInsets;
    self.textView.font = attributes.messageBubbleFont;
    
    [self zhc_updateConstraint:self.cellTopLabelHeightConstraint withConstant:attributes.cellTopLabelHeight];
    [self zhc_updateConstraint:self.messageBubbleTopLabelHeightConstraint withConstant:attributes.messageBubbleTopLabelHeight];
    [self zhc_updateConstraint:self.cellBottomLabelHeightConstraint withConstant:attributes.cellBottomLabelHeight];
    if ([self isKindOfClass:[ZHCMessagesTableViewCellIncoming class]]) {
        self.avatarViewSize = attributes.incomingAvatarViewSize;
    }else if ([self isKindOfClass:[ZHCMessagesTableViewCellOutcoming class]]){
        self.avatarViewSize = attributes.outgoingAvatarViewSize;
    }
    
    
    [self zhc_updateConstraint:self.avatarContainerViewHorizontallyWithSuperViewConstraint withConstant:attributes.messageAvatarHorizontallySpaceWithSuperView];
    [self zhc_updateConstraint:self.messageBubbleContainerWidth withConstant:attributes.messageBubbleContainerViewWidth];
    [self zhc_updateConstraint:self.messageBubbleContainerSpaceWithAvatarView withConstant:attributes.messageBubbleSpaceWithAvatar];
    
    [self zhc_updateConstraint:self.textViewAvatarHorizontalSpaceConstraint withConstant:attributes.textViewTextFrameInsets.right];
    [self zhc_updateConstraint:self.textViewTopVerticalSpaceConstraint withConstant:attributes.textViewTextFrameInsets.top];
    [self zhc_updateConstraint:self.textViewBottomVerticalSpaceConstraint withConstant:attributes.textViewTextFrameInsets.bottom];
    [self zhc_updateConstraint:self.textViewMarginHorizontalSpaceConstraint withConstant:attributes.textViewTextFrameInsets.left];
    
    
}



-(void)prepareForReuse
{
    [super prepareForReuse];
    
    self.cellTopLabel.text = nil;
    self.messageBubbleTopLabel.text = nil;
    self.cellBottomLabel.text = nil;
    
    self.textView.dataDetectorTypes = UIDataDetectorTypeNone;
    self.textView.text = nil;
    self.textView.attributedText = nil;
    
    self.avatarImageView.image = nil;
    self.avatarImageView.highlightedImage = nil;
    self.cellsSpaceLabel.text = nil;
    
    
}


-(void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.avatarImageView.highlighted = highlighted;
    self.messageBubbleImageView.highlighted = highlighted;
}

-(void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.avatarImageView.highlighted = selected;
    self.messageBubbleImageView.highlighted = selected;
}


#pragma mark - Menu actions
-(BOOL)respondsToSelector:(SEL)aSelector
{
    if ([zhcMessagesTableViewCellActions containsObject:NSStringFromSelector(aSelector)]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // do nothing
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // do nothing
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // do nothing
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // do nothing
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    if ([zhcMessagesTableViewCellActions containsObject:NSStringFromSelector(anInvocation.selector)]) {
        __unsafe_unretained id sender;
        [anInvocation getArgument:&sender atIndex:0];
        [self.delegate messagesTableViewCell:self didPerformAction:anInvocation.selector withSender:sender];
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    if ([zhcMessagesTableViewCellActions containsObject:NSStringFromSelector(aSelector)]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}


#pragma mark - Setters


-(void)setCellsSpaceLabelHeight:(CGFloat)cellsSpaceLabelHeight
{
     NSParameterAssert(cellsSpaceLabelHeight >= 0.0f);
    if (cellsSpaceLabelHeight == 0.0f) {
        self.cellsSpaceLabel.text = nil;
    }
    if (self.cellsSpaceConstraint.constant == cellsSpaceLabelHeight) {
        return;
    }
    _cellsSpaceLabelHeight = cellsSpaceLabelHeight;
    [self zhc_updateConstraint:self.cellsSpaceConstraint withConstant:cellsSpaceLabelHeight];
    
}



-(void)setCellTopLabelHeight:(CGFloat)cellTopLabelHeight
{
    NSParameterAssert(cellTopLabelHeight >= 0.0f);
    if (cellTopLabelHeight == 0.0f) {
        self.cellTopLabel.text = nil;
    }
    if (self.cellTopLabelHeightConstraint.constant == cellTopLabelHeight) {
        return;
    }
    _cellTopLabelHeight = cellTopLabelHeight;
    [self zhc_updateConstraint:self.cellTopLabelHeightConstraint withConstant:cellTopLabelHeight];
    
}

-(void)setMessageBubbleTopLabelHeight:(CGFloat)messageBubbleTopLabelHeight
{
    NSParameterAssert(messageBubbleTopLabelHeight >= 0.0f);
    if (messageBubbleTopLabelHeight == 0.0f) {
        self.messageBubbleTopLabel.text = nil;
    }
    if (self.messageBubbleTopLabelHeightConstraint.constant == messageBubbleTopLabelHeight) {
        return;
    }
    _messageBubbleTopLabelHeight = messageBubbleTopLabelHeight;
    [self zhc_updateConstraint:self.messageBubbleTopLabelHeightConstraint withConstant:messageBubbleTopLabelHeight];
}


-(void)setCellBottomLabelHeight:(CGFloat)cellBottomLabelHeight
{
    NSParameterAssert(cellBottomLabelHeight >= 0.0f);
    if (cellBottomLabelHeight == 0.0f) {
        self.cellBottomLabel.text = nil;
    }
    if (self.cellBottomLabelHeightConstraint.constant == cellBottomLabelHeight) {
        return;
    }
    
    _cellBottomLabelHeight = cellBottomLabelHeight;
    [self zhc_updateConstraint:self.cellBottomLabelHeightConstraint withConstant:cellBottomLabelHeight];
}


-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.cellTopLabel.backgroundColor = backgroundColor;
    self.messageBubbleTopLabel.backgroundColor = backgroundColor;
    self.cellBottomLabel.backgroundColor = backgroundColor;
    
    self.messageBubbleContainerView.backgroundColor = backgroundColor;
    self.messageBubbleImageView.backgroundColor = backgroundColor;
    self.avatarContainerView.backgroundColor = backgroundColor;
    self.avatarImageView.backgroundColor = backgroundColor;
    self.cellsSpaceLabel.backgroundColor = backgroundColor;

}

-(void)setAvatarViewSize:(CGSize)avatarViewSize
{
    if (CGSizeEqualToSize(avatarViewSize, self.avatarViewSize)) {
        return;
    }
    [self zhc_updateConstraint:self.avatarContainerViewWidthConstraint withConstant:avatarViewSize.width];
    [self zhc_updateConstraint:self.avatarContainerViewHeightConstraint withConstant:avatarViewSize.height];
     [self updateConstraints];
}

-(void)setTextViewFrameInsets:(UIEdgeInsets)textViewFrameInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(textViewFrameInsets, self.textViewFrameInsets)) {
        return;
    }
    [self zhc_updateConstraint:self.textViewTopVerticalSpaceConstraint withConstant:textViewFrameInsets.top];
    [self zhc_updateConstraint:self.textViewBottomVerticalSpaceConstraint withConstant:textViewFrameInsets.bottom];
    [self zhc_updateConstraint:self.textViewAvatarHorizontalSpaceConstraint withConstant:textViewFrameInsets.right];
    [self zhc_updateConstraint:self.textViewMarginHorizontalSpaceConstraint withConstant:textViewFrameInsets.left];
     [self updateConstraints];
}

-(void)setMediaView:(UIView *)mediaView withisOutgoingMessage:(BOOL )isOutgoingMessage
{
    [self.messageBubbleImageView removeFromSuperview];
    [self.textView removeFromSuperview];
    
    [mediaView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.messageBubbleContainerView addSubview:mediaView];
    
    [self.messageBubbleContainerView zhc_pinSubview:mediaView toEdge:NSLayoutAttributeBottom withConstant:-2.0f];
    [mediaView zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:CGRectGetHeight(mediaView.frame)];
    [mediaView zhc_pinSelfToEdge:NSLayoutAttributeWidth withConstant:CGRectGetWidth(mediaView.frame)];
    if (isOutgoingMessage) {
        [self.messageBubbleContainerView zhc_pinSubview:mediaView toEdge:NSLayoutAttributeTrailing withConstant:-2.0f];
    }else{
        [self.messageBubbleContainerView zhc_pinSubview:mediaView toEdge:NSLayoutAttributeLeading withConstant:2.0f];
    }
    _mediaView = mediaView;
    
    //  because of cell re-use (and caching media views, if using built-in library media item)
    //  we may have dequeued a cell with a media view and add this one on top
    //  thus, remove any additional subviews hidden behind the new media view
    ZHCWeakSelf;
    dispatch_async(dispatch_get_main_queue(), ^{
        for (NSUInteger i = 0; i < self.messageBubbleContainerView.subviews.count; i++) {
            if (weakSelf.messageBubbleContainerView.subviews[i] != _mediaView) {
                [weakSelf.messageBubbleContainerView.subviews[i] removeFromSuperview];
            }
        }
    });
     [self updateConstraints];

}

#pragma mark - Getters
- (CGSize)avatarViewSize
{
    return CGSizeMake(self.avatarContainerViewWidthConstraint.constant,
                      self.avatarContainerViewHeightConstraint.constant);
}

- (UIEdgeInsets)textViewFrameInsets
{
    return UIEdgeInsetsMake(self.textViewTopVerticalSpaceConstraint.constant,
                            self.textViewMarginHorizontalSpaceConstraint.constant,
                            self.textViewBottomVerticalSpaceConstraint.constant,
                            self.textViewAvatarHorizontalSpaceConstraint.constant);
}





#pragma mark - Utilities

- (void)zhc_updateConstraint:(NSLayoutConstraint *)constraint withConstant:(CGFloat)constant
{
    if (constraint.constant == constant) {
        return;
    }
    constraint.constant = constant;
}


#pragma mark - Gesture recognizers
-(void) zhc_handleTapGesture:(UITapGestureRecognizer *)tap
{
    CGPoint touchPt = [tap locationInView:self];
    if (CGRectContainsPoint(self.avatarContainerView.frame, touchPt)) {
        [self.delegate messagesTableViewCellDidTapAvatar:self];
    }
    else if (CGRectContainsPoint(self.messageBubbleContainerView.frame, touchPt)) {
        [self.delegate messagesTableViewCellDidTapMessageBubble:self];
    }
    else {
        [self.delegate messagesTableViewCellDidTapCell:self atPosition:touchPt];
    }

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint touchPt = [touch locationInView:self];
    
    if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
        return CGRectContainsPoint(self.messageBubbleContainerView.frame, touchPt);
    }
    
    return NO;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
