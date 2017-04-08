//
//  MMFilterGroupModel.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMFilterGroupModel : NSObject
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSArray *friends;
@property(nonatomic,assign)BOOL isDrop;
@property(nonatomic,assign)BOOL isSelected;//是否选中
@end
