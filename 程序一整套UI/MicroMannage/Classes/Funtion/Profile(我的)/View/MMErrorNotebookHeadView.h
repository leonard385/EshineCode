//
//  MMErrorNotebookHeadView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/9.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ENpraticeClick)();
typedef void(^ENexamClick)();
@interface MMErrorNotebookHeadView : UIView
@property(nonatomic,copy)ENpraticeClick ENpraticeClickBlock;
@property(nonatomic,copy)ENexamClick ENexamClickBlock;

@property(nonatomic,strong)NSString *num;

-(void)setENexamClickBlock:(ENexamClick)ENexamClickBlock;
-(void)setENpraticeClickBlock:(ENpraticeClick)ENpraticeClickBlock;
-(void)setENpraticeClickBlock:(ENpraticeClick)ENpraticeClickBlock examClickBlock:(ENexamClick)ENexamClickBlock;
@end
