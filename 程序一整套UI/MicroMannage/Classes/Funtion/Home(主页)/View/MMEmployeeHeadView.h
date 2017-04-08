//
//  MMEmployeeHeadView.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^EHBtnClick)(NSUInteger idx);
@interface MMEmployeeHeadView : UIView

@property(nonatomic,strong)NSString *headTitle;
@property(nonatomic,strong)NSString *totalNum;
@property(nonatomic,strong)NSString *leaveNum;
@property(nonatomic,strong)NSString *addNum;

@property(nonatomic,copy)EHBtnClick EHBtnClickBlock;

-(void)setEHBtnClickBlock:(EHBtnClick)EHBtnClickBlock;
@end
