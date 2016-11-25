//
//  GuideViewController.m
//  ChangeOrientation
//
//  Created by Harvey on 16/6/6.
//  Copyright © 2016年 Haley. All rights reserved.
//

#import "GuideViewController.h"
#import "MainViewController.h"
#import "BaseNavigationController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
//    label.text = @"这是引导页";
//    label.center = self.view.center;
//    [self.view addSubview:label];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    btn.backgroundColor = [UIColor lightGrayColor];
    btn.center = self.view.center;
    [btn setTitle:@"这是引导页，进入主页" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(enterMain) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)enterMain
{
    MainViewController *mainVC = [[MainViewController alloc] init];
    BaseNavigationController *baseNaVC = [[BaseNavigationController alloc] initWithRootViewController:mainVC];
    [self presentViewController:baseNaVC animated:YES completion:nil];
}

@end
