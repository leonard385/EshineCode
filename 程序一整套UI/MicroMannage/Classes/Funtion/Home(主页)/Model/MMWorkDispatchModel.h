//
//  MMWorkDispatchModel.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMWorkDispatchModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *subTitle;
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSNumber *progress;
@property(nonatomic,strong)NSNumber *taskType;
@end
