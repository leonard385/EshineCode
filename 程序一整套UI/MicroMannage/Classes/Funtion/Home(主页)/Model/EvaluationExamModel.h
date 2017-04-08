//
//  EvaluationExamModel.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/15.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluationExamModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subTitle;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSNumber *attendNum;
@property(nonatomic,strong)NSNumber *isComplete;
@end
