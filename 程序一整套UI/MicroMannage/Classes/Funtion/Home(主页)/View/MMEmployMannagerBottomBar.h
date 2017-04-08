//
//  MMEmployMannagerBottomBar.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectAll)(bool state);
typedef void(^deleteBtnClick)();
@interface MMEmployMannagerBottomBar : UIView
@property(nonatomic,copy)selectAll selectAllBlock;
@property(nonatomic,copy)deleteBtnClick deleteBtnClickBlock;

-(void)setSelectAllBlock:(selectAll)selectAllBlock;
-(void)setDeleteBtnClickBlock:(deleteBtnClick)deleteBtnClickBlock;
-(void)setSelectAllBlock:(selectAll)selectAllBlock DeleteBtnClickBlock:(deleteBtnClick)deleteBtnClickBlock;
@end
