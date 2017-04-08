//
//  WLPopUpMenuButton.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/25.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "WLPopUpMenuButton.h"

@interface WLPopUpMenuButton()
@property(nonatomic,strong)UIView *bgGroundView;
@property(nonatomic,assign)BOOL isShow;
@property(nonatomic,strong)WLPupUpBtnItem *subBtns;
@end

@implementation WLPopUpMenuButton
- (instancetype)initWithFrame:(CGRect)frame Items:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        _isShow = NO;
        [self PUSetUpSubviews];
    }
    return self;
}

-(void)PUSetUpSubviews{
    //btnItemsInit
    
    
    //background init and tapped
    _bgGroundView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight)];
    _bgGroundView.backgroundColor = [UIColor clearColor];
    _bgGroundView.opaque = NO;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PUBackgroundTapped:)];
    [_bgGroundView addGestureRecognizer:gesture];
}

#pragma mark - 背景视图点击
-(void)PUBackgroundTapped:(UIGestureRecognizer *)recognizer{
   
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
