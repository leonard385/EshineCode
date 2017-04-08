//
//  MMTrainItemFileFrame.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MMTrainItemFileModel.h"
@interface MMTrainItemFileFrame : NSObject
@property(nonatomic,assign)CGRect iconFrame;
@property(nonatomic,assign)CGRect contentFrame;
@property(nonatomic,assign)CGFloat cellHeight;

@property(nonatomic,strong)MMTrainItemFileModel *cellModel;

- (instancetype)initWithSuperViewWidth:(CGFloat)width;
@end
