//
//  MMNotebooksSwithCell.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/10.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ENswithChange)(bool state);
@interface MMNotebooksSwithCell : UITableViewCell
@property(nonatomic,strong)UIView *cellLine;
@property(nonatomic,copy)ENswithChange ENswithChangeBlock;

-(void)setENswithChangeBlock:(ENswithChange)ENswithChangeBlock;
@end
