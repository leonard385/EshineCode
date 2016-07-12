//
//  BallMovedView.h
//  ballMoved
//
//  Created by qianqian on 16/7/11.
//  Copyright © 2016年 qianqian. All rights reserved.


#import <UIKit/UIKit.h>
@class YXBallMovedView;

//小球竖直移动方向
typedef NS_ENUM(NSInteger, ViewVerticalMoveType) {
    viewVerticalMoveTypeTop = 0,
    viewVerticalMoveTypeBottom = 1,
    
};

//小球水平移动方向
typedef NS_ENUM(NSInteger, ViewHorizontalMoveType) {
    viewHorizontalMoveTypeRight = 0,
    viewHorizontalMoveTypeLeft = 1,
};

//self代理方法
@protocol YXBallMovedViewDelegate <NSObject>

- (void)YXBallMovedClick:(YXBallMovedView *)ballMovedView withDeltaTime:(NSInteger)deltaTime;

@end


@interface YXBallMovedView : UIView

/*
  自定义的小球图片
*/
@property (strong, nonatomic) UIImage *image;

/*
 显示自定义的小球计时时间的label
 */
@property (strong, nonatomic) UILabel *lbBallTime;

/*
 自定义的小球iv
 */
@property (strong, nonatomic) UIImageView *ivBall;

/*
 视图的代理方法
 */
@property (weak, nonatomic) id<YXBallMovedViewDelegate> delegate;

/*
 默认视图rect为全屏
 */
@property (assign, nonatomic) CGRect ballBgViewRect;

+ (instancetype)ballMovedView;

@end
