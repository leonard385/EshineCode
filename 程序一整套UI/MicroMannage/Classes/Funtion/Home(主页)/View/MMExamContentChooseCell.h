//
//  MMExamContentChooseCell.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMExamContentChooseCell : UITableViewCell
@property (nonatomic,strong)UIView *cellLine;
@property (nonatomic,strong)NSString *chooseStr;
@property (nonatomic,strong)NSString *chooseContent;
-(void)setChooseStr:(NSString *)chooseStr ChooseContent:(NSString *)chooseContent;
@end
