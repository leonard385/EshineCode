//
//  UIButton+block.h
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/24.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnClick)();
@interface UIButton (block)
@property(nonatomic,copy)btnClick btnClickBlock;

-(void)setBtnClickBlock:(btnClick)btnClickBlock;
@end
