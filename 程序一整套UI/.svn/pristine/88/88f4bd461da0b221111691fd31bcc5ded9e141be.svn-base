//
//  MMfilterSectionHead.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMFilterGroupModel.h"
typedef void(^sectionClick)(BOOL state);
typedef void(^sectionSeletedClick)(BOOL state);
@interface MMfilterSectionHead : UITableViewHeaderFooterView
@property(nonatomic,copy)sectionClick sectionClickBlock;
@property(nonatomic,copy)sectionSeletedClick sectionSeletedClickBlock;

@property(nonatomic,strong)MMFilterGroupModel *viewModel;
-(void)setSectionClickBlock:(sectionClick)sectionClickBlock;
-(void)setSectionSeletedClickBlock:(sectionSeletedClick)sectionSeletedClickBlock;
@end
