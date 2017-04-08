//
//  MMExamModel.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/18.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMExamContentModel.h"
#import "MMExamAnlysisModel.h"
@interface MMExamModel : NSObject
@property(nonatomic,strong)MMExamContentModel *content;
@property(nonatomic,strong)MMExamAnlysisModel *anlysis;
@end
