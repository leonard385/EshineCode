//
//  MMEmployInfoInputController.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^returnInput)(NSString *content);
@interface MMEmployInfoInputController : UIViewController
@property(nonatomic,strong)NSString *navTitle;
@property(nonatomic,copy)returnInput returnInputBlock;

-(void)setReturnInputBlock:(returnInput)returnInputBlock;
@end
