//
//  ZHCMessagesMoreView.m
//  ZHChat
//
//  Created by aimoke on 16/8/26.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesMoreView.h"
#import "ZHCMessagesMoreItem.h"
#import "ZHCMessagesCommonParameter.h"
#import "UIView+ZHCMessages.h"

#ifndef ItemBeginTag 
#define ItemBeginTag 200
#endif

@interface ZHCMessagesMoreView()<UIScrollViewDelegate>
@property (copy, nonatomic) NSArray *titles;
@property (copy, nonatomic) NSArray *imageNames;

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSMutableArray *itemViews;
@property (assign, nonatomic) CGSize itemSize;
@end

@implementation ZHCMessagesMoreView


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
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = kZHCTopLineBackGroudColor;
    topLine.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:topLine];
    [self zhc_pinSubview:topLine toEdge:NSLayoutAttributeLeading withConstant:0.0f];
    [self zhc_pinSubview:topLine toEdge:NSLayoutAttributeTop withConstant:0.0f];
    [self zhc_pinSubview:topLine toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
    [topLine zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:1.0f];
    
    self.edgeInsets = UIEdgeInsetsMake(10, 10, 5, 10);
    self.itemViews = [NSMutableArray array];
    self.numberItemPerLine = 4;
    
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self zhc_pinInsets:self.edgeInsets withSubView:self.scrollView];
    [self zhc_pinSubview:self.pageControl toEdge:NSLayoutAttributeLeading withConstant:0.0f];
    [self zhc_pinSubview:self.pageControl toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
    [self zhc_pinSubview:self.pageControl toEdge:NSLayoutAttributeBottom withConstant:-10.0f];
    
    
}

#pragma mark - PublicMethods
-(void)reloadData
{
    CGFloat width = [UIApplication sharedApplication].keyWindow.frame.size.width;
    CGFloat height = [UIApplication sharedApplication].keyWindow.frame.size.height;
    CGFloat widthLimit = MIN(width, height);
     CGFloat itemWidth = (widthLimit - self.edgeInsets.left - self.edgeInsets.right) / self.numberItemPerLine;
    CGFloat itemHeight = kZHCMessagesFunctionViewHeight / 2;
    self.itemSize = CGSizeMake(itemWidth, itemHeight);
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(messagesMoreViewTitles:)]) {
        self.titles = [self.dataSource messagesMoreViewTitles:self];
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(messagesMoreViewImgNames:)]) {
         self.imageNames = [self.dataSource messagesMoreViewImgNames:self];
    }
    
    [self.itemViews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:nil];
    [self.itemViews removeAllObjects];
    [self setupItems];


}

- (void)setupItems {
    __block NSUInteger line = 0;   //line Number
    __block NSUInteger column = 0; //Column Number
    __block NSUInteger page = 0;
    [self.titles enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        if (column > 3) {
            line ++ ;
            column = 0;
        }
        if (line > 1) {
            line = 0;
            column = 0;
            page ++ ;
        }
        CGFloat width = [UIApplication sharedApplication].keyWindow.frame.size.width;
        CGFloat scrollViewWidth = width - self.edgeInsets.left - self.edgeInsets.right;
        CGFloat scrollViewHeight = kZHCMessagesFunctionViewHeight - self.edgeInsets.top - self.edgeInsets.bottom;
        CGFloat startX = column * self.itemSize.width + page * scrollViewWidth;
        CGFloat startY = line * self.itemSize.height;
        
         ZHCMessagesMoreItem *item = [[ZHCMessagesMoreItem alloc] initWithFrame:CGRectMake(startX, startY, self.itemSize.width, self.itemSize.height)];
        NSAssert(self.imageNames.count>idx, @"MessagesMoreView imageNames count is less than titles");
        [item setViewWithTitle:obj imgName:self.imageNames[idx]];
        item.tag = idx + ItemBeginTag;
        [item addTarget:self action:@selector(itemClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:item];
        [self.itemViews addObject:item];
        column ++;
        if (idx == self.titles.count - 1) {
            [self.scrollView setContentSize:CGSizeMake(scrollViewWidth * (page + 1), scrollViewHeight)];
            self.pageControl.numberOfPages = page + 1;
            *stop = YES;
        }
    }];
}

#pragma mark - UserInteraction
-(void)itemClickAction:(ZHCMessagesMoreItem *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messagesMoreView:selectedMoreViewItemWithIndex:)]) {
        [self.delegate messagesMoreView:self selectedMoreViewItemWithIndex:(sender.tag - ItemBeginTag)];
    }
}


#pragma mark - Setters
-(void)setDataSource:(id<ZHCMessagesMoreViewDataSource>)dataSource
{
    _dataSource = dataSource;
    [self reloadData];
}

-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self reloadData];
}

-(void)setNumberItemPerLine:(NSInteger)numberItemPerLine
{
    _numberItemPerLine = numberItemPerLine;
    [self reloadData];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.scrollView.backgroundColor = backgroundColor;
}


#pragma mark - Getters
-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
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
    }
    return _pageControl;
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
