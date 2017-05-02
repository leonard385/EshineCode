//
//  ViewController.m
//  frameWorkTestDemo
//
//  Created by 倪望龙 on 2017/5/2.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ViewController.h"
#import "frameWorkTest/frameWorkTest.h"
@interface ViewController ()
@property(nonatomic,strong)MyTool *tool;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tool = [MyTool new];
    [_tool printName:@"frameWork打印的库"];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
