//
//  MMExamPromotView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cancleClick)();
typedef void(^confirmClick)();
typedef void(^cheakClick)();
@interface MMExamPromotView : UIView
@property(nonatomic,strong)NSString *remainNum;
@property(nonatomic,copy)cancleClick cancleClickBlock;
@property(nonatomic,copy)confirmClick confirmClickBlock;
@property(nonatomic,copy)cheakClick cheakClickBlock;


-(void)setCancleClickBlock:(cancleClick)cancleClickBlock;
-(void)setConfirmClickBlock:(confirmClick)confirmClickBlock;
-(void)setCheakClickBlock:(cheakClick)cheakClickBlock;

-(void)setCancleClickBlock:(cancleClick)cancleClickBlock ConfirmClickBlock:(confirmClick)confirmClickBlock CheakClickBlock:(cheakClick)cheakClickBlock;


@end
