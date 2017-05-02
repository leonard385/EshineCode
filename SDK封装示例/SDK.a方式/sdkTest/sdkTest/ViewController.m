//
//  ViewController.m
//  sdkTest
//
//  Created by 倪望龙 on 2017/4/28.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "ViewController.h"
#import "mySDK.h"
@interface ViewController ()
@property(nonatomic,strong)myView *customView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _customView = [[myView alloc]init];
    _customView.frame = CGRectMake(0, 0, 300, 200);
    [self.view addSubview:self.customView];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
