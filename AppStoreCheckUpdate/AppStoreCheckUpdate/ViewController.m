//
//  ViewController.m
//  AppStoreCheckUpdate
//
//  Created by 逸信Mac on 16/7/7.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "ViewController.h"
#import "QJCheckVersionUpdate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    QJCheckVersionUpdate *Version = [[QJCheckVersionUpdate alloc]init];
    [Version showAlertView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
