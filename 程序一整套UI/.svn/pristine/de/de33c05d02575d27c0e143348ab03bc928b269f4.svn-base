//
//  MMTainTableHeadView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTrainHeadFrameModel.h"
typedef void(^dropClick)(BOOL dropState);
@interface MMTainTableHeadView : UIView
@property(nonatomic,assign,getter=isDrop)BOOL drop;
@property(nonatomic,strong)MMTrainHeadFrameModel *frameModel;

@property(nonatomic,copy)dropClick dropClickBlock;
-(void)setDropClickBlock:(dropClick)dropClickBlock;
@end
