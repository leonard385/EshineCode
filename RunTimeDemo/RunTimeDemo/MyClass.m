
//
//  MyClass.m
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/24.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "MyClass.h"
#import <objc/runtime.h>
@implementation MyClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)showAge{
    NSLog(@"Age: 24");
}


-(void)showName:(NSString *)name{
    NSLog(@"my name is %@",name);
}

-(void)showName:(NSString *)name andAge:(NSString *)age{
    NSLog(@"my name is %@ and age is %@",name,age);
}

-(float)getHeight{
    return 187.5;
}

-(NSString *)getIntro{
   return @"I'm a IOS developer";
}

@end
