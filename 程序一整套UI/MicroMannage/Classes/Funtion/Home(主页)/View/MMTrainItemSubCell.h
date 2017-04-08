//
//  MMTrainItemSubCell.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMTrainItemFileFrame.h"
@interface MMTrainItemSubCell : UITableViewCell

@property(nonatomic,assign)NSUInteger index;
@property(nonatomic,strong)MMTrainItemFileFrame *frameModel;
@end
