//
//  UPStackMenuItem.h
//  UPStackButtonDemo
//
//  Created by Paul Ulric on 21/01/2015.
//  Copyright (c) 2015 Paul Ulric. All rights reserved.
//

#import <UIKit/UIKit.h>

//位置
typedef enum {
    UPStackMenuItemLabelPosition_left = 0,
    UPStackMenuItemLabelPosition_right
} UPStackMenuItemLabelPosition_e;


@protocol UPStackMenuItemDelegate;


@interface UPStackMenuItem : UIView

@property (nonatomic, strong)            UIImage                         *image;
@property (nonatomic, strong)            UIImage                         *highlightedImage;
@property (nonatomic, strong)            NSString                        *title;
@property (nonatomic, readwrite)         UPStackMenuItemLabelPosition_e  labelPosition;

@property (nonatomic, unsafe_unretained) id<UPStackMenuItemDelegate>     delegate;

//初始化相关方法
- (id)initWithImage:(UIImage*)image;
- (id)initWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage title:(NSString*)title;
- (id)initWithImage:(UIImage*)image highlightedImage:(UIImage*)highlightedImage title:(NSString*)title font:(UIFont*)font;


- (void)expandAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration;//展开动画
- (void)reduceAnimated:(BOOL)animated withDuration:(NSTimeInterval)duration;//收缩动画

- (CGPoint)itemCenter;
- (CGPoint)centerForItemCenter:(CGPoint)itemCenter;

- (void)setTitleColor:(UIColor*)color;

@end


@protocol UPStackMenuItemDelegate <NSObject>
@optional
- (void)didTouchStackMenuItem:(UPStackMenuItem*)item;
@end
