//
//  MMSDropMenu.h
//  MSS
//
//  Created by 逸信Mac on 16/1/20.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DMSelect)(NSString * Title);
typedef void(^DMDelect)(NSString * Title);
typedef void(^DMBackGroundClick)();
@interface MMSDropMenu : UIView
@property(nonatomic,strong)NSArray *TitleArray;

@property(nonatomic,copy)DMSelect DMSelectBlock;
@property(nonatomic,copy)DMDelect DMDelectBlock;

@property(nonatomic,copy)DMBackGroundClick DMBackGroundClickBlock;


-(void)setDMSelectBlock:(DMSelect)DMSelectBlock;
-(void)setDMDelectBlock:(DMDelect)DMDelectBlock;
-(void)setDMBackGroundClickBlock:(DMBackGroundClick)DMBackGroundClickBlock;


-(void)setSelectBlock:(DMSelect)DMSelectBlock DelectBlock:(DMDelect)DMDelectBlock BackGroundClickBlock:(DMBackGroundClick)DMBackGroundClickBlock;

-(void)DpOpenMenu;
-(void)DpCloseMenu;
@end
