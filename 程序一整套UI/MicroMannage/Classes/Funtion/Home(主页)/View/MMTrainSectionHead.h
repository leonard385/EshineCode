//
//  MMTrainSectionHead.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^dropBtnClick)(BOOL isdrop);
@interface MMTrainSectionHead : UITableViewHeaderFooterView
@property(nonatomic,strong)NSString *title;
@property(nonatomic,assign)BOOL dropState;
@property(nonatomic,copy)dropBtnClick dropBtnClickBlock;

-(void)setDropBtnClickBlock:(dropBtnClick)dropBtnClickBlock;
@end
