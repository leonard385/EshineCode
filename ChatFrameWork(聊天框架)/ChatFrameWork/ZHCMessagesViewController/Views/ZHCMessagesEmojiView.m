//
//  ZHCMessagesEmojiView.m
//  ZHChat
//
//  Created by aimoke on 16/8/29.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesEmojiView.h"
#import "NSArray+ZHCMessages.h"
#import "ZHCMessagesCommonParameter.h"
#import "UIView+ZHCMessages.h"
#import "UIImage+ZHCMessages.h"
#import "NSBundle+ZHCMessages.h"
#import "ZHCMessagesToolbarButtonFactory.h"


static const CGFloat EmojiWidth = 50;
static const CGFloat EmojiHeight = 50;
static const CGFloat EmojiFontSize = 30;

@interface ZHCMessagesEmojiView ()<UIScrollViewDelegate>
/**
 *  All emoji characters
 */
@property (nonatomic, strong) NSArray *emojis;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;
@property (strong, nonatomic) NSMutableArray *emojiViews;
@property (assign, nonatomic) NSInteger emojiRowsNum;
@end

@implementation ZHCMessagesEmojiView
#pragma mark - Initialization
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialSubViews];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initialSubViews];
}


#pragma mark - InitialSubViews
-(void)initialSubViews
{
    _emojiRowsNum = 3;
    CGFloat scrollHeight = _emojiRowsNum * EmojiHeight;
    CGFloat top = 5.0;
    CGFloat bottom = kZHCMessagesFunctionViewHeight - scrollHeight - top;
    
    self.edgeInsets = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.emojiViews = [NSMutableArray array];
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = kZHCTopLineBackGroudColor;
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:topLine];
    [self zhc_pinSubview:topLine toEdge:NSLayoutAttributeLeading withConstant:0.0f];
    [self zhc_pinSubview:topLine toEdge:NSLayoutAttributeTop withConstant:0.0f];
    [self zhc_pinSubview:topLine toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
    [topLine zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:1.0f];
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self addSubview:self.bottomView];
    _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    _pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    _bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self zhc_pinInsets:self.edgeInsets withSubView:self.scrollView];
    
    [self zhc_pinSubview:self.pageControl toEdge:NSLayoutAttributeLeading withConstant:0.0f];
    [self zhc_pinSubview:self.pageControl toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_pageControl attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_scrollView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    [self.pageControl zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:20.0f];
    
    [self zhc_pinSubview:self.bottomView toEdge:NSLayoutAttributeLeading withConstant:0.0f];
    [self zhc_pinSubview:self.bottomView toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
    [self zhc_pinSubview:self.bottomView toEdge:NSLayoutAttributeBottom withConstant:0.0f];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_bottomView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_pageControl attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    self.emojis = [NSArray zhc_getEmojis];
    
    

}

#pragma mark - PublicMethods
-(void)reloadData
{
    [self.emojiViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat width = [UIApplication sharedApplication].keyWindow.frame.size.width;
    CGFloat height = [UIApplication sharedApplication].keyWindow.frame.size.height;
    CGFloat widthLimit = MIN(width, height);
    CGFloat scrollViewWidth = widthLimit - self.edgeInsets.left - self.edgeInsets.right;
    NSInteger rowNum = self.emojiRowsNum;
    CGFloat scrollViewHeight = kZHCMessagesFunctionViewHeight - self.edgeInsets.top - self.edgeInsets.bottom;
    NSInteger colNum = (scrollViewWidth / EmojiWidth);
    NSInteger numOfPage = ceil((float)[self.emojis count] / (float)(rowNum * colNum));
    [self.scrollView setContentSize:CGSizeMake(scrollViewWidth * numOfPage, scrollViewHeight)];
    self.pageControl.numberOfPages = numOfPage;
    
    CGFloat beginX = (scrollViewWidth - colNum * EmojiWidth)/2.0;
    if (rowNum == 0 && colNum == 0) {
        return;
    }
    // add emojis
    NSInteger row = 0;
    NSInteger column = 0;
    NSInteger page = 0;
    NSInteger emojiPointer = 0;
    for (int i = 0; i < [self.emojis count] + numOfPage - 1; i++) {
        
        // Pagination
        if (i % (rowNum * colNum) == 0) {
            page ++;    // Increase the number of pages
            row = 0;    // the number of lines is 0
            column = 0; // the number of columns is 0
        }else if (i % colNum == 0) {
            // NewLine
            row += 1;   // Increase the number of lines
            column = 0; // The number of columns is 0
        }
        
        CGRect currentRect = CGRectMake(((page-1) * scrollViewWidth) + (column * EmojiWidth) + beginX,
                                        row * EmojiHeight,
                                        EmojiWidth,
                                        EmojiHeight);
        
        if (row == (rowNum - 1) && column == (colNum - 1)) {
            // last position of page, add delete button
            
            ZHCEmojiDeleteButton *deleteButton = [ZHCEmojiDeleteButton buttonWithType:UIButtonTypeCustom];
            UIImage *image = [UIImage zhc_defaultEmptionDeleteImage];
            [deleteButton  setImage:image forState:UIControlStateNormal];
            deleteButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
            [deleteButton addTarget:self action:@selector(deleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            deleteButton.frame = currentRect;
            deleteButton.tintColor = [UIColor blackColor];
            [self.scrollView addSubview:deleteButton];
            [self.emojiViews addObject:deleteButton];
            
        }else{
            NSString *emoji = self.emojis[emojiPointer++];
            // init Emoji Button
            UIButton *emojiButton = [UIButton buttonWithType:UIButtonTypeCustom];
            emojiButton.titleLabel.font = [UIFont fontWithName:@"Apple color emoji" size:EmojiFontSize];
            [emojiButton setTitle:emoji forState:UIControlStateNormal];
            [emojiButton addTarget:self action:@selector(emojiButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            emojiButton.backgroundColor = [UIColor clearColor];
            
            emojiButton.frame = currentRect;
            [self.scrollView addSubview:emojiButton];
            
             [self.emojiViews addObject:emojiButton];
        }
        
        column++;
    }
    

}



#pragma mark - Setters

-(void)setEmojis:(NSArray *)emojis
{
    _emojis = emojis;
    [self reloadData];
}

#pragma mark - Getters
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor clearColor];

    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        _pageControl.hidesForSinglePage = YES;
        _pageControl.backgroundColor = [UIColor clearColor];
    }
    return _pageControl;
}


-(UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        UIView *topLine = [[UIView alloc] init];
        topLine.translatesAutoresizingMaskIntoConstraints = NO;
        topLine.backgroundColor = kZHCTopLineBackGroudColor;
        [_bottomView addSubview:topLine];
        [_bottomView zhc_pinSubview:topLine toEdge:NSLayoutAttributeLeading withConstant:0.0f];
        [_bottomView zhc_pinSubview:topLine toEdge:NSLayoutAttributeTop withConstant:0.0f];
        [_bottomView zhc_pinSubview:topLine toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
        [topLine zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:1.0f];
        
        UIButton *sendButton = [[[ZHCMessagesToolbarButtonFactory alloc]init]defaultSendButtonItem];
        sendButton.translatesAutoresizingMaskIntoConstraints = NO;
        [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:sendButton];
      
        
        [_bottomView zhc_pinSubview:sendButton toEdge:NSLayoutAttributeTop withConstant:2.0f];
        [_bottomView zhc_pinSubview:sendButton toEdge:NSLayoutAttributeBottom withConstant:-2.0f];
        [_bottomView zhc_pinSubview:sendButton toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
        [sendButton zhc_pinSelfToEdge:NSLayoutAttributeWidth withConstant:100.0f];
        self.sendButton = sendButton;
    }
    return _bottomView;
}



#pragma mark - UserInteraction

-(void)sendAction:(UIButton *)sender
{
    NSLog(@"send Action");
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiView:didPressSendButton:)]) {
        [self.delegate emojiView:self didPressSendButton:sender];
    }
}


-(void)deleteButtonPressed:(UIButton *)sender
{
    NSLog(@"delete Action");
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiView:didPressDeleteButton:)]) {
        [self.delegate emojiView:self didPressDeleteButton:sender];
    }
}

-(void)emojiButtonPressed:(UIButton *)sender
{
    NSLog(@"emoji:%@",sender.titleLabel.text);
    if (self.delegate && [self.delegate respondsToSelector:@selector(emojiView:didSelectEmoji:)]) {
        [self.delegate emojiView:self didSelectEmoji:sender.titleLabel.text];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.scrollView) {
        [self.pageControl setCurrentPage:scrollView.contentOffset.x / scrollView.frame.size.width];
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView == self.scrollView && !decelerate) {
        [self.pageControl setCurrentPage:scrollView.contentOffset.x / scrollView.frame.size.width];
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end


@implementation ZHCEmojiDeleteButton


@end
