//
//  AYBubbleView.h
//  AYBubbleView
//
//  Created by Andy on 16/4/2.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CleanMessageBlock)(BOOL);

@interface AYBubbleView : UIView

@property (nonatomic, copy) CleanMessageBlock cleanMessageBlock;
/**
 *  显示未读数Label
 */
@property (nonatomic, strong) UILabel *unReadLabel;
/**
 *  气泡颜色
 */
@property (nonatomic, strong) UIColor *bubbleColor;
/**
 *  拉伸系数，取值（0~1），系数越大，拉伸距离越长。
 */
@property (nonatomic, assign) CGFloat decayCoefficent;
/**
 *  初始化bubbleView
 *
 *  @param centerPoint 中心点坐标
 *  @param radius      半径
 *  @param superView   父视图
 *
 *  @return 实例对象
 */
- (instancetype)initWithCenterPoint:(CGPoint)centerPoint bubleRadius:(CGFloat)radius addToSuperView:(UIView *)superView;
- (void)hidenBubbleView;
- (void)showBubbleView;
@end
