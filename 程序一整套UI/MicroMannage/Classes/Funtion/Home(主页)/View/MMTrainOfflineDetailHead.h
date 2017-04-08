//
//  MMTrainOfflineDetailHead.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTrainOfflineHeadFrame.h"
@protocol TOMenuDelegate  <NSObject>
-(void)TOMenuBtnClick:(NSInteger)idex;
@end
typedef void(^dropClick)(BOOL dropState);
typedef void(^qrCodeClick)();
@interface MMTrainOfflineDetailHead : UIView
@property(nonatomic,assign,getter=isDrop)BOOL drop;
@property(nonatomic,strong)MMTrainOfflineHeadFrame *frameModel;

@property(nonatomic,copy)dropClick dropClickBlock;
@property(nonatomic,copy)qrCodeClick qrCodeClickBlock;
@property(nonatomic,weak)id <TOMenuDelegate> delegate;
-(void)setDropClickBlock:(dropClick)dropClickBlock;

-(void)setQrCodeClickBlock:(qrCodeClick)qrCodeClickBlock;
@end
