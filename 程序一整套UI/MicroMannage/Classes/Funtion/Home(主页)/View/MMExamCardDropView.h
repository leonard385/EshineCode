//
//  MMExamCardDropView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^didSelectItemAtIndexBlock)(NSUInteger index);
@interface MMExamCardDropView : UIView
@property(nonatomic,assign)NSUInteger totalNum;//题目总数
@property(nonatomic,assign)CGRect bgframe;
@property(nonatomic,copy)didSelectItemAtIndexBlock didSelectItemAtIndex;

-(void)setItemAtIndex:(NSUInteger)idex withType:(ExamCardCellType)type;
-(void)showMenu;
-(void)hidenMenu;

-(void)setDidSelectItemAtIndex:(didSelectItemAtIndexBlock)didSelectItemAtIndex;
@end
