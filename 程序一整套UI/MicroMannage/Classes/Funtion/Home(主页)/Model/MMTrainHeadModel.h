//
//  MMTrainHeadModel.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMTrainHeadModel : NSObject
@property(nonatomic,strong)NSString *posterImageUrl;
@property(nonatomic,strong)NSString *headImageUrl;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSArray *images;
@end
