//
//  MMWorkDetailHeadModel.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMWorkDetailHeadModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *headImageUrl;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *taskTime;
@property(nonatomic,strong)NSString *taskDate;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSArray *images;
@end
