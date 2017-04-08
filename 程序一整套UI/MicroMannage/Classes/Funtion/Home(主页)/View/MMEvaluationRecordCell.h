//
//  MMEvaluationRecordCell.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMEvaluationRecordModel.h"
@interface MMEvaluationRecordCell : UITableViewCell
@property (nonatomic,strong)UIView *cellLine;
@property(nonatomic,strong)MMEvaluationRecordModel *cellModel;
@end
