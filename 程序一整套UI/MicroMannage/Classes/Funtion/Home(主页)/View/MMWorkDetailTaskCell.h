//
//  MMWorkDetailTaskCell.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDetailTaskFrame.h"

typedef void(^chatClick)();
typedef void(^completeClick)(UIButton *sender);
typedef void(^showAllClick)(BOOL isShowAll);

@interface MMWorkDetailTaskCell : UITableViewCell
@property(nonatomic,strong)MMDetailTaskFrame *frameModel;
@property(nonatomic,assign)NSUInteger taskIdex;

@property(nonatomic,copy)chatClick chatClickBlock;
@property(nonatomic,copy)completeClick completeClickBlock;
@property(nonatomic,copy)showAllClick showAllClickBlock;

-(void)setChatClickBlock:(chatClick)chatClickBlock;
-(void)setCompleteClickBlock:(completeClick)completeClickBlock;
-(void)setShowAllClickBlock:(showAllClick)showAllClickBlock;

-(void)setChatClickBlock:(chatClick)chatClickBlock CompleteClickBlock:(completeClick)completeClickBlock ShowAllClickBlock:(showAllClick)showAllClickBlock;
@end
