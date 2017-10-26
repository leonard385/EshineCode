//
//  UIButton+block.m
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/24.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "UIButton+block.h"
#import <objc/objc-runtime.h>
static const void *associatedKey = "associatedKey";
@implementation UIButton (block)

-(void)setBtnClickBlock:(btnClick)btnClickBlock{
    objc_setAssociatedObject(self, associatedKey, btnClickBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self removeTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    if(btnClickBlock){
        [self addTarget:self action:@selector(cusBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(btnClick)btnClickBlock{
    return  objc_getAssociatedObject(self, associatedKey);
}

-(void)cusBtnClick{
    self.btnClickBlock ? self.btnClickBlock():nil;
}
@end
