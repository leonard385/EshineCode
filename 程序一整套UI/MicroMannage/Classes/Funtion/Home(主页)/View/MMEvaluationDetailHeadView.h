//
//  MMEvaluationDetailHeadView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMEvaluationDetailHeadView : UIView
-(void)setTotal:(NSString *)total Pass:(NSString*)pass Avg:(NSString *)avg High:(NSString *)high;
-(void)redraw;//绘制图形
@end
