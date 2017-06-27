//
//  WBSPopShareView.h
//  WEIBOShareDemo
//
//  Created by 赚发2 on 16/7/5.
//  Copyright © 2016年 fengwang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^handleShare)(UIButton *sender);

@interface WBSPopShareView : UIView

/**
 *  初始化方法
 *
 *  @param frame   frame
 *  @param images  图标数组
 *  @param titles 标题数组(可以为空)
 *
 *  @return WBSPopShareView
 */
- (instancetype)initWithFrameWithFrame:(CGRect)frame images:(NSArray <NSString *> *)images titles:(NSArray <NSString *> *)titles;

/** 回调 block */
@property (nonatomic, copy) handleShare handleShareBlock;


@end
