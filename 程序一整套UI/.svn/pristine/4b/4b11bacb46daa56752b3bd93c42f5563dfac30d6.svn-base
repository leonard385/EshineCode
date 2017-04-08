//
//  MMHomeHeadView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMHomeHeadView : UIView
typedef void(^ADClick)(NSUInteger idx);
typedef void(^FuncBtnClick)(NSUInteger idx);
@property(nonatomic,copy)ADClick ADClickBlock;
@property(nonatomic,copy)FuncBtnClick FuncBtnClickBlock;

@property(nonatomic,copy)NSArray *ADImagePaths;//广告图片地址
-(instancetype)initWithItems:(NSArray *)array Frame:(CGRect)frame;

-(void)setADClickBlock:(ADClick)ADClickBlock;
-(void)setFuncBtnClickBlock:(FuncBtnClick)FuncBtnClickBlock;
-(void)setADClickBlock:(ADClick)ADClickBlock FuncBtnClickBlock:(FuncBtnClick)FuncBtnClickBlock;
@end
