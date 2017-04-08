//
//  MMmyTainOfflineHead.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cardClick)();
typedef void(^mapClick)();
typedef void(^relocClick)();
@interface MMmyTainOfflineHead : UIView
@property(nonatomic,strong)NSString *addr;
@property(nonatomic,strong)NSString *headUrl;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *time;

@property(nonatomic,copy)cardClick cardClickBlock;
@property(nonatomic,copy)mapClick mapClickBlock;
@property(nonatomic,copy)relocClick relocClickBlock;

-(void)adjustTimeToNow;

-(void)setCardClickBlock:(cardClick)cardClickBlock;
-(void)setMapClickBlock:(mapClick)mapClickBlock;
-(void)setRelocClickBlock:(relocClick)relocClickBlock;
@end
