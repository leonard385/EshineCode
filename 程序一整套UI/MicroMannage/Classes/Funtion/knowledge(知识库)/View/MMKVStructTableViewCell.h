//
//  MMKVStructTableViewCell.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMKVStructModel.h"
@interface MMKVStructTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView *verticalLine;//竖线
@property(nonatomic,strong)MMKVStructModel *cellModel;
-(void)SVsetTagViews:(NSArray *)tags;
@end
