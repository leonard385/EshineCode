//
//  MMExamBottomBar.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^timeOut)();
typedef void(^handInClick)();
typedef void(^collectClick)(UIButton *sender);
typedef void(^cardClick)();
@interface MMExamBottomBar : UIView
@property(nonatomic,copy)timeOut timeOutEventBlock;//时间到
@property(nonatomic,copy)handInClick handInClickBlock;//交卷按钮点击
@property(nonatomic,copy)collectClick collectClickBlock;//收藏点击
@property(nonatomic,copy)cardClick cardClickBlock;//答题卡点击

@property(nonatomic,assign)CGFloat progress;//进度条

-(void)setTimeOutEventBlock:(timeOut)timeOutEventBlock;
-(void)setHandInClickBlock:(handInClick)handInClickBlock;
-(void)setCollectClickBlock:(collectClick)collectClickBlock;
-(void)setCardClickBlock:(cardClick)cardClickBlock;
@end
