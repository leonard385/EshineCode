//
//  MMContantSectionHead.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMContantGrounpModel.h"
typedef void(^sectionClick)(BOOL state);
@interface MMContantSectionHead : UITableViewHeaderFooterView
@property(nonatomic,strong)UIView *cellLine;
@property(nonatomic,copy)sectionClick sectionClickBlock;
-(void)setSectionClickBlock:(sectionClick)sectionClickBlock;
@property(nonatomic,strong)MMContantGrounpModel *headModel;
@end
