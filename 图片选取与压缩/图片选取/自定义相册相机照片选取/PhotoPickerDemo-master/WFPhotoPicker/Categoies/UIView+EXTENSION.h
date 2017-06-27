//
//  UIView+DESIGNABLE.h
//  BESIGNABLE
//
//  Created by 123 on 16/5/22.
//  Copyright © 2016年 asura. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, BBTSide) {
    BBTSideTopLeft         = 1 << 0,
    BBTSideTopRight        = 1 << 1,
    BBTSideBottomLeft      = 1 << 2,
    BBTSideBottomRight     = 1 << 3,
    BBTSideAll             = 0xffff
};

IB_DESIGNABLE

@interface UIView (EXTENSION)

//IB
@property (nonatomic, assign) IB_DESIGNABLE CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable CGFloat defineValue;
@property (nonatomic, assign) IBInspectable UIColor *borderColor;

/** 坐标 **/
//originX
@property (nonatomic) CGFloat originX;

//originY
@property (nonatomic) CGFloat originY;

//originX + width
@property (nonatomic) CGFloat rightX;

//originY + height
@property (nonatomic) CGFloat bottomY;

//originY
@property (nonatomic) CGFloat width;

//height
@property (nonatomic) CGFloat height;

//centerX
@property (nonatomic) CGFloat centerX;

//centerY
@property (nonatomic) CGFloat centerY;

//origin
@property (nonatomic) CGPoint origin;

//size
@property (nonatomic) CGSize size;

// 移除此view上的所有子视图
- (void)removeAllSubviews;

//获取视图所在的 UIViewController
- (UIViewController *)viewController;
/**
 *  切圆角
 *
 *  @param side    圆角的位置
 *  @param spacing 切得大小
 */
- (void)roundWithSide:(BBTSide)side spacing:(CGFloat)spacing;

@end
