//
//  WBSPopShareView.m
//  WEIBOShareDemo
//
//  Created by 赚发2 on 16/7/5.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import "WBSPopShareView.h"
#import "UIButton+BBTButton.h"
#import "UIView+EXTENSION.h"

static NSUInteger const linesSpacing = 10;
static NSUInteger const columnSpacing = 20;

@interface WBSPopShareView ()
{
    /** 上部预留 view */
    UIView *_topView;
    /** 容器 view */
    UIView *_contentView;
    /** 操作 view */
    UIView *_operationView;
    /** 图片数组 */
    NSArray *_images;
    /** 标题数组 */
    NSArray *_titles;
    /** 分享 button 宽 */
    CGFloat _buttonWidth;
    /** 分享 button 高 */
    CGFloat _buttonHeight;
    /** 取消按钮 */
    UIButton *_cancleButton;

}
/** 存放 button 的数组 */
@property (nonatomic, strong) NSMutableArray *buttons;


@end

@implementation WBSPopShareView

- (NSMutableArray *)buttons{
    if (!_buttons) {
        self.buttons = [NSMutableArray array];
    }
    return _buttons;
}

-  (instancetype)initWithFrameWithFrame:(CGRect)frame images:(NSArray<NSString *> *)images titles:(NSArray<NSString *> *)titles{
    self = [super initWithFrame:frame];
    if (self) {
        _images = images;
        _titles = titles;
        [self confguireSubViews];
        [self showWBSPopShareView];
    }
    return self;
}

#pragma mark - 配置子视图 -
- (void)confguireSubViews{
    
    //self
    self.alpha = 0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dissmissTapGesture)];
    [self addGestureRecognizer:tapGesture];
    
    //毛玻璃
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    visualEffectView.frame = self.bounds;
    [self addSubview:visualEffectView];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:visualEffectView.frame];
    [visualEffectView addSubview:backgroundView];
    backgroundView.alpha = 0.95f;
    
    //_contentView
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height / 2 - 30, self.width, self.height / 2)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    
    //_operationView
    _operationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 30, self.width, 30)];
    _operationView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_operationView];
    
    //_topView
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height / 2 - 30)];
    _topView.backgroundColor = [UIColor clearColor];
    [self addSubview:_topView];
    
    //底部关闭的 button
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleButton = cancleButton;
    cancleButton.frame = CGRectMake(_operationView.width / 2 - _operationView.height / 2, 0, _operationView.height, _operationView.height);
    [cancleButton setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close"] forState:UIControlStateNormal];
    [_operationView addSubview:cancleButton];
    [cancleButton addTarget:self action:@selector(dissmissSelf:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加分享按钮
    [self addShareButtons];
}

- (void)addShareButtons{
    
    CGFloat buttonWidth = (self.width - 4 * linesSpacing) / 3;
    CGFloat buttonHeight = buttonWidth;
    _buttonWidth = buttonWidth;
    _buttonHeight = buttonHeight;
    
    int index = 0;
    
    for (int i = 0; i < _images.count; i ++) {
        
        UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        index = i;
        if (i >= 3) {
            index -= 3;
        }
        shareButton.frame = CGRectMake(linesSpacing + (linesSpacing + buttonWidth) * index, _contentView.height, buttonWidth, buttonHeight);
        [_contentView addSubview:shareButton];
        
        shareButton.titleLabel.font = [UIFont systemFontOfSize:14];
        shareButton.adjustsImageWhenHighlighted = NO;
        [shareButton addTarget:self action:@selector(handleDownAction:) forControlEvents:UIControlEventTouchDown];
        [shareButton addTarget:self action:@selector(handleUpInsidAction:) forControlEvents:UIControlEventTouchUpInside];
        [shareButton addTarget:self action:@selector(handleDragAction:) forControlEvents:UIControlEventTouchDragOutside];
        
        [shareButton setImage:[UIImage imageNamed:_images[i]] forState:UIControlStateNormal];
        
        [self.buttons addObject:shareButton];
        shareButton.tag = i + 100;
        if (_titles.count != 0 || _titles != nil) {
            //如果是图文,重新布局
            [shareButton setTitle:_titles[i] forState:UIControlStateNormal];
            [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [shareButton layoutButtonWithEdgeInsetsStyle:UKButtonEdgeInsetsStyleTop imageTitleSpace:3];
        }
    }
}

#pragma mark - show and dissmiss -

- (void)showWBSPopShareView{
    
    int index = 0;
    for (int i = 0; i < _buttons.count; i ++) {
        
        UIButton *shareButton = _buttons[i];
        
        NSInteger count = i / 3;
        index = i;
        if (i >= 3) {
            index -= 3;
        }
        
        //shareButton 动画
        [UIView animateWithDuration:0.6 delay:i * 0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            shareButton.originY = columnSpacing + (columnSpacing + _buttonHeight) * count;
        } completion:^(BOOL finished) {
           
        }];
        //背景动画
        [UIView animateWithDuration:0.4 animations:^{
            self.alpha = 1;
        }];
    }
}

- (void)dissmissSelf:(UIButton *)sender{
    for (int i = 0; i < _buttons.count; i ++) {
        
        UIButton *shareButton = _buttons[i];
        
        [UIView animateWithDuration:0.6 delay:i * 0.1 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            shareButton.originY = _contentView.height;
        } completion:^(BOOL finished) {

        }];
        
    }
    //消失按钮动画
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @(M_PI_4);
    basicAnimation.duration = 0.3;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    [sender.layer addAnimation:basicAnimation forKey:@"rotation"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //背景动画
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) {
                [self removeFromSuperview];
            }
        }];
    });
}

#pragma mark - handle action -

- (void)handleDownAction:(UIButton *)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform tranform = CGAffineTransformMakeScale(1.3, 1.3);
        sender.transform = tranform;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)handleUpInsidAction:(UIButton *)sender{
    
    [UIView animateWithDuration:0.4 animations:^{
        CGAffineTransform tranform = CGAffineTransformMakeScale(1.8, 1.8);
        sender.transform = tranform;
        sender.alpha = 0;
        for (UIButton *shareButton in _buttons) {
            if (shareButton != sender) {
                CGAffineTransform tranform = CGAffineTransformMakeScale(0.3, 0.3);
                shareButton.transform = tranform;
            }
        }
    } completion:^(BOOL finished) {
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
            //消失按钮动画
            CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            basicAnimation.fromValue = @0;
            basicAnimation.toValue = @(M_PI_4);
            basicAnimation.duration = 0.2;
            basicAnimation.removedOnCompletion = NO;
            basicAnimation.fillMode = kCAFillModeForwards;
            [_cancleButton.layer addAnimation:basicAnimation forKey:@"rotation"];
            
        } completion:^(BOOL finished) {
            
            //回调
            _handleShareBlock ? _handleShareBlock(sender) : nil;
            
            [self removeFromSuperview];
        }];
    });
}

- (void)handleDragAction:(UIButton *)sender{
    [UIView animateWithDuration:0.2 animations:^{
        CGAffineTransform tranform = CGAffineTransformMakeScale(1, 1);
        sender.transform = tranform;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dissmissTapGesture{
    [self dissmissSelf:_cancleButton];
}

@end

