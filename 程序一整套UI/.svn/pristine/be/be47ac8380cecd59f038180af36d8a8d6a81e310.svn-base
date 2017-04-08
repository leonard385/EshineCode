//
//  MMfilterTableCell.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMFilterFriendModel.h"
typedef void(^selectBtnClick)(BOOL state);
@interface MMfilterTableCell : UITableViewCell
@property(nonatomic,copy)selectBtnClick selectBtnClickBlock;
@property(nonatomic,strong)MMFilterFriendModel *cellModel;

-(void)setSelectBtnClickBlock:(selectBtnClick)selectBtnClickBlock;
@end
