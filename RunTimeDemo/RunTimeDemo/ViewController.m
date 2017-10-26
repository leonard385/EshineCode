//
//  ViewController.m
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/24.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "ViewController.h"
#import "MyClass.h"
#import "SonClass.h"
#include <objc/objc-class.h>
#import "UIButton+block.h"
#import "person.h"
#import "NSObject+KeyValues.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnCenter;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self VCDataRun];
}

-(void)VCDataRun{
    /**
     *  1.message机制
     *
     */
    MyClass *myclass = [MyClass new];
    //((void (*)(id, SEL))(void *)objc_msgSend)((id)myclass, sel_registerName("showAge"));
    //(void (*)(id, SEL)) objc_msgSend函数指针强制转换
    //调用无参数的函数方法
     ((void (*)(id, SEL))(void *)objc_msgSend)((id)myclass, sel_registerName("showAge"));
    //调用含参的函数方法
    ((void (*)(id, SEL,NSString *))(void *)objc_msgSend)((id)myclass, sel_registerName("showName:"),@"i'm runtime!");
    //多参数调用
    ((void (*)(id, SEL,NSString *,NSString*))(void *)objc_msgSend)((id)myclass, sel_registerName("showName:andAge:"),@"i'm runtime!",@"54");
    //返回值
    float height =  ((float (*)(id, SEL))(void *)objc_msgSend)((id)myclass, sel_registerName("getHeight"));
    NSLog(@"my height %.1f",height);
    //NSString返回类型
    NSString *intro = ((NSString* (*)(id, SEL))(void *)objc_msgSend)((id)myclass, sel_registerName("getIntro"));
    NSLog(@"intro: %@",intro);
    //message父类方法调用机制
    SonClass *sonClass = [SonClass new];
    ((void (*)(id, SEL))(void *)objc_msgSend)((id)sonClass, sel_registerName("showAge"));
    
    /**
     *  2. 实例
     */
    //2.1 实例 - 获取 所有变量/所有属性/所有方法/协议
    person *personOne = [person new];
    [personOne getAllIvars];
    [personOne getAllPropertys];
    [personOne getPropertysAndAttribute];
    [personOne getAllMethods];
    
    //2.2 协议
    unsigned int outNum = 0;
    Protocol * __unsafe_unretained *protocols = class_copyProtocolList([UITableView class], &outNum);
    for (unsigned int i = 0; i < outNum; i++) {
        Protocol *p = protocols[i];
        const char *name = protocol_getName(p);
        NSString *protocolName = [NSString stringWithUTF8String:name];
        NSLog(@"%@ have protocol Named : %@",NSStringFromClass([UITableView class]),protocolName);
    };
    
    //keyvalue 模型 <----> 字典相互转换
    NSDictionary *dic = @{
                          @"name" : @"ios developer",
                          @"age" : @(24),
                          @"sex" : @(0),
                          @"height" : @(180),
                          @"weight" : @(195),
                          };
    person *personB = [person objectWithKeyValues:dic];
    [personB printAllValue];
    
    NSDictionary  *keyValues = [personB keyValuesWithObject];
    NSLog(@"keyValues: %@",keyValues);

    
    /**
     *  3.设置关联 --- 分类添加属性
     */
    [_btnCenter setBtnClickBlock:^{
        NSLog(@"runtime Category click");
    }];
    
    
    //3.Method Swizzling 方法交换
    Method orginMethod = class_getInstanceMethod([UIView class], @selector(touchesBegan:withEvent:));
    Method customMethod = class_getInstanceMethod([self class], @selector(customtouchesBegan:withEvent:));
    method_exchangeImplementations(orginMethod, customMethod);
    
}

-(void)customtouchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",touches);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
