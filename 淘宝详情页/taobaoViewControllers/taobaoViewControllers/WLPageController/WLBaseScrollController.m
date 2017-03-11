//
//  ParentClassScrollViewController.m
//  Kitchen
//
//  Created by su on 16/7/8.
//  Copyright © 2016年 susu. All rights reserved.
//
#import <objc/runtime.h>
#import "WLBaseScrollController.h"
@interface WLBaseScrollController()<UIGestureRecognizerDelegate>

@end

@implementation WLBaseScrollController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BSAcceptMsg:) name:k_goTopNotice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(BSAcceptMsg:) name:k_leaveTopNotice object:nil];
}

-(void)BSAcceptMsg : (NSNotification *)notification{
    NSString *notificationName = notification.name;
    if ([notificationName isEqualToString:k_goTopNotice]) {
        NSDictionary *userInfo = notification.userInfo;
        NSString *canScroll = userInfo[@"canScroll"];
        if ([canScroll isEqualToString:@"1"]) {
            self.canScroll = YES;
            self.scrollView.showsVerticalScrollIndicator = YES;
        }
    }else if([notificationName isEqualToString:k_leaveTopNotice]){
        self.scrollView.contentOffset = CGPointZero;
        self.canScroll = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    if (!self.canScroll) { //如果Scroller不能移动 固定content防止bound现象
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:k_leaveTopNotice object:nil userInfo:@{@"canScroll":@"1"}];
    }
}


-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.scrollView.contentOffset.x == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
